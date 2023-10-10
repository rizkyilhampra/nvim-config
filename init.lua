require('aquila.core')
require('aquila.lazy')

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        print('Yeah, I guess it is.')
    end
})
