local llm = require("llm")
local llmCompletion = require("llm.completion")

llm.setup({
	api_token = nil, -- cf Install paragraph
	model = "codellama:13b", -- the model ID, behavior depends on backend
	backend = "ollama", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
	url = "http://localhost:11434", -- the http url of the backend
	-- tokens_to_clear = { "<|endoftext|>" }, -- tokens to remove from the model's output
	tokens_to_clear = { "<EOT>" },
	-- parameters that are added to the request body, values are arbitrary, you can set any field:value pair here it will be passed as is to the backend
	request_body = {
		parameters = {
			-- max_new_tokens = 60,
			temperature = 0.2,
			top_p = 0.95,
		},
	},
	-- set this if the model supports fill in the middle
	-- fim = {
	-- 	enabled = false,
	-- 	prefix = "<fim_prefix>",
	-- 	middle = "<fim_middle>",
	-- 	suffix = "<fim_suffix>",
	-- },
	fim = {
		enabled = true,
		prefix = "<PRE> ",
		middle = " <MID>",
		suffix = " <SUF>",
	},

	debounce_ms = 150,
	accept_keymap = nil,
	dismiss_keymap = nil,
	tls_skip_verify_insecure = false,
	-- llm-ls configuration, cf llm-ls section

	lsp = {
		bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
		cmd_env = { LLM_LOG_LEVEL = "DEBUG" },
	},
	-- tokenizer = nil, -- cf Tokenizer paragraph
	tokenizer = {
		repository = "codellama/CodeLlama-13b-hf",
	},
	context_window = 4096,
	enable_suggestions_on_startup = false,
	enable_suggestions_on_files = { "*.py", "*.js", "*.ts", "*.astro", "*.vue", "*.lua" },
	disable_url_path_completion = false, -- cf Backend
})

vim.keymap.set("i", "<Tab>", function()
	if llmCompletion.shown_suggestion ~= nil then
		llmCompletion.complete()
	else
		local keys = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", false)
	end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Tab>", function()
	if llmCompletion.shown_suggestion ~= nil then
		llmCompletion.complete()
	else
		local keys = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
		vim.api.nvim_feedkeys(keys, "n", false)
	end
end, { noremap = true, silent = true })

-- Debounce helper
local debounce = function(func, timeout)
	if type(func) ~= "function" then
		error("Expected a function")
	end
	if type(timeout) ~= "number" or timeout <= 0 then
		error("Expected a positive number for timeout")
	end
	local timer = vim.uv.new_timer()
	return function(...)
		local args = { ... }
		timer:stop() -- Reset the timer
		timer:start(
			timeout,
			0,
			vim.schedule_wrap(function()
				func(unpack(args))
			end)
		)
	end
end
-- Define the function to be executed
local function on_text_change()
	llmCompletion.lsp_suggest()
end

-- Debounce the function
local debounced_on_text_change = debounce(on_text_change, 3000)

-- Set up the autocommand
vim.api.nvim_create_autocmd({ "InsertCharPre" }, {
	pattern = "*",
	callback = debounced_on_text_change,
	desc = "Run method after typing stops with debounce",
})
