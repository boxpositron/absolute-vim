local jupytext = require("jupytext")

jupytext.setup({
	style = "markdown",
	output_extension = "md", -- Default extension. Don't change unless you know what you are doing
	force_ft = "markdown", -- Default filetype. Don't change unless you know what you are doing
	custom_language_formatting = {},
})
