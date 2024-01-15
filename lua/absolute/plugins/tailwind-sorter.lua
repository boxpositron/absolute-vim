return {
	"laytan/tailwind-sorter.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
	build = "cd formatter && npm i && npm run build",
	config = function()
		require("absolute.after.tailwind-sorter")
	end,
}
