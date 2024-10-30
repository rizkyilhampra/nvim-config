return {
	"IogaMaster/neocord",
	cmd = { "Neocord" },
	opts = {},
	config = function(_, opts)
		local neocord = require("neocord")

		vim.api.nvim_create_user_command("Neocord", function(command_opts)
			local operation = command_opts.args == "" and "start" or command_opts.args

			if operation == "start" then
				neocord.setup(opts)
				vim.notify("Neocord started", vim.log.levels.INFO)
			elseif operation == "stop" then
				neocord:stop()
				vim.notify("Neocord stopped", vim.log.levels.INFO)
			else
				vim.notify("Invalid argument. Use 'Neocord', 'Neocord start' or 'Neocord stop'", vim.log.levels.ERROR)
			end
		end, {
			nargs = "?",
			complete = function(_, _, _)
				return { "start", "stop" }
			end,
		})

		neocord.setup(opts)
	end,
}