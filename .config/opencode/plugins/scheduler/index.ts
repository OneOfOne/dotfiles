// opencode prompt scheduler plugin — schedule prompts at specific times

import { tool } from '@opencode-ai/plugin';
import type { OpencodeClient } from '@opencode-ai/sdk';

type PluginInput = {
	client: OpencodeClient;
	project: unknown;
	directory: string;
	worktree: string;
	experimental_workspace: { register(type: string, adapter: unknown): void };
	serverUrl: URL;
	$: typeof import('bun')['$'];
};

type BunShell = PluginInput['$'];

const SCHEDULE_FILE = '.opencode/schedules.json';

interface ScheduleEntry {
	id: string;
	message: string;
	nextRun: number;
	intervalMs?: number;
	sessionID?: string;
}

type TimerHandle = ReturnType<typeof setTimeout>;

let schedules = new Map<string, ScheduleEntry>();
const timerHandles = new Map<string, TimerHandle>();
let persistTimer: ReturnType<typeof setTimeout> | null = null;
let clientRef: OpencodeClient | null = null;
let $Ref: BunShell | null = null;
let dirRef: string | null = null;

// --- Persistence helpers ---
async function loadSchedules(): Promise<void> {
	try {
		const data: unknown = JSON.parse(await Bun.file(SCHEDULE_FILE).text());
		if (typeof data !== 'object' || data === null) return;
		const entries: [string, ScheduleEntry][] = [];
		for (const [key, val] of Object.entries(data)) {
			if (typeof val === 'object' && val !== null && typeof (val as Record<string, unknown>).id === 'string') {
				entries.push([key, val as ScheduleEntry]);
			}
		}
		schedules = new Map(entries);
	} catch {
		// File doesn't exist or is invalid
	}
}

async function saveSchedules(): Promise<void> {
	if (dirRef && $Ref) {
		try {
			await $Ref`mkdir -p "${dirRef}/.opencode"`;
		} catch {
			// Ignore errors
		}
	}

	Bun.write(SCHEDULE_FILE, JSON.stringify(Object.fromEntries(schedules), null, 2));
}

function debounceSave(): void {
	if (persistTimer) clearTimeout(persistTimer);
	persistTimer = setTimeout(saveSchedules, 500);
}

// --- Schedule management ---
type TimeUnit = 'second' | 'minute' | 'hour' | 'day';

const TIME_MULTIPLIERS: Record<TimeUnit, number> = {
	second: 1000,
	minute: 60_000,
	hour: 3_600_000,
	day: 86_400_000,
};

function formatInterval(ms: number): string {
	if (ms >= 86_400_000) return `${ms / 86_400_000} day(s)`;
	if (ms >= 3_600_000) return `${ms / 3_600_000} hour(s)`;
	if (ms >= 60_000) return `${ms / 60_000} minute(s)`;
	return `${ms / 1_000} second(s)`;
}

function scheduleTimer(id: string, entry: ScheduleEntry, contextSessionID?: string): void {
	cancelTimer(id);
	const delay = Math.max(0, entry.nextRun - Date.now());

	const handle = setTimeout(async () => {
		const client = clientRef;
		const targetSession = entry.sessionID || contextSessionID;
		if (!client || !targetSession) {
			console.error(`[opencode-scheduler] Schedule ${id}: no session available`);
			return;
		}

		// Send the scheduled prompt
		try {
			await client.session.prompt({
				path: { id: targetSession },
				body: {
					parts: [{ type: 'text', text: entry.message }],
				},
			});
		} catch (err) {
			console.error(`[opencode-scheduler] Failed to send prompt for schedule ${id}:`, err);
		}

		// Reschedule if recurring
		if (entry.intervalMs) {
			entry.nextRun = Date.now() + entry.intervalMs;
			schedules.set(id, entry);
			debounceSave();
			scheduleTimer(id, entry, contextSessionID);
		} else {
			// One-shot — remove after execution
			schedules.delete(id);
			debounceSave();
		}
	}, delay);

	timerHandles.set(id, handle);
}

function cancelTimer(id: string): void {
	const handle = timerHandles.get(id);
	if (handle) {
		clearTimeout(handle);
		timerHandles.delete(id);
	}
}

function generateId(): string {
	return crypto.randomUUID();
}

// --- Parse human-readable delay ("in 5 minutes", "in 1 hour") ---
function parseDelay(text: string): number | null {
	const lower = text.toLowerCase().trim();

	// Relative time patterns
	const relMatch = lower.match(/^in\s+(\d+)\s*(second|minute|hour|day)s?/);
	if (relMatch?.[1] && relMatch[2]) {
		const val = parseInt(relMatch[1], 10);
		const unit = relMatch[2] as TimeUnit;
		return val * TIME_MULTIPLIERS[unit];
	}

	// Absolute time "HH:MM" (24h)
	const timeMatch = lower.match(/^(\d{1,2}):(\d{2})$/);
	if (timeMatch?.[1] && timeMatch[2]) {
		const hr = parseInt(timeMatch[1], 10);
		const min = parseInt(timeMatch[2], 10);
		const now = new Date();
		const target = new Date(now.getTime());
		target.setHours(hr, min, 0, 0);
		if (target.getTime() <= now.getTime()) {
			target.setDate(target.getDate() + 1); // tomorrow
		}
		return target.getTime() - now.getTime();
	}

	return null;
}

