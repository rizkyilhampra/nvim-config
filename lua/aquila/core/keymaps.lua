local set = function(mode, map, mapped, opts)
    vim.keymap.set(mode, map, mapped, opts)
end

set("i", "jj", "<Esc>", { noremap = true, silent = true }) -- the important things you should remap

set({ 'i', 'n' }, "<C-s>", '<cmd>w<CR>')                   -- i love windows behavior for save a file

set({ 'n', 'v', 'i' }, '<C-z>', '<Nop>')                   -- fix problem when CTRL + Z is exit neovim
set('n', '<C-c>', '<Nop>')                                 -- fix probelm when CTRL + C in normal mode is exit neovim

-- same behavior like alt + up/down in vscode
-- the selected line will move one line up/down
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- pressing `n/N` for the next/prev matches in search mode, will make the matches line center
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("n", "<Leader>m", '<cmd>Mason<CR>', { desc = 'Open Mason' })
set("n", "<Leader>l", '<cmd>Lazy<CR>', { desc = "Open Lazy" })

set({ "n", "v" }, "<Leader>y", "\"+y", { desc = "Copy/Yank to system clipboard" })
set({ "n", "v" }, "<Leader>p", "\"+p", { desc = "Paste from system clipboard" })
set("v", "<leader>P", '"_dP', { desc = 'Do not lose the " register on paste' })
set("n", "x", '"_x', { desc = 'Do not lose the " register on delete' })
set("n", "c", '"_c', { desc = 'Do not lose the " register on change' })
set("n", "s", '"_s', { desc = 'Do not lose the " register on replace' })

set("n", "<Leader>~", '<cmd>Alpha<CR>', { desc = "Take me home to the place i belong ~~" })

set("n", "H", "<C-w>h", { noremap = true, silent = true })
set("n", "L", "<C-w>l", { noremap = true, silent = true })

-- Neotree
set("n", "<Leader>e", '<cmd>Neotree toggle<CR>')
set("n", "<Leader>E", '<cmd>Neotree reveal<CR>')

-- dd without copy to register if line is empty
set("n", "dd", function()
        if vim.fn.getline("."):match("^%s*$") then
            return '"_dd'
        end
        return "dd"
    end,
    { expr = true }
)

-- DUPLICATE VISUAL SELECTION
local duplicate_selection = function()
    local save_reg = vim.fn.getreginfo([["]])

    local visual_mode = vim.fn.mode()
    if visual_mode == "v" or visual_mode == "V" then
        vim.fn.execute [[noautocmd normal! y`>p]]
    else
        vim.fn.execute [[noautocmd normal! yP]]
    end

    vim.fn.setreg([["]], save_reg.regcontents, save_reg.regtype)
end
set('v', '<C-d>', duplicate_selection, { desc = 'Duplicate selection' })
set('v', '<C-M-d>', function()
        duplicate_selection()
        vim.fn.execute [[noautocmd normal! gv]]
    end,
    { desc = 'Duplicate selection (keep selection)' }
)
