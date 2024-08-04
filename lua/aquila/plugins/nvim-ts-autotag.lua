return {
    "windwp/nvim-ts-autotag",
    -- event = "User BaseFile",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    ft = { "blade", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = {
        opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false
        },
        per_filetype = {
            ["html"] = {
                enable_close = false
            }
        }
    }
}