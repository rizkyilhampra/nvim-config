vim.g.mapleader = " "
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
-- cause i use hlsearch plugin this is not needed
-- vim.opt.hlsearch = false
-- vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- this more for UFO folding initialization
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.opt.smoothscroll = true -- only work in 10.0+
vim.opt.cursorline = true
vim.opt.scrolloff = 14
vim.opt.sidescrolloff = 8
vim.opt.confirm = true
vim.opt.swapfile = false
vim.opt.spell = true
-- enable blinking cursor
vim.opt.guicursor = {
    "n-v-c-sm:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
    "i:ver25",
}

-- show hidden characters
vim.opt.list = true
-- NOTE: indent-blankline.nvim will override first charater of tab.
-- So use second character to differentiate tab & space
-- Use default for space to avoid Search highlight been override by Whitespace highlight
vim.opt.listchars = { tab = "▸─", extends = "»", precedes = "«", nbsp = "␣", eol = "↴" }
local mode = vim.api.nvim_get_mode().mode
if mode == "reader" then
    -- Don't show trailing space in reader vim mode
    vim.opt.listchars:append({ trail = "•" })
end

vim.opt.mousemoveevent = true -- Allow hovering in bufferline.nvim & eagle.nvim
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- cause i use noice plugin this is not needed
-- vim.opt.cmdheight = 0
