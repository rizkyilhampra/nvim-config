return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",           -- source for text in buffer
        "hrsh7th/cmp-path",             -- source for file system paths
        "L3MON4D3/LuaSnip",             -- snippet engine
        "saadparwaiz1/cmp_luasnip",     -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim",         -- vs-code like pictograms
        -- -- copilot
        -- {
        --     "zbirenbaum/copilot-cmp",
        --     config = function()
        --         require("copilot_cmp").setup()
        --     end
        -- }
    },
    config = function()
        -- for supertab mapping
        -- nvim cmp recomndation
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        -- copilot cmp recomendation
        -- local has_words_before = function()
        --     if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        --     return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
        -- end

        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local cmp_kinds = {
            Text = '  ',
            Method = '  ',
            Function = '  ',
            Constructor = '  ',
            Field = '  ',
            Variable = '  ',
            Class = '  ',
            Interface = '  ',
            Module = '  ',
            Property = '  ',
            Unit = '  ',
            Value = '  ',
            Enum = '  ',
            Keyword = '  ',
            Snippet = '  ',
            Color = '  ',
            File = '  ',
            Reference = '  ',
            Folder = '  ',
            EnumMember = '  ',
            Constant = '  ',
            Struct = '  ',
            Event = '  ',
            Operator = '  ',
            TypeParameter = '  ',
            Copilot = '  '
        }

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            performance = {
                max_view_entries = 50,
            },
            completion = {
                completeopt = "menu,menuone,preview,noselect",
                autocomplete = false
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            -- sorting = {
            --     priority_weight = 2,
            --     comparators = {
            --         require("copilot_cmp.comparators").prioritize,
            --
            --         -- Below is the default comparitor list and order for nvim-cmp
            --         cmp.config.compare.offset,
            --         -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            --         cmp.config.compare.exact,
            --         cmp.config.compare.score,
            --         cmp.config.compare.recently_used,
            --         cmp.config.compare.locality,
            --         cmp.config.compare.kind,
            --         cmp.config.compare.sort_text,
            --         cmp.config.compare.length,
            --         cmp.config.compare.order,
            --     },
            -- },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- completion = {
                --     border = "rounded",
                --     winhighlight = "Border:CmpNormal",
                -- },

                -- documentation = cmp.config.window.bordered(),
                documentation = {
                    border = "rounded",
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu',
                },
            },
            mapping = cmp.mapping.preset.insert({
                -- ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                -- ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                -- copilot_cmp recomendation
                -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
                --     if cmp.visible() and has_words_before() then
                --         cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                --     else
                --         fallback()
                --     end
                -- end),
                -- supertab mapping
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local cp = require('copilot.suggestion')

                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- that way you will only jump inside the snippet region
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif cp.is_visible() then
                        cp.accept()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- endsupertab mapping
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp", group_index = 2 },
                { name = "luasnip",  group_index = 2 }, -- snippets
                { name = "buffer",   group_index = 2 }, -- text within current buffer
                { name = "path",     group_index = 2 }, -- file system paths
                -- { name = "copilot",  group_index = 2 }  -- copilot
            }),
            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                -- format = lspkind.cmp_format({
                --     maxwidth = 50,
                --     symbol_map = {},
                --     ellipsis_char = "...",
                -- }),
                fields = { "kind", "abbr" },
                format = function(_, vim_item)
                    vim_item.kind = cmp_kinds[vim_item.kind] or ""
                    return vim_item
                end,
            },
        })

        cmp.event:on("menu_opened", function(fallback)
            vim.opt.pumblend = 10
            vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on("menu_closed", function(fallback)
            vim.b.copilot_suggestion_hidden = false
        end)
    end,
}
