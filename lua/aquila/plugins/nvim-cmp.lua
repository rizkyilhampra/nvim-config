return {
	-- NOTE: see https://www.reddit.com/r/neovim/comments/1fwy06w/magazinenvim_a_beta_nvimcmp_to_fix_bugs_implement/
	-- and also specific PR https://github.com/hrsh7th/nvim-cmp/pull/1980
	"iguanacucumber/magazine.nvim",
	name = "nvim-cmp",
	event = {
		"InsertEnter",
		"CmdlineEnter",
	},
	dependencies = {
		"FelipeLema/cmp-async-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-calc",
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		{
			"petertriho/cmp-git",
			opts = {
				filetypes = { "gitcommit", "markdown" },
			},
		},
		"f3fora/cmp-spell",
		"hrsh7th/cmp-buffer",
		"luckasRanarison/tailwind-tools.nvim",
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()

		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local utils = require("aquila.core.utils")

		local border_opts = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		}

		cmp.setup({
			matching = {
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_partial_matching = false,
				disallow_prefix_unmatching = true,
			},
			performance = {
				debounce = 0,
				throttle = 0,
			},
			view = {
				entries = {
					follow_cursor = true,
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(border_opts),
				documentation = cmp.config.window.bordered(border_opts),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Esc>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping(function(fallback)
					local copilot = require("copilot.suggestion")
					if copilot.is_visible() then
						copilot.accept()
					elseif cmp.visible() then
						local entry = cmp.get_selected_entry()
						if not entry then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							cmp.confirm()
						end
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 1000 },
				{ name = "luasnip", priority = 750 },
				{ name = "buffer", priority = 500 },
				{ name = "async_path", priority = 250 },
				{ name = "calc" },
				{
					name = "git",
					entry_filter = function()
						local allowed_filetypes = { "gitcommit", "markdown" }
						if not vim.tbl_contains(allowed_filetypes, vim.bo.filetype) then
							return false
						end

						return true
					end,
				},
				{
					name = "spell",
					option = {
						preselect_correct_word = false,
					},
					priority = 300,
					max_item_count = 3,
				},
			}),
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, item)
					local kind = lspkind.cmp_format(utils.get_plugin_opts("lspkind.nvim"))(entry, item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = (strings[3] or "")

					local doc = entry.completion_item.documentation
					if kind.menu == "Color" and doc then
						local content = type(doc) == "string" and doc or doc.value
						local config = require("tailwind-tools.config")
						local tailwind_tools_utils = require("tailwind-tools.utils")
						local r, g, b = tailwind_tools_utils.extract_color(content)
						local style = config.options.cmp.highlight

						if r then
							kind.kind_hl_group = tailwind_tools_utils.set_hl_from(r, g, b, style)
						end
					end

					return kind
				end,
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "async_path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
	end,
}
