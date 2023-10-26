return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {

    },
    config = function(_, opts)
        require('illuminate').configure(opts)
    end
}
