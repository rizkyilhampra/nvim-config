return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPre",
    opts = {
    },
    config = function(_, opts)
        local trouble = require('trouble')

        require('which-key').register({
            ["<Leader>x"] = { name = "+diagnostic" }
        })

        vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end, { desc = "Toggle" })
        vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end,
            { desc = "Workspace diagnostics" })
        vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end,
            { desc = "Document diagnostics" })
        vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end, { desc = "Quickfix" })
        vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end, { desc = "Loclist" })
    end
}
