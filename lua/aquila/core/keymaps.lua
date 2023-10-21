local set = function(mode, map, mapped, opts)
    vim.keymap.set(mode, map, mapped, opts)
end

set("i", "jj", "<Esc>", { noremap = true, silent = true }) -- the important things you should remap

set({ 'i', 'n' }, "<C-s>", '<cmd>w<CR>')                   -- i love vscode and other editor at windows behavior for save a file

set('n', '<C-h>', '<cmd>bnext<CR>')                        -- switch buffer next or previous
set('n', '<C-l>', '<cmd>bprevious<CR>')

set({ 'n', 'v', 'i' }, '<C-z>', '<Nop>') -- fix problem when CTRL + Z is exit neovim
set('n', '<C-c>', '<Nop>')               -- fix probelm when CTRL + C in normal mode is exit neovim

-- same like alt + up/down at vscode
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- when you are in search mode and move with 'n'/'N' for the next matches, the window is stick center
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("n", "<Leader>m", '<cmd>Mason<CR>', { desc = 'Open Mason' })
set("n", "<Leader>l", '<cmd>Lazy<CR>', { desc = "Open Lazy" })

set({ "n", "v" }, "<Leader>y", "\"+y", { desc = "Copy/Yank to system clipboard" })
set({ "n", "v" }, "<Leader>p", "\"+p", { desc = "Paste from system clipboard" })
set("v", "<leader>P", '"_dP', { desc = 'Do not lose the " register on paste' })

set("n", "<Leader>ho", '<cmd>Alpha<CR>', { desc = "Take me home to the place i belong ~~" })

set("n", "H", "<C-w>h", { noremap = true, silent = true })
set("n", "L", "<C-w>l", { noremap = true, silent = true })

-- Neotree
set("n", "<Leader>e", '<cmd>Neotree toggle<CR>')
set("n", "<Leader>E", '<cmd>Neotree reveal<CR>')
