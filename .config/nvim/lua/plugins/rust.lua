return {
	{
		'mrcjkb/rustaceanvim',
		ft = { 'rust' },
		opts = function(_, opts)
			opts.server = opts.server or {}
			opts.server.settings = opts.server.settings or {}
			opts.server.settings['rust-analyzer'] = opts.server.settings['rust-analyzer'] or {}
			opts.server.settings['rust-analyzer'].procMacro = { enable = true }
			return opts
		end,
	},
}
