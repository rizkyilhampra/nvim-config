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
		{ "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp" },
		{ "iguanacucumber/mag-buffer", name = "cmp-buffer" },
		{ "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
		"FelipeLema/cmp-async-path",
		"hrsh7th/cmp-calc",
		"saadparwaiz1/cmp_luasnip",
		"f3fora/cmp-spell",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local utils = require("aquila.core.utils")
		local types = require("cmp.types")
		local provider = vim.g.inline_code_completion_provider

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		local function deprioritize_snippet(entry1, entry2)
			if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
				return false
			end
			if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
				return true
			end
		end

		local border_opts = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		}

		cmp.setup({
			sorting = {
				priority_weight = 2,
				comparators = {
					deprioritize_snippet,
					cmp.config.compare.exact,
					cmp.config.compare.locality,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.offset,
					cmp.config.compare.sort_text,
					cmp.config.compare.order,
				},
			},
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
					if provider == "copilot" then
						local copilot_loaded, copilot = pcall(require, "copilot.suggestion")
						if copilot_loaded and copilot.is_visible() then
							copilot.accept()
						end
					elseif provider == "supermaven" then
						local supermaven_loaded, supermaven = pcall(require, "supermaven-nvim.completion_preview")
						if supermaven_loaded and supermaven.has_suggestion() then
							supermaven.on_accept_suggestion()
						end
					elseif cmp.visible() then
						local entry = cmp.get_selected_entry()
						if not entry then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							cmp.confirm()
						end
					elseif luasnip.expand_or_locally_jumpable() then
						if check_backspace() then
							fallback()
						else
							luasnip.expand_or_jump()
						end
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
					name = "lazydev",
					entry_filter = function()
						local allowed_filetypes = { "lua" }
						if not vim.tbl_contains(allowed_filetypes, vim.bo.filetype) then
							return false
						end

						return true
					end,
					group_index = 0,
				},
				{
					name = "spell",
					option = {
						preselect_correct_word = false,
					},
					priority = 300,
					max_item_count = 3,
				},
				{
					name = "html-css",
					priority = 900,
					option = {
						enable_on = { "html", "php", "javascriptreact", "typescriptreact" },
						notify = false,
						documentation = {
							auto_show = true,
						},
						style_sheets = {
							"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
						},
					},
				},
			}),
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, item)
					local kind = lspkind.cmp_format(utils.get_plugin_opts("lspkind.nvim"))(entry, item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = (strings[3] or "")

					if entry.source.name == "html-css" then
						kind.menu = entry.completion_item.provider or kind.menu
					end

					local doc = entry.completion_item.documentation
					if kind.menu == "Color" and doc then
						local tailwind_tools_installed = pcall(require, "tailwind-tools")
						if not tailwind_tools_installed then
							return kind
						end

						local config = require("tailwind-tools.config")
						local tailwind_tools_utils = require("tailwind-tools.utils")
						local content = type(doc) == "string" and doc or doc.value
						local r, g, b = tailwind_tools_utils.extract_color(content)
						local style = config.options.cmp.highlight

						if r then
							kind.kind_hl_group = tailwind_tools_utils.set_hl_from(r, g, b, style)
						end
					end

					item.dup = ({
						["html-css"] = 0,
					})[entry.source.name] or 0

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
