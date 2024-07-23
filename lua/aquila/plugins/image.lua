return {
    "3rd/image.nvim",
    event = "User BaseDefered",
    opts = {},
    config = function(_, opts)
        require("image").setup(opts)
        package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
        package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
    end,
}