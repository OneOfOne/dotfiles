import type { HookAPI } from '@oh-my-pi/pi-coding-agent/extensibility/hooks';

export default function myHook(omp: HookAPI): void {
	omp.on('tool_call', async (event, ctx) => {
		// Check bash commands for deletion, sudo, and git push
		if (event.toolName === 'bash') {
			const cmd = String(event.input.command ?? '');

			// 1. Completely block sudo
			if (/\bsudo\b/.test(cmd)) {
				return {
					block: true,
					reason: "Execution of 'sudo' is strictly disabled in this environment.",
				};
			}

			// 2. Completely block git push
			if (/\bgit\s+push\b/.test(cmd)) {
				return {
					block: true,
					reason: "Execution of 'git push' is strictly disabled to prevent remote overrides.",
				};
			}

			// 3. Ask before deleting files (retained from prior setup)
			if (/\b(rm|unlink)\b/.test(cmd) && ctx.hasUI) {
				const allowed = await ctx.ui.confirm(
					'Confirm File Deletion',
					`The agent wants to execute a terminal deletion command:\n"${cmd}"\n\nDo you want to allow this?`,
				);

				if (!allowed) {
					return {
						block: true,
						reason: 'User denied terminal file deletion request.',
					};
				}
			}
		}

		// 4. Ask before native OMP tools delete files (retained from prior setup)
		if ((event.toolName === 'str_replace_editor' || event.toolName === 'file_patch') && ctx.hasUI) {
			const viewOptions = event.input.view_options ?? {};
			const newContent = String(event.input.new_content ?? '');
			// @ts-expect-error
			const isRemoving = viewOptions.mode === 'remove' || (newContent === '' && event.input.old_content);

			if (isRemoving) {
				const allowed = await ctx.ui.confirm(
					'Confirm Native File Deletion',
					`The agent is attempting to delete or clear a file using native editing tools.\n\nDo you want to allow this?`,
				);

				if (!allowed) {
					return {
						block: true,
						reason: 'User denied native tool file deletion request.',
					};
				}
			}
		}
	});
}
