-- for fzf plugin
-- vim.keymap.set('n', '<Leader>bb', vim.cmd.Buffers)
-- vim.keymap.set('n', '<Leader>fg', vim.cmd.GitFiles)
-- vim.keymap.set('n', '<Leader>ff', vim.cmd.Files)

local opts = {
    noremap = true,
    silent = true,
}

-- the important things you should remap
vim.keymap.set("i", "jj", "<Esc>", opts)

-- i love vscode and other editor at windows behavior for save a file
vim.keymap.set({ 'i', 'n' }, "<C-s>", vim.cmd.w)

-- switch buffer next or previous
vim.keymap.set('n', '<C-h>', vim.cmd.bnext)
vim.keymap.set('n', '<C-l>', vim.cmd.bprevious)

-- fix problem when CTRL + Z is exit neovim
vim.keymap.set({ 'n', 'v', 'i' },
    '<C-z>',
    '<Nop>'
)
-- same problem like above
vim.keymap.set({ 'i', 'n' }, '<C-c>', '<Nop>')

-- same like alt + up/down at vscode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- when you are in search mode and move with 'n'/'N' for the next matches, the window is stick center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<Leader>ma", vim.cmd.Mason, { desc = 'Open Mason' })
vim.keymap.set("n", "<Leader>la", vim.cmd.Lazy, { desc = "Open Lazy" })

vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y", { desc = "Copy/Yank to system clipboard" })

vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p", { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<Leader>t", vim.cmd.ToggleTerm, {desc = "Toggle terminal"})

vim.keymap.set("n", "<Leader>h", vim.cmd.Alpha, {desc = "take me home to the place i belong ~~~~"})
