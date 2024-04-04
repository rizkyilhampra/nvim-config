return {
    'nvimtools/none-ls.nvim',
    event = {
        "BufReadPost",
        "BufNewFile"
    },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require('null-ls')

        local sources = {
            require("none-ls.diagnostics.eslint").with({
                condition = function(utils)
                    -- Check if the root directory has a ".eslintrc.{js,yml,json}" file
                    local filenames = { ".eslintrc.js", ".eslintrc.yml", ".eslintrc.json" }
                    for _, filename in ipairs(filenames) do
                        if utils.root_has_file(filename) then
                            return true
                        end
                    end
                    return false
                end,
            }),
            null_ls.builtins.diagnostics.selene,
        }

        null_ls.setup({
            sources = sources,
        })
    end
}