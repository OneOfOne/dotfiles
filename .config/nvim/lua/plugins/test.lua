return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"rouge8/neotest-rust",
		},
		opts = {
			adapters = {
				["neotest-rust"] = {
					args = { "--no-capture" },
				},
			},
		},
	}
}
