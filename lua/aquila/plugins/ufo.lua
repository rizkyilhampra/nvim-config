return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        event = "BufReadPost",
        opts = {
            provider_selector = function()
                return { "treesitter", "indent" }
            end,
        },

        init = function()
            vim.keymap.set("n", "zR", function()
                require("ufo").openAllFolds()
            end, {
                desc = "Open all fold"
            })
            vim.keymap.set("n", "zM", function()
                require("ufo").closeAllFolds()
            end, { desc = "Close all fold" })
        end,
    },
    -- Folding preview, by default h and l keys are used.
    -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
    -- On second press the preview will be closed and fold will be opened.
    -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
    { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
}