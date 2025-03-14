-- NOTE: Stole it from https://github.com/tjdevries/config.nvim/blob/master/lua/custom/telescope/multi-ripgrep.lua

local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")

---@diagnostic disable-next-line: deprecated
local flatten = vim.tbl_flatten

return function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
	opts.shortcuts = opts.shortcuts
		or {
			["l"] = "*.lua",

			["js"] = "*.js",
			["jsx"] = "*.jsx",
			["ts"] = "*.ts",
			["tsx"] = "*.tsx",
			["css"] = "*.css",
			["scss"] = "*.scss",
			["html"] = "*.html",

			["php"] = "*.php",

			["json"] = "*.json",
			["yml"] = "*.{yml,yaml}",
			["env"] = "*.env*",
			["md"] = "*.md",

			["react"] = "*.{jsx,tsx}",
			["style"] = "*.{css,scss,less}",
			["conf"] = "*.{json,yml,yaml,toml}",
			["doc"] = "*.{md,txt,rst}",
			["test"] = "*{test,spec,Test}.*",
		}
	opts.pattern = opts.pattern or "%s"

	local custom_grep = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local prompt_split = vim.split(prompt, "  ")

			local args = { "rg" }
			if prompt_split[1] then
				table.insert(args, "-e")
				table.insert(args, prompt_split[1])
			end

			if prompt_split[2] then
				table.insert(args, "-g")

				local pattern
				if opts.shortcuts[prompt_split[2]] then
					pattern = opts.shortcuts[prompt_split[2]]
				else
					pattern = prompt_split[2]
				end

				table.insert(args, string.format(opts.pattern, pattern))
			end

			return flatten({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	local custom_sorter = sorters.new({
		scoring_function = function(_, prompt, line, _)
			local search_term = vim.split(prompt, "  ")[1] or prompt
			return sorters.highlighter_only(opts).scoring_function(_, search_term, line, _)
		end,

		highlighter = function(_, prompt, line)
			local search_term = vim.split(prompt, "  ")[1] or prompt
			return sorters.highlighter_only(opts).highlighter(_, search_term, line)
		end,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Live Grep (with shortcuts)",
			finder = custom_grep,
			previewer = conf.grep_previewer(opts),
			sorter = custom_sorter,
		})
		:find()
end