// --- Parse recurrence ("every 30 minutes", "every hour", "every day") ---
function parseRecurrence(text: string): { intervalMs: number } | null {
	const lower = text.toLowerCase().trim();

	// "every N minutes/hours/days"
	const everyMatch = lower.match(/^every\s+(\d+)\s*(second|minute|hour|day)s?/);
	if (everyMatch?.[1] && everyMatch[2]) {
		const val = parseInt(everyMatch[1], 10);
		const unit = everyMatch[2] as TimeUnit;
		return { intervalMs: val * TIME_MULTIPLIERS[unit] };
	}

	return null;
}

// --- Main plugin factory ---
export const Scheduler = async (input: PluginInput): Promise<{ tool: Record<string, unknown> }> => {
	const { client, $, directory } = input;
	clientRef = client;
	$Ref = $;
	dirRef = directory;

	await loadSchedules();

	// Restore existing schedules' timers
	for (const [id, entry] of schedules) {
		if (entry.nextRun > Date.now()) {
			scheduleTimer(id, entry);
		} else if (entry.intervalMs) {
			entry.nextRun = Date.now() + entry.intervalMs;
			schedules.set(id, entry);
			scheduleTimer(id, entry);
		} else {
			schedules.delete(id); // expired one-shot
		}
	}

	return {
		tool: {
			schedule_prompt: tool({
				description:
					"Schedule a prompt to be sent at a specific time. Supports: absolute times ('14:30'), relative delays ('in 5 minutes', 'in 1 hour'), and recurrence ('every 10 seconds', 'every 30 minutes').",
				args: {
					message: tool.schema.string().describe('The prompt text to schedule'),
					when: tool.schema.string().describe("When to run. Examples: '14:30' (at 2:30 PM), 'in 5 minutes', 'every 30 minutes'"),
					session_id: tool.schema.string().optional().describe('Target session ID. If omitted, uses current session.'),
				},
				async execute(args, context) {
					const sessionID = args.session_id ?? context.sessionID;

					// Parse "when" — try recurrence first, then absolute/relative time
					let nextRun: number;
					let intervalMs: number | undefined;

					const recurrence = parseRecurrence(args.when);
					if (recurrence) {
						intervalMs = recurrence.intervalMs;
						// For recurring, first run is now
						nextRun = Date.now();
					} else {
						const delay = parseDelay(args.when);
						if (delay !== null) {
							nextRun = Date.now() + delay;
						} else {
							return `Could not parse time spec: "${args.when}". Try: "14:30", "in 5 minutes", "every 10 seconds", or "every 30 minutes".`;
						}
					}

					const id = generateId();
					const entry = {
						id,
						message: args.message,
						nextRun,
						intervalMs,
						sessionID,
					};

					schedules.set(id, entry);
					debounceSave();
					scheduleTimer(id, entry, context.sessionID);

					if (intervalMs) {
						return `Scheduled (recurring, every ${formatInterval(intervalMs)}): "${args.message}" → ID: ${id}`;
					}

					const timeLabel = new Date(nextRun).toLocaleTimeString();
					return `Scheduled for ${timeLabel}: "${args.message}" → ID: ${id}`;
				},
			}),

			// List active schedules
			list_schedules: tool({
				description: 'List all currently scheduled prompts',
				args: {},
				async execute() {
					if (schedules.size === 0) return 'No active schedules.';

					const lines: string[] = [];
					for (const [, entry] of schedules) {
						const when = new Date(entry.nextRun).toLocaleTimeString();
						const type = entry.intervalMs ? `recurring (${formatInterval(entry.intervalMs)})` : 'one-shot';
						lines.push(`  [${entry.id}] ${type} — next: ${when} — "${entry.message}"`);
					}
					return `Active schedules (${schedules.size}):\n${lines.join('\n')}`;
				},
			}),

			// Cancel a schedule by ID
			cancel_schedule: tool({
				description: 'Cancel a scheduled prompt by its ID',
				args: {
					id: tool.schema.string().describe('The schedule ID to cancel'),
				},
				async execute(args) {
					const entry = schedules.get(args.id);
					if (!entry) return `No schedule found with ID: ${args.id}`;

					cancelTimer(args.id);
					schedules.delete(args.id);
					debounceSave();
					return `Cancelled schedule: "${entry.message}"`;
				},
			}),
		},
	};
};
