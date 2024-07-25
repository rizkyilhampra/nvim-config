return {
    "3rd/image.nvim",
    enabled = false,
    event = "User BaseDefered",
    opts = {
        tmux_show_only_in_active_window = true
    },
    config = function(_, opts)
        require("image").setup(opts)
        package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
        package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
    end,
}