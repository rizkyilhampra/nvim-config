local function get_note_events(paths)
	local events = {}
	for _, path in ipairs(paths) do
		local expanded_path = vim.fn.expand(path)
		table.insert(events, "BufReadPre " .. expanded_path .. "/*.md")
		table.insert(events, "BufNewFile " .. expanded_path .. "/*.md")
	end
	return events
end

local note_paths = {
	"~/Notes/aquila-notes",
}

return {
	"epwalsh/obsidian.nvim",
	version = "*",
	event = get_note_events(note_paths),
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		-- ui = { enable = false },
		workspaces = {
			{
				name = "dotfiles-wiki",
				path = "~/Notes/aquila-notes/dotfiles-wiki",
				overrides = {
					disable_frontmatter = true,
					note_id_func = function(title)
						return title
					end,
				},
			},
			{
				name = "aquila-notes",
				path = "~/Notes/aquila-notes",
			},
		},
		note_id_func = function(title)
			local suffix = ""
			if title ~= nil then
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. "-" .. suffix
		end,
	},
}
