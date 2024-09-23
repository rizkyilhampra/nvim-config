return {
    'Tyler-Barham/floating-help.nvim',
    cmd = "FloatingHelp",
    config = function()
        require('floating-help').setup({
            width = 80,               -- Whole numbers are columns/rows
            height = 0.9,             -- Decimals are a percentage of the editor
            position = 'E',           -- NW,N,NW,W,C,E,SW,S,SE (C==center)
            border = 'rounded',       -- rounded,double,single
            onload = function(_) end, -- optional callback to be executed after help contents has been loaded
        })
    end
}