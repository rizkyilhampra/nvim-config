local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set({'i','n'}, "<C-s>", vim.cmd.w)

vim.keymap.set({'i','n'}, '<C-c>', '<Esc>')

vim.keymap.set({'n','v'}, "<Space>", "<Nop>")
vim.keymap.set('n', '<C-h>', vim.cmd.bnext)
vim.keymap.set('n', '<C-l>', vim.cmd.bprevious)

-- vim.keymap.set('n', '<Leader>bb', vim.cmd.Buffers)
-- vim.keymap.set('n', '<Leader>fg', vim.cmd.GitFiles)
-- vim.keymap.set('n', '<Leader>ff', vim.cmd.Files)

vim.keymap.set('n','<Leader>qa', vim.cmd.qa)
vim.keymap.set('n','<Leader>qq', vim.cmd.q)
