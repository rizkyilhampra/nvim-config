return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
        local dashboard = require('alpha.themes.dashboard')
        local logo = {
            "⢟⠓⠤⡉⠔⣂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠒⡐⢂⠆⡩⢁⠎⣻",
            "⢆⡉⢆⠱⡈⢄⠣⢌⠡⢊⠱⣈⠱⡈⢅⢊⠱⣈⠱⡈⢅⢊⠱⣈⠱⡈⢅⢊⠱⣈⠱⡈⢅⢊⠱⣈⠱⡈⢅⢊⠱⣈⠱⡈⢆⡘⢄⠣⡘⠬",
            "⢠⠘⡄⢣⠘⡄⠣⢌⠢⡑⠢⢄⠣⡘⢄⠊⡔⢠⠃⡜⢠⠊⡔⢠⠃⡜⢠⠊⠔⠀⠃⠈⠐⠌⠒⠄⠣⡘⢄⠊⡔⢠⠃⡜⢠⠘⡄⢣⠘⡐",
            "⠠⢃⠜⡠⢃⠌⡱⢈⠆⡡⢃⠌⢢⠑⡌⠒⡌⢢⠑⡌⠢⠑⠈⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠈⠒⡌⢢⠑⡌⢢⠑⡌⢢⠑⡌",
            "⠘⡄⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠄⠣⢌⠱⡈⠆⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠁⢎⠰⡁⢎⠰⡁⢎⡐",
            "⢨⠐⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⠊⠁⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡌⢢⠑⡌⢢⠑⡌⢢⠐",
            "⠠⢃⠔⡡⢊⠔⡡⢊⠔⡡⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⡑⢌⠢⡑⢌⠢⡑⢌⠢⡉",
            "⠘⡄⢊⠔⡡⢊⠔⡡⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢆⠱⡈⢆⠱⡈⢆⠱⡈⢆⡑",
            "⢨⠐⡡⢊⠔⡡⢊⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⡁⢎⠰⡁⢎⠰⡁⢎⠰⡁⢆⠰",
            "⠠⢃⠔⡡⢊⠔⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔",
            "⠘⡄⢊⠔⡡⢊⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⡁⢎⠰⡁⢎⠰⡁⢎⠰⡁⠎",
            "⢨⠐⡡⢊⠔⡡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⡀⠠⡑⢌⠢⡑⢌⠢⡑⢌⠢⡑⢌",
            "⠠⢃⠔⡡⢊⠔⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠙⠙⠁⠀⡘⢄⠣⡘⢄⠣⡘⢄⠣⡘⢄",
            "⠘⡄⢊⠔⡡⢊⠔⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡌⢢⠑⡌⢢⠑⡌⢢⠑⡌",
            "⢨⠐⡡⢊⠔⡡⢊⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡈⢆⠱⡈⢆⠱⡈⢆⠱⢠",
            "⠠⢃⠔⡡⢊⠔⡡⢊⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠑⡌⢢⠑⡌⢢⠑⡌⢢⢁",
            "⠘⡄⢊⠔⡡⢊⠔⡡⢊⠔⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⡜⢠⠃⡜⢠⠃⡜⢠⠊",
            "⢨⠐⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⢣⠘⡄⢣⠘⡄⢣⠘⡄⢣⠘",
            "⠠⢃⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊",
            "⠘⡄⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡩⢐⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠠⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡",
            "⢨⠐⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⡑⢢⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠰⡈⢆⠡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔",
            "⠠⢃⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⠘⡄⠊⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⡜⢠⠃⡌⢢⠑⡌⢢⠑⡌⢢⠑⡌⢢⠑⡌⠢",
            "⠘⡄⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⢊⠔⡡⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⢣⠘⡄⢣⠘⡄⢣⠘⡄⢣⠘⡄⠣⢌⡑",
            "⠒⡌⢌⠢⡑⢌⠢⡑⢌⠢⡑⢌⠢⡑⢌⠢⡑⢌⠢⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⢣⠘⡄⢣⠘⡄⢣⠘⡄⠣⢌⡑⢢⠰",
            "⣮⣮⣄⣣⠘⡄⢣⠘⡄⢣⠘⡄⢣⠘⡄⢣⠘⡄⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡈⢆⠱⡈⢆⠱⡈⢆⠱⣈⠑⣢⠘⠔⣱",
        }

        -- local footer = "Type `:q` for exit/quit VIM"
        local footer = "The sunset is beautiful, isn't it?"

        dashboard.section.header.val = logo
        dashboard.section.footer.val = footer
        dashboard.section.buttons.val = {}

        dashboard.section.buttons.opts.hl = 'AlphaButtons'
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.footer.opts.hl = "AlphaFooter"

        dashboard.opts.layout[1].val = 4

        return dashboard
    end,
    config = function(_, dashboard)
        require('alpha').setup(dashboard.opts)

        -- vim.api.nvim_create_autocmd("User", {
        --     pattern = "LazyVimStarted",
        --     callback = function()
        --         local stats = require("lazy").stats()
        --         local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        --         local footerOnOpts = dashboard.section.footer.val
        --         local footerCustom = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"

        --         dashboard.section.footer.val = footerCustom

        --         pcall(vim.cmd.AlphaRedraw)
        --     end,
        -- })
    end
}
