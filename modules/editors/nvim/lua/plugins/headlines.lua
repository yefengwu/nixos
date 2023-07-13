return {
	"lukas-reineke/headlines.nvim",
	dependencies = "nvim-treesitter/nvim-treesitter",
	ft = { "norg", "markdown", "orgmode" },
	config = function()
		require("headlines").setup({
			markdown = {
				headline_highlights = {
					"Headline1",
					"Headline2",
					"Headline3",
					"Headline4",
					"Headline5",
					"Headline6",
				},
				codeblock_highlight = "CodeBlock",
				dash_highlight = "Dash",
				dash_string = "-",
				quote_highlight = "Quote",
				quote_string = "┃",
				fat_headlines = true,
				fat_headline_upper_string = " ",
				fat_headline_lower_string = "_",
			},
		})
	end,
}
