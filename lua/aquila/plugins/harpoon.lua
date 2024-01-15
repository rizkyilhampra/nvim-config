return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require('harpoon')

        harpoon:setup({})

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end,
            { desc = "Add current buffer to Harpoon list" })
        vim.keymap.set("n", "<Leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {
            desc = "Toggle Harpoon list"
        })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-h>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():next() end)

        vim.keymap.set("n", "<Leader>1", function() harpoon:list():select(1) end, {
            desc = "Navigate to first file in Harpoon list"
        })
        vim.keymap.set("n", "<Leader>2", function() harpoon:list():select(2) end, {
            desc = "Navigate to second file in Harpoon list"
        })
        vim.keymap.set("n", "<Leader>3", function() harpoon:list():select(3) end, {
            desc = "Navigate to third file in Harpoon list"
        })
        vim.keymap.set("n", "<Leader>4", function() harpoon:list():select(4) end, {
            desc = "Navigate to fourth file in Harpoon list"
        })
    end
}
