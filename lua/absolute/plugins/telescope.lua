return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim'},
      requires = {
	{
        	"nvim-telescope/telescope-fzf-native.nvim",
        	run = "make"
      	},
      	{
        	"nvim-telescope/telescope-dap.nvim"
      	}
      },
      config = function()
		require("absolute.after.telescope")
	end
    }
