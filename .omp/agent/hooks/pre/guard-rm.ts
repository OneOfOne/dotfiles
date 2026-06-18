// ~/.omp/agent/hooks/pre/guard-rm.ts
import type { HookAPI } from '@oh-my-pi/pi-coding-agent/extensibility/hooks';

const DANGER = /\brm\s+(-[a-zA-Z]*r[a-zA-Z]*f[a-zA-Z]*|-[a-zA-Z]*f[a-zA-Z]*r[a-zA-Z]*)\s+(\/|~|\$HOME)(\s|$)/;

export default function (pi: HookAPI) {
	pi.on('tool_call', (event) => {
		if (event.toolName !== 'bash') return;
		const cmd = String(event.input.command ?? '');
		if (DANGER.test(cmd)) {
			return { block: true, reason: `Refused: ${cmd.slice(0, 80)}` };
		}
	});
}
