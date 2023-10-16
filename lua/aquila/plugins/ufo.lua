return {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
        "kevinhwang91/promise-async",
    },
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
}
