return {
    'lewis6991/satellite.nvim',
    event = { 'BufReadPre', 'BufNewfile' },
    opts = {
        winblend = 0,
        excluded_filetypes = { 'neo-tree' },
    }
}