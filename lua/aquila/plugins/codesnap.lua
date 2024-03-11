return {
    "mistricky/codesnap.nvim",
    build = "make",
    event = "BufReadPost",
    config = function()
        require('codesnap').setup()
    end
}
