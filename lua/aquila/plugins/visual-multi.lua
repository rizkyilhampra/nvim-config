return {
    'mg979/vim-visual-multi',
    branch = 'master',
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    init = function()
        vim.g.VM_maps = {
            ["Visual All"] = '<M-d>',
            ["Select All"] = '<M-d>'
        }
    end,
}
