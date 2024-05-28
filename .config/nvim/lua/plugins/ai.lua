return {
	{
		'jellydn/gen.nvim',
		opts = {
			model = 'llama3:8b-instruct-fp16', -- The default model to use.
			host = 'localhost', -- The host running the Ollama service.
			port = '11434', -- The port on which the Ollama service is listening.
			quit_map = 'q', -- set keymap for close the response window
			retry_map = '<c-r>', -- set keymap to re-send the current prompt
			display_mode = 'float', -- The display mode. Can be "float" or "split".
			show_prompt = true, -- Shows the prompt submitted to Ollama.
			show_model = true, -- Displays which model you are using at the beginning of your chat session.
			no_auto_close = true, -- Never closes the window automatically.
			debug = true, -- Prints errors and the command which is run.
		},
	},
}
