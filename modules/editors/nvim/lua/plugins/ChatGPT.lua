return {
	"yefengwu/ChatGPT.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "<Leader>y", "<cmd>:ChatGPT<CR>", desc = "ChatGPT" },
	},

	config = function()
		require("chatgpt").setup({
			api_key_cmd = "bw list items --search GPT_API_FREE | from json | get notes",
		})
	end,
}
