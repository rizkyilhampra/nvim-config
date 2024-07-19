require('aquila.core')
require('aquila.lazy')

if vim.g.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, vim.g.default_colorscheme) then
    require("base.utils").notify(
      "Error setting up colorscheme: " .. vim.g.default_colorscheme,
      vim.log.levels.ERROR
    )
  end
end
