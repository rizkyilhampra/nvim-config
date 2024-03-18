local set = function(mode, map, mapped, opts)
    vim.keymap.set(mode, map, mapped, opts)
end

local commands = require("aquila.core.commands")

set("i", "jj", "<Esc>", { noremap = true, silent = true })
-- i love windows behavior for saving a file
set({ 'i', 'n' }, "<C-s>", '<cmd>w<CR>')

-- fix problem when below keymap will exit neovim
set({ 'n', 'v', 'i' }, '<C-z>', '<Nop>')
set('n', '<C-c>', '<Nop>')

-- the selected line will move one line up/down and keep the selection
set("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move selected lines down",
    silent = true
})

set("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move selected lines up",
    silent = true
})

-- pressing `n/N` for the next/prev matches in search mode, will make the matches line center
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("n", "<Leader>l", '<cmd>Lazy<CR>', { desc = "Open Lazy" })

set({ "n", "v" }, "<Leader>y", "\"+y", { desc = "Copy/Yank to system clipboard" })
set({ "n", "v" }, "<Leader>p", "\"+p", { desc = "Paste from system clipboard" })
set("v", "<leader>P", '"_dP', { desc = 'Do not lose the " register on paste' })
set("n", "x", '"_x', { desc = 'Do not lose the " register on delete' })
set("n", "s", '"_s', { desc = 'Do not lose the " register on replace' })

set("n", "<Leader>~", '<cmd>Alpha<CR>', { desc = "Take me home..." })

set("n", "H", "<C-w>h", { noremap = true, silent = true })
set("n", "L", "<C-w>l", { noremap = true, silent = true })

set("n", "dd", function()
    if vim.fn.getline("."):match("^%s*$") then
        return '"_dd'
    end
    return "dd"
end, {
    expr = true,
    desc = "Delete line without copy to register if line is empty"
})

set({ 'n', 'v' }, '<C-S-d>', commands.duplicate_selection, { desc = 'Duplicate selection' })
set('v', '<C-M-d>', function()
    commands.duplicate_selection()
    vim.fn.execute [[noautocmd normal! gv]]
end, {
    desc = 'Duplicate selection (keep selection)'
})