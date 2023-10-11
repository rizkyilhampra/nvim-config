local set = function(mode, map, mapped, opts)
    vim.keymap.set(mode, map, mapped, opts)
end

set("i", "jj", "<Esc>", { noremap = true, silent = true }) -- the important things you should remap

set({ 'i', 'n' }, "<C-s>", '<cmd>w<CR>')                   -- i love vscode and other editor at windows behavior for save a file

set('n', '<C-h>', '<cmd>bnext<CR>')                        -- switch buffer next or previous
set('n', '<C-l>', '<cmd>bprevious<CR>')

set({ 'n', 'v', 'i' }, '<C-z>', '<Nop>') -- fix problem when CTRL + Z is exit neovim
set('n', '<C-c>', '<Nop>')               -- fix probelm when CTRL + C in normal mode is exit neovim

set("v", "J", ":m '>+1<CR>gv=gv")        -- same like alt + up/down at vscode
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "n", "nzzzv") -- when you are in search mode and move with 'n'/'N' for the next matches, the window is stick center
set("n", "N", "Nzzzv")

set("n", "<Leader>m", '<cmd>Mason<CR>', { desc = 'Open Mason' })
set("n", "<Leader>l", '<cmd>Lazy<CR>', { desc = "Open Lazy" })

set({ "n", "v" }, "<Leader>y", "\"+y", { desc = "Copy/Yank to system clipboard" })
set({ "n", "v" }, "<Leader>p", "\"+p", { desc = "Paste from system clipboard" })
set("v", "<leader>P", '"_dP', { desc = 'Do not lose the " register on paste' })

set("n", "<Leader>h", '<cmd>Alpha<CR>', { desc = "Take me home to the place i belong ~~" })

set("n", "H", "<C-w>h", { noremap = true, silent = true })
set("n", "L", "<C-w>l", { noremap = true, silent = true })

-- Neotree
set("n", "<Leader>e", '<cmd>Neotree toggle<CR>')
set("n", "<Leader>E", '<cmd>Neotree reveal<CR>')

-- Telescope
set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "Find files in cwd" })
set('n', '<leader><space>', '<cmd>Telescope find_files<cr>', { desc = "Find files in cwd" })
set('n', '<leader>fa', '<cmd>Telescope find_files no_ignore=true hidden=true<CR>',
    { desc = "Find all without respect anything" }
)
set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "List previously open files all dir" })
set("n", "<leader><Tab>",
    "<cmd>lua require('telescope.builtin').oldfiles({cwd_only = true, initial_mode = 'normal'})<CR>",
    { desc = 'List previously open files on cwd only' })

set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "list of buffers" })
set("n", "<leader>r", "<cmd>lua require('telescope.builtin').registers({ initial_mode = 'normal' })<CR>",
    { desc = "List of registers" })

-- extension file browser
-- keymap.set("n", "<Leader>E", ":Telescope file_browser<CR>", { noremap = true, desc = "file browser on cwd" })
-- keymap.set("n", "<Leader>e", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
--     { noremap = true, desc = "file browser on current buffer path" })
