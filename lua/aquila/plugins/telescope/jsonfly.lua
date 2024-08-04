return {
    "Myzel394/jsonfly.nvim",
    requires = "nvim-telescope/telescope.nvim",
    config = function()
        require("telescope").load_extension "jsonfly"
    end,
    keys ={
        {
            "<Leader>fj",
            "<cmd>Telescope jsonfly<CR>",
            desc = "List of json files",
            ft = "json",
        },
    }

}