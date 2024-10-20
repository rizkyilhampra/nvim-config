return {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    opts = function()
        local dashboard = require('alpha.themes.dashboard')
        local logo = {
            [[ ⣀⣀⣀⣀⠤⠤⠑⠂⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠀⠀⠀⠀⠀⠀⠀⣠⢞⡾⠁⣴⢸⠁⠀⠀⠀⠀⠸⣿⠀⠀⠀⠀⠈⢿⣽⣿⡄⠀ ]],
            [[ ⠀⠀⢀⣿⡿⣿⠉⠉⠉⠉⠀⣰⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⠋⢀⠀⠀⠀⠀⢀⣠⡾⢋⡿⢁⣴⣆⣯⣶⡀⠀⠀⠀⠀⢿⡇⠀⠀⠀⠀⠈⣷⠿⣿⡄ ]],
            [[ ⠀⢀⡾⡫⣹⠇⠀⠀⠀⠀⢠⡏⠀⠀⠄⠀⠀⠀⢀⣠⠴⣞⡡⠄⠂⠀⠀⣀⣤⣶⠟⠋⢠⢞⡴⠟⢛⡞⠾⣿⣿⣦⡀⠀⠀⢸⣷⠀⠀⠀⠀⠀⠸⣗⠈⠻ ]],
            [[ ⢠⡪⠊⢀⡿⠀⠀⠀⠀⠀⡾⢀⠀⢒⣶⢶⣶⣶⣾⣟⣋⣥⣤⣴⣶⡾⠿⠛⠉⠀⡀⣴⣷⡟⣀⣤⠮⠾⠿⢿⣿⣿⣿⣧⡀⠀⣿⡀⠀⠀⠀⠀⠀⢻⡅⠀ ]],
            [[ ⠋⠀⢀⢻⠇⠀⠀⠀⠀⢠⠇⠀⢠⣿⣿⡗⠁⠉⡫⠉⠉⣩⣍⠁⠀⣀⣠⣤⣶⣫⣾⣿⡿⡿⡵⠋⠀⠂⠀⡀⠈⠻⣿⢿⣿⡄⣿⡇⠀⠀⠀⠀⠀⠀⢿⡀ ]],
            [[ ⢀⢀⠎⣿⠀⠀⠀⠀⠀⢸⠀⠀⣾⣿⠏⠀⣴⡿⠀⠀⠀⠻⢻⣿⣿⣿⣿⣷⡿⡿⣛⣹⣼⣿⣵⠁⠀⠰⢿⢿⣷⡄⠈⢿⣿⣧⢸⣧⢣⠀⠀⠀⠀⠀⠈⣷ ]],
            [[ ⡠⠃⢀⡇⠀⠀⠀⠀⠀⠀⡠⢸⣟⣡⣇⢼⣿⣿⡔⢷⣴⡿⣼⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⣿⣿⣞⢶⣶⢇⣾⣿⣿⠠⡘⢿⣿⢸⣿⠊⢦⠀⠀⠀⠀⠀⠘ ]],
            [[ ⠀⠀⢸⠃⠀⠀⠀⠀⡀⠀⣠⢸⣿⣿⣿⣿⣽⣿⣟⣥⣤⣥⣿⣿⣿⣯⣯⣟⣿⡧⠹⣻⣷⣝⣿⣷⣦⢭⣽⣿⣿⣻⣾⣿⣿⠇⢸⣇⠂⠘⣧⠀⠀⠀⠀⠀ ]],
            [[ ⡀⠀⣾⠀⠀⠀⠀⢸⠃⠀⠄⠈⣟⡵⣻⣻⣷⢟⢿⣿⣮⣾⣿⣟⣿⣽⣯⣿⣾⡗⣽⣾⣯⢿⣿⣽⣿⣯⣟⣿⣿⣿⣽⡏⡟⠀⣿⠁⠀⡄⠘⣧⡀⠀⠀⠀ ]],
            [[ ⠇⢀⡇⠀⠀⠀⠀⣟⢰⢰⠀⠀⠚⣿⣿⣾⣿⣷⣿⣿⣷⣿⢿⣿⣿⣿⣿⣿⣿⣧⣿⣿⣿⣿⡿⣛⣿⣯⣿⣾⣿⣿⣯⣿⡁⡲⡃⢠⢂⠀⠀⠈⢷⡀⠀⠀ ]],
            [[ ⠀⣸⠃⡀⠀⠀⣸⠁⢄⠠⢗⠀⠤⡹⣿⡿⣿⣿⣿⣿⡷⣻⣯⡽⣿⣿⣿⣿⣿⣿⣿⣿⣿⢯⣾⣿⢧⣿⣿⣿⣿⣶⣿⠧⡃⢂⠀⠠⠂⠀⠀⠀⠀⠻⣆⠠ ]],
            [[ ⢀⡟⣰⡇⠀⢀⠇⠀⠀⠁⠈⠆⢌⠀⢻⣿⢿⣿⣿⣿⣷⢿⣿⣿⣞⠛⠛⠛⠿⠻⠿⠛⢫⣿⣿⡿⣾⣿⣿⣿⣿⣯⡗⠈⠐⠨⠊⠀⠀⠀⠀⠀⠀⠀⠙⣿ ]],
            [[ ⡘⣱⣿⡇⠀⡜⠀⠀⠀⠀⠀⠀⠒⠑⠐⢻⣿⣿⣿⣿⣿⣟⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⣾⣿⣿⢻⣿⣿⣿⣿⣿⡿⠁⠐⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸ ]],
            [[ ⣾⣿⣿⠃⣰⠁⠀⠀⠀⠀⠀⠀⠀⠰⣦⣀⡹⣿⣿⣿⣿⣿⣞⢿⣿⣿⣖⣶⣾⣿⣶⢶⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            [[ ⣿⣿⡟⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠈⠺⣿⣿⣮⡛⢿⣿⣿⣿⣮⢿⣿⣿⣞⣿⣿⣿⣾⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            [[ ⣿⣿⠡⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣦⣩⠻⢿⣿⣯⢿⣿⣿⣎⣉⡅⣿⣿⣿⣿⠛⠁⣠⢶⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            [[ ⣿⣳⠍⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣦⡀⠀⠙⢿⣿⣿⣷⣄⡉⠛⠯⢿⣿⣿⣯⣛⢿⣿⣿⣿⠀⣼⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            [[ ⢿⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣆⠀⠀⠙⢿⣿⣿⣿⣦⣂⠘⣿⣿⣿⣿⣿⣿⣿⣿⡄⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
            [[ ⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣷⣄⡀⠧⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⡇⠀⠀⠀⠀⠀⢀⡤⠀⠀⡀⠀⠀⠀⠀⣀⣠⡤ ]],
            [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢠⠈⠻⣿⣿⣿⣦⣄⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢀⠢⠀⠀⠂⠀⣀⣤⣵⣾⡿⣫⣷⣿ ]],
            [[ ⠀⠐⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⡕⢠⠃⠀⠀⠈⣟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣿⡇⠀⠀⠀⠀⠑⢄⠁⢶⣿⣿⣿⡿⣻⣾⣿⣿⣿ ]],
            [[ ⣦⢶⣶⣿⣿⣿⣿⣿⣿⡿⠙⠹⢤⡃⠀⠀⠀⢠⣿⣷⣻⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⠛⠀⠀⠀⠀⠀⠈⠓⢄⣈⣻⣟⣿⣿⣿⣿⣻⣿ ]],
            [[ ⣿⣯⣿⣿⣯⡉⢙⣿⡻⠁⠀⠀⠀⠀⠁⠂⠀⠘⣿⣿⣷⣻⣌⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠂⠀⠀⢀⣠⣤⣶⣿⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿ ]],
            [[ ⣿⣿⣞⣿⡿⣳⣿⣿⣾⣷⣀⠀⠀⠀⠀⢀⡄⠀⢸⣿⣽⣳⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠐⠚⠻⠿⣿⡿⠉⣿⣿⣼⡿⣿⣿⣿⠟⣻⣿ ]],
            [[ ⣿⣿⣿⣞⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⠀⠘⣷⠀⠀⠻⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣀⠀⠀⠀⣠⠞⠁⡀⣿⣷⣯⣾⡿⠋⣀⣾⣿⣿ ]],
            [[ ⣿⣿⢯⣿⣿⣿⣿⣿⡋⠛⣛⣛⣉⢀⣧⡀⠉⣷⠠⠀⠙⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⡄⣠⠞⠁⣠⡆⠀⣿⣲⡿⠋⣠⣾⣿⣿⣿⣿ ]],
            [[ ⡿⣷⣿⣿⣿⡿⣟⣥⣾⣿⣿⣿⣿⢆⡀⠉⠀⠩⠘⠀⠀⠈⠻⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣼⣧⢁⣠⣾⣿⡇⠀⢳⢏⣴⣾⣿⣿⣿⣿⣿⣿ ]],
            [[ ⣾⣿⣿⣟⣽⣿⣿⣿⣿⡿⣿⣽⣾⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠘⢿⣿⡮⢿⣿⣿⣿⣿⣿⣿⡿⣟⣽⣾⣿⣿⣼⣿⣿⣿⣷⣀⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿ ]],
        }

        dashboard.section.header.val = logo
        -- dashboard.section.footer.val = "Type `:q` for exit/quit VIM"
        dashboard.section.buttons.val = {}

        dashboard.section.buttons.opts.hl = 'AlphaButtons'
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.footer.opts.hl = "AlphaFooter"

        -- dashboard.opts.layout[1].val = 4

        dashboard.config.opts.noautocmd = true

        return dashboard
    end,
    config = function(_, dashboard)
        require('alpha').setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
            once = true,
            pattern = "LazyVimStarted",
            desc = "Add Alpha dashboard footer",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

                dashboard.section.footer.val = "⚡ Neovim loaded " ..
                    stats.count .. " plugins in " .. ms .. "ms"

                local hl_theme = io.open(vim.fn.stdpath("config") .. "/lua/aquila/config/alpha/hl-table.txt", "r")
                if hl_theme then
                    local content = hl_theme:read("*a")
                    hl_theme:close()
                    dashboard.section.header.opts.hl = loadstring('return {' .. content .. '}')()

                    local config_file = vim.fn.stdpath("config") .. "/lua/aquila/config/alpha/set_hl.txt"
                    local success, err = pcall(dofile, config_file)
                    if not success then
                        print("Error executing config file: " .. err)
                    end
                else
                    dashboard.section.header.opts.hl = "AlphaHeader"
                end

                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end
}