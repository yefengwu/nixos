return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{ "<A-p>", "<cmd>Telescope commands<CR>", desc = "telescope" },
		{ "<Leader>f", "<cmd>Telescope find_files<CR>", desc = "telescope" },
		{ "<Leader>p", "<cmd>Telescope project<CR>", desc = "telescope" },
		{ "<Leader>s", "<cmd>Telescope live_grep<CR>", desc = "telescope" },
	},
	dependencies = { "nvim-telescope/telescope-media-files.nvim", "nvim-telescope/telescope-project.nvim" },
	config = function()
		local status_ok, telescope = pcall(require, "telescope")
		if not status_ok then
			return
		end

		telescope.load_extension("media_files")
		telescope.load_extension("project")

		local actions = require("telescope.actions")
		local project_actions = require("telescope._extensions.project.actions")

		telescope.setup({
			defaults = {

				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "truncate" },
				color_devicons = true,
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
					horizontal = {
						width_padding = 0.04,
						height_padding = 0.1,
						preview_width = 0.6,
					},
					vertical = {
						width_padding = 0.05,
						height_padding = 1,
						preview_height = 0.5,
					},
				},

				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,

						["<C-c>"] = actions.close,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,

						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.complete_tag,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
						["<esc>"] = actions.close,
					},

					n = {
						["<esc>"] = actions.close,
						["q"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["H"] = actions.move_to_top,
						["M"] = actions.move_to_middle,
						["L"] = actions.move_to_bottom,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["?"] = actions.which_key,
					},
				},
			},
			pickers = {
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
				-- }
				-- Now the picker_config_key will be applied every time you call this
				-- builtin picker
			},
			extensions = {
				media_files = {
					-- filetypes whitelist
					-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
					filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "pdf", "webm" },
					find_cmd = "rg", -- find command (defaults to `fd`)
				},
				project = {
					hidden_files = false, -- default: false
					theme = "dropdown",
					order_by = "asc",
					search_by = "title",
					sync_with_nvim_tree = true, -- default false
					-- default for on_project_selected = find project files
					on_project_selected = function(prompt_bufnr)
						-- Do anything you want in here. For example:
						project_actions.change_working_directory(prompt_bufnr, false)
						require("harpoon.ui").nav_file(1)
					end,
				},
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
			},
		})
	end,
}
