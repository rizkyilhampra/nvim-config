local workspaces = {
    {
        name = "aquila",
        path = "~/Notes/aquila-notes",
    },
}

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    cond = function()
        for _, workspace in ipairs(workspaces) do
            if vim.fn.getcwd() == vim.fn.expand(workspace.path) then
                return true
            end
        end

        return false
    end,
    opts = {
        workspaces = workspaces
    }
}