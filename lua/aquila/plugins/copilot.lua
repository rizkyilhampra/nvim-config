return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                auto_trigger = true,
            }
        })

        local cps = require('copilot.suggestion')
        if cps.is_visible() then
            vim.set.keymap("i", "<Tab>", function() cps.accept() end, { noremap = true, silent = true })
            vim.set.keymap("i", "<Esc>", function() cps.dismiss() end, { noremap = true, silent = true })
        end
    end,
}
