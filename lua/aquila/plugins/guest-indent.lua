return {
    "NMAC427/guess-indent.nvim",
    event = "User BaseFile",
    opts = {},
    config = function(_, opts)
        require("guess-indent").setup(opts)
    end,
}