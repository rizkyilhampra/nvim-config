return {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = {},
    config = function(_, opts)
        require('illuminate').configure(opts)
    end
}