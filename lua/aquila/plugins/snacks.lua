local utils = require("aquila.core.utils")

return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		picker = {},
	},
	keys = {
		{
			"<Leader><Tab>",
			function()
				require("snacks").picker.recent({
					filter = {
						cwd = true,
					},
					limit = 10,
					focus = "list",
					layout = "select",
				})
			end,
			desc = "Recent files",
		},
		{
			"<Leader>gda",
			function()
				require("snacks").picker.git_diff({
					focus = "list",
				})
			end,
			desc = "Diff current branch against HEAD",
		},
		{
			"<Leader>gdb",
			function()
                -- NOTE: Stoled from https://www.reddit.com/r/neovim/comments/1kxbcrs/tip_use_snackspicker_to_see_git_diff_with_current/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
				require("snacks").picker.git_diff({
					focus = "list",
					finder = function(opts, ctx)
						local file, line
						local header, hunk = {}, {}
						local header_len = 4

						local current_branch = vim.fn.trim(vim.fn.system("git rev-parse --abbrev-ref HEAD"))
						local upstream = vim.fn.trim(
							vim.fn.system("git rev-parse --abbrev-ref " .. current_branch .. "@{upstream} 2>/dev/null")
						)

						if upstream == "" then
							utils.notify(
								"No upstream found for current branch: " .. current_branch,
								vim.log.levels.ERROR
							)
							return function() end
						end

						local finder = require("snacks.picker.source.proc").proc({
							opts,
							{
								cmd = "git",
								args = {
									"-c",
									"core.quotepath=false",
									"--no-pager",
									"diff",
									upstream .. "...HEAD",
									"--no-color",
									"--no-ext-diff",
								},
							},
						}, ctx)

						return function(cb)
							local function add()
								if file and line and #hunk > 0 then
									local diff = table.concat(header, "\n") .. "\n" .. table.concat(hunk, "\n")
									cb({
										text = file .. ":" .. line,
										diff = diff,
										file = file,
										pos = { line, 0 },
										preview = { text = diff, ft = "diff", loc = false },
									})
								end
								hunk = {}
							end

							finder(function(proc_item)
								local text = proc_item.text
								if text:find("diff", 1, true) == 1 then
									add()
									file = text:match("^diff .* a/(.*) b/.*$")
									header = { text }
									header_len = 4
								elseif file and #header < header_len then
									if text:find("^deleted file") then
										header_len = 5
									end
									header[#header + 1] = text
								elseif text:find("@", 1, true) == 1 then
									add()
									line = tonumber(string.match(text, "@@ %-.*,.* %+(.*),.* @@"))
									hunk = { text }
								elseif #hunk > 0 then
									hunk[#hunk + 1] = text
								else
									error("unexpected line: " .. text)
								end
							end)

							add()
						end
					end,
				})
			end,
			desc = "Diff current branch against its upstream (e.g., origin/main)",
		},
	},
}
