-- Setup language servers.
local conform = require("conform")
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local opts = { noremap = true, silent = true }

local global_node_modules = vim.fn.system("npm root -g")

-- client, buffer
local on_attach = function(client, bufnr)
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
	vim.keymap.set({ "n", "v" }, "<leader>f", function()
		-- vim.lsp.buf.format({ async = true })
		conform.format({
			bufnr = opts.buffer,
			async = true,
			lsp_fallback = true,
		})
	end, opts)

	opts.desc = "Restart LSP"
	vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

	-- LSP Only Settings
	-- Ruff & Pyright behaviour
	if client.name == "ruff" then
		-- Disable hover in favor of Pyright
		client.server_capabilities.hoverProvider = false
	end
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
				location = global_node_modules .. "@vue/typescript-plugin",
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

-- configure ruff server
lspconfig["ruff"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

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
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
	settings = {
		typescript = {
			inlayHints = {
				enumMemberValues = {
					enabled = true,
				},
				functionLikeReturnTypes = {
					enabled = true,
				},
				propertyDeclarationTypes = {
					enabled = true,
				},
				parameterTypes = {
					enabled = true,
					suppressWhenArgumentMatchesName = true,
				},
				variableTypes = {
					enabled = true,
				},
			},
		},
	},
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

-- configure astro server
lspconfig["astro"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	-- init_options = {
	-- 	typescript = {
	-- 		tsdk = ResolveTypescriptServer(),
	-- 	},
	-- },
})

-- configure kotlin server
lspconfig["kotlin_language_server"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure clang server

lspconfig["clangd"].setup({
	cmd = { "clangd", "--compile-commands-dir=./", "--background-index=false" },
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "c", "cpp", "objc", "objcpp" },
})

-- configure bufls server

lspconfig["buf_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "proto" },
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
