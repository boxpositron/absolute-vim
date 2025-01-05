return {
	"huggingface/llm.nvim",
	enabled = false,
	config = function()
		require("absolute.after.llm")
	end,
}
