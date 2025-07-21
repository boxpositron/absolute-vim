return {
	default_config = {
		cmd = { "pb", "lsp" },
		filetypes = { "proto" },
		single_file_support = true,
		root_dir = require("lspconfig.util").root_pattern(".git"),
	},
}
