local set = function(mode, map, mapped, opts)
    vim.keymap.set(mode, map, mapped, opts)
end

local commands = require("aquila.core.commands")

set("n", "$", "g_", { noremap = true, silent = true })
vim.keymap.set('n', 'j', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
vim.keymap.set('n', 'k', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

set("i", "jj", "<Esc>", { noremap = true, silent = true })
-- i love windows behavior for saving a file
-- TODO: Maybe hook with surround plugin 
set("i", "<M-S-h>", "<ESC>ha<Space>")
set("i", "<M-S-l>", "<ESC>la<Space>")
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

set({ "n", "v" }, "<Leader>y", "\"+y", { desc = "Copy/yank to system clipboard" })
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

set("v", "<leader>Y", function()
    -- This is *start* and *end* of selection, will be first or last line depending on whether you selected up or down
    local v_start = vim.fn.getpos("v")[2]
    local v_end = vim.fn.getpos(".")[2]

    local selected = vim.api.nvim_buf_get_lines(0, math.min(v_start, v_end) - 1, math.max(v_start, v_end), true)

    local indent = require('aquila.core.commands').get_indent(selected)
    for i, line in ipairs(selected) do
        selected[i] = line:sub(indent)
    end

    local text = table.concat(selected, "\n")
    vim.fn.setreg("+", text)
    -- launch <esc> to return to normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
end, { noremap = true, silent = true, desc = "Copy/yank to system clipboard without indent from source" })

set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end)
set('x', '<', '<gv', { desc = 'unindent selection' })
set('x', '>', '>gv', { desc = 'indent selection' })

set('n', 'gg', function()
    vim.g.minianimate_disable = true
    if vim.v.count > 0 then
        vim.cmd("normal! " .. vim.v.count .. "gg")
    else
        vim.cmd "normal! gg0"
    end
    vim.g.minianimate_disable = false
end, { desc = 'better gg and go to the first position' })
set('n', 'G', function()
    vim.g.minianimate_disable = true
    vim.cmd "normal! G$"
    vim.g.minianimate_disable = false
end, { desc = "better G and got to the last position" })

set('x', 'gg', function()
    vim.g.minianimate_disable = true
    if vim.v.count > 0 then
        vim.cmd("normal! " .. vim.v.count .. "gg")
    else
        vim.cmd "normal! gg0"
    end
    vim.g.minianimate_disable = false
end, { desc = "gg and go to the first position (visual)" })

vim.api.nvim_create_autocmd("BufWinEnter", {
    desc = "Make q close help, man, quickfix, dap floats",
    callback = function(args)
        local buftype =
            vim.api.nvim_get_option_value("buftype", { buf = args.buf })
        if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) then
            vim.keymap.set(
                "n", "q", "<cmd>close<cr>",
                { buffer = args.buf, silent = true, nowait = true }
            )
        end
    end,
})
vim.api.nvim_create_autocmd("CmdwinEnter", {
    desc = "Make q close command history (q: and q?)",
    callback = function(args)
        vim.keymap.set(
            "n", "q", "<cmd>close<cr>",
            { buffer = args.buf, silent = true, nowait = true }
        )
    end,
})