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

-- this for UFO folding requirement.
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.opt.smoothscroll = true

vim.opt.cursorline = true
vim.opt.scrolloff = 14
vim.opt.sidescrolloff = 36
vim.opt.confirm = true
vim.opt.swapfile = false

-- enable blinking cursor
vim.opt.guicursor = {
    "n-v-c-sm:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
    "i:ver25",
}

-- show hidden characters
-- vim.opt.list = true

-- NOTE: indent-blankline.nvim will override first charater of tab.
-- So use second character to differentiate tab & space
-- Use default for space to avoid Search highlight been override by Whitespace highlight

-- vim.opt.listchars = { tab = "▸─", extends = "»", precedes = "«", nbsp = "␣", eol = "↴" }
-- local mode = vim.api.nvim_get_mode().mode
-- if mode == "reader" then
--     -- Don't show trailing space in reader vim mode
--     vim.opt.listchars:append({ trail = "•" })
-- end

vim.opt.mousemoveevent = true -- Allow hovering in bufferline.nvim & eagle.nvim
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.updatetime = 200
vim.opt.autoread = true

vim.opt.pumheight = 10
vim.opt.colorcolumn = ''

vim.opt.nrformats:append { "alpha" }

vim.g.diagnostics_virtual_text = 1
vim.g.inlay_hints_enabled = true
vim.g.notifications_enabled = true
vim.g.default_colorscheme = "tokyonight"
vim.g.transparent_mode = true
vim.g.big_file = { size = 1024 * 5000, lines = 50000 } -- For files bigger than this, disable 'treesitter' (+5Mb).