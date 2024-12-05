return {
	"folke/noice.nvim",
	event = "User BaseDefered",
	cmd = "Noice",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<C-b>",
			function()
				if not require("noice.lsp").scroll(-4) then
					return "<C-b>"
				end
			end,
			mode = { "n", "i", "s" },
			silent = true,
			expr = true,
		},
		{
			"<C-f>",
			function()
				if not require("noice.lsp").scroll(4) then
					return "<C-f>"
				end
			end,
			mode = { "n", "i", "s" },
			silent = true,
			expr = true,
		},
	},
	opts = {
		popupmenu = {
			backend = "cmp",
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			progress = {
				enabled = true,
			},
			hover = {
				enabled = true,
				opts = {
					size = { max_width = 50 },
				},
				silent = true,
			},
			signature = {
				enabled = false,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
			command_palette = {
				views = {
					hover = {
						size = {
							max_height = 10,
						},
					},
					cmdline_popup = {
						position = {
							row = "50%",
							col = "50%",
						},
						-- size = {
						--     min_width = 60,
						--     width = "auto",
						--     height = "auto",
						-- },
					},
				},
			},
		},
		views = {
			mini = {
				win_options = {
					winblend = 0,
				},
			},
			confirm = {
				position = {
					row = "50%",
					col = "50%",
				},
			},
		},
		routes = {
			{
				filter = { event = "msg_show", kind = "search_count" },
				opts = { skip = true },
			},
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
			{
				view = "split",
				filter = { event = "msg_show", min_height = 20 },
			},
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
						{ find = "Agent service not initialized." }, -- TODO: Caused by wakatime, let's see until next update
						{ find = "Failed to set cursor" },
					},
				},
			},
			{ filter = { event = "msg_show", find = "^[/?]." }, skip = true }, -- unneeded info on search patterns
			{ filter = { event = "msg_show", find = "E211: File .* no longer available" }, skip = true },
		},
	},
}
