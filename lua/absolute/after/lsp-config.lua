-- Setup language servers.
local conform = require("conform")
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
	.. "/node_modules/@vue/language-server"

-- local DPE = require("absolute.utils.detect-python-env")

local opts = { noremap = true, silent = true }

-- client, buffer
local on_attach = function(_, bufnr)
	opts.buffer = bufnr

	-- Enable completion triggered by <c-x><c-o>
	vim.bo[opts.buffer].omnifunc = "v:lua.vim.lsp.omnifunc"

	opts.desc = "Go to declaration"
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Go to definitions"
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

	opts.desc = "Show documentation for what is under cursor"
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	opts.desc = "Show LSP Implementation"
	vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

	opts.desc = "Get Help"
	vim.keymap.set("n", "<leader>gh", vim.lsp.buf.signature_help, opts)

	-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
	-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
	-- vim.keymap.set('n', '<leader>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, opts)

	opts.desc = "Show LSP type definitions"
	vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	opts.desc = "Smart rename"
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "See available code actions"
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "Show LSP references"
	vim.keymap.set("n", "<leader>cr", "<cmd>Telescope lsp_references<CR>", opts)

	opts.desc = "Format File"
	vim.keymap.set("n", "<leader>f", function()
		-- vim.lsp.buf.format({ async = true })
		conform.format({
			bufnr = opts.buffer,
			async = true,
			lsp_fallback = true,
		})
	end, opts)

	opts.desc = "Restart LSP"
	vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = {
	Error = " ",
	Warn = " ",
	Hint = "󰠠 ",
	Info = " ",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
lspconfig["ts_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "svelte", "vue", "astro" },
})

-- configure svelte server
lspconfig["svelte"].setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			callback = function(ctx)
				if client.name == "svelte" then
					client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
				end
			end,
		})
	end,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {
		"html",
		"typescriptreact",
		"javascriptreact",
		"astro",
		"css",
		"sass",
		"scss",
		"less",
		"svelte",
		"vue",
	},
})

-- configure python lsp
-- lspconfig["pylsp"].setup({
-- 	filetypes = { "python" },
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	pylsp = {
-- 		pylsp = {
-- 			plugins = {
-- 				rope_autoimport = {
-- 					enabled = true,
-- 					completions = { enabled = true },
-- 					rename = { enabled = false },
-- 				},
-- 				black = { enabled = true },
-- 				autopep8 = { enabled = false },
-- 				yapf = { enabled = false },
-- 				flake8 = { enabled = true },
-- 				-- jedi_completion = {
-- 				-- 	enabled = true,
-- 				-- 	include_params = true,
-- 				-- 	fuzzy = true,
-- 				-- },
-- 				pylsp_mypy = {
-- 					enabled = true,
-- 					overrides = DPE.ResolvePythonEnvironment(),
-- 					report_progress = true,
-- 					live_mode = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

-- configure pyright server
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "python" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
})

-- configure docker server
lspconfig["dockerls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure json server
lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure vue server
lspconfig["volar"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "vue" },
})

-- configure rust server
lspconfig.rust_analyzer.setup({
	-- Server-specific settings. See `:help lspconfig-setup`
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {},
	},
})

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- -- configure htmx server
-- lspconfig["htmx"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

--configure docker file server
lspconfig["dockerls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure docker compose server
lspconfig["docker_compose_language_service"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure eslint server
lspconfig["eslint"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

local function trim(s)
	return s:gsub("^%s*(.-)%s*$", "%1")
end

local ResolveTypescriptServer = function()
	-- Find the package.json file
	local viable = vim.fn.system("find . -name 'package.json' -maxdepth 2 | xargs dirname")
	viable = trim(viable)

	if viable == "" then
		return nil
	end

	-- Check for lock files
	local find_npm_result = trim(vim.fn.system("find . -name 'package-lock.json' -maxdepth 2 | wc -l"))
	local find_pnpm_result = trim(vim.fn.system("find . -name 'pnpm-lock.yaml' -maxdepth 2 | wc -l"))
	local find_yarn_result = trim(vim.fn.system("find . -name 'yarn.lock' -maxdepth 2 | wc -l"))

	local is_npm = find_npm_result == "1"
	local is_pnpm = find_pnpm_result == "1"
	local is_yarn = find_yarn_result == "1"

	-- if no package lock files are found, end early
	if not is_npm and not is_pnpm and not is_yarn then
		return nil
	end

	-- Determine the preferred package manager
	local ppm = "pnpm" -- Default to pnpm
	if is_npm then
		ppm = "npm"
	end
	if is_yarn then
		ppm = "yarn"
	end

	-- Resolve TypeScript server path
	local base_command = ppm .. " list typescript --dir " .. viable .. " --json"
	local base_result = trim(vim.fn.system(base_command))

	if base_result == "" then
		vim.notify("Failed to run " .. base_command, vim.log.levels.ERROR)
		return nil
	end

	local typescript_path = nil

	if ppm == "pnpm" or ppm == "npm" or ppm == "yarn" then
		local ok, parsed = pcall(vim.fn.json_decode, base_result)
		if ok and parsed and #parsed > 0 and parsed[1].path then
			typescript_path = parsed[1].path .. "/node_modules/typescript/lib"
		end
	end

	if not typescript_path or typescript_path == "" then
		vim.notify("TypeScript not found. Please install TypeScript globally or in the project.", vim.log.levels.ERROR)
		return nil
	end

	vim.notify("Using TypeScript server from " .. typescript_path, vim.log.levels.WARN)
	return typescript_path
end

-- configure astro server
lspconfig["astro"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		typescript = {
			tsdk = ResolveTypescriptServer(),
		},
	},
})

-- configure kotlin server
lspconfig["kotlin_language_server"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure clang server

lspconfig["clangd"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure arduino language server

lspconfig["arduino_language_server"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure biome server
lspconfig["biome"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"astro",
		"svelte",
		"vue",
	},
})
