local global = require("aquila.core.global")

return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "NeoTree",
	keys = {
		{
			"<Leader>e",
			"<cmd>Neotree toggle<CR>",
			desc = "Toggle NeoTree",
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
	},
	opts = {
		close_if_last_window = true,
		window = {
			width = 35,
			mappings = {
				["h"] = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" and node:is_expanded() then
						require("neo-tree.sources.filesystem").toggle_directory(state, node)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				["l"] = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" then
						if not node:is_expanded() then
							require("neo-tree.sources.filesystem").toggle_directory(state, node)
						elseif node:has_children() then
							require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
						end
					elseif node.type == "file" then
						require("neo-tree.sources.filesystem.commands").open(state)
					end
				end,
				-- copy to system clipboard
				["Y"] = function(state)
					local currentNode = state.tree:get_node()
					local path = currentNode.path
					vim.fn.setreg("+", path)
					vim.notify("Copied to system clipboard", vim.log.levels.INFO, {
						title = "NeoTree",
						timeout = 1000,
					})
				end,
				-- paste from system clipboard
				["P"] = function(state)
					local clipboardPath = vim.fn.getreg("+")

					if clipboardPath == "" then
						return
					end

					local currentNode = state.tree:get_node()
					local inputs = require("neo-tree.ui.inputs")
					local confirmationMessage = "Are you sure you want to paste " .. clipboardPath

					inputs.confirm(confirmationMessage, function(confirmed)
						if not confirmed then
							return
						end

						local success, _ = pcall(function()
							local sourcePath = vim.fn.fnameescape(clipboardPath)
							local destinationPath = vim.fn.fnameescape(currentNode.path)

							if currentNode.type == "directory" then
								vim.fn.system({ "cp", "-r", sourcePath, destinationPath })
							elseif currentNode.type == "file" then
								vim.fn.system({ "cp", sourcePath, destinationPath })
							end
						end)

						if not success then
							local errorNotification = {
								title = "NeoTree",
								timeout = 1000,
							}
							vim.notify("Failed to paste from system clipboard", vim.log.levels.ERROR, errorNotification)
							vim.cmd([[echohl ErrorMsg]])
							return
						end

						-- reset clipboard
						vim.fn.setreg("+", "")

						require("neo-tree.sources.manager").refresh(state.name)
						require("neo-tree.ui.renderer").focus_node(state, currentNode.id)

						local successNotification = {
							title = "NeoTree",
							timeout = 1000,
						}
						vim.notify("Pasted from system clipboard", vim.log.levels.INFO, successNotification)
					end)
				end,
				F = "find_in_dir",
			},
		},
		default_component_configs = {
			git_status = {
				symbols = {
					added = global.icons.git.added,
					modified = global.icons.git.modified,
				},
			},
		},
		filesystem = {
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = {
					"node_modules",
					".git",
				},
				never_show = {
					".DS_Store",
					"thumbs.db",
				},
			},
			commands = {
				delete = function(state)
					local inputs = require("neo-tree.ui.inputs")
					local path = state.tree:get_node().path
					local msg = "Are you sure you want to trash " .. path
					inputs.confirm(msg, function(confirmed)
						if not confirmed then
							return
						end

						local success, _ = pcall(function()
							vim.fn.system({ "trash", vim.fn.fnameescape(path) })
						end)

						if not success then
							local errorNotification = {
								title = "NeoTree",
								timeout = 1000,
							}
							vim.notify("Failed to delete to trash", vim.log.levels.ERROR, errorNotification)

							msg = "Skip trash? (permanent delete)"

							inputs.confirm(msg, function(confirmed_delete_to_trash)
								if not confirmed_delete_to_trash then
									return
								end

								if state.tree:get_node().type == "directory" then
									vim.fn.system({ "rm", "-rf", vim.fn.fnameescape(path) })
								else
									vim.fn.system({ "rm", vim.fn.fnameescape(path) })
								end

								require("neo-tree.sources.manager").refresh(state.name)
							end)
						end

						require("neo-tree.sources.manager").refresh(state.name)
					end)
				end,

				find_in_dir = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					require("telescope.builtin").find_files({
						cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
					})
				end,

				-- currently i'm not using this, but it's a good example of how to override default commands
				-- over write default 'delete_visual' command to 'trash' x n.
				-- delete_visual = function(state, selected_nodes)
				--     local inputs = require("neo-tree.ui.inputs")
				--
				--     -- get table items count
				--     function GetTableLen(tbl)
				--         local len = 0
				--         for n in pairs(tbl) do
				--             len = len + 1
				--         end
				--         return len
				--     end
				--
				--     local count = GetTableLen(selected_nodes)
				--     local msg = "Are you sure you want to trash " .. count .. " files ?"
				--     inputs.confirm(msg, function(confirmed)
				--         if not confirmed then return end
				--         for _, node in ipairs(selected_nodes) do
				--             vim.fn.system { "trash", vim.fn.fnameescape(node.path) }
				--         end
				--         require("neo-tree.sources.manager").refresh(state.name)
				--     end)
				-- end,
			},
		},
	},
}
