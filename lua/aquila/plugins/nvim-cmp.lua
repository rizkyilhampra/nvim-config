return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp = require("cmp")

        local luasnip = require("luasnip")
        luasnip.setup({
            region_check_events = "InsertLeave",
            delete_check_events = "InsertLeave",
        })

        cmp.setup({
            -- completion = {
            --     completeopt = "menu,menuone,preview,noselect",
            --     keyword_length = 3
            -- },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            --old
            -- window = {
            --     -- completion = cmp.config.window.bordered(),
            --     -- completion = {
            --     --     -- border = "rounded",
            --     --     -- winhighlight = "Normal:TelescopeNormal",
            --     -- },
            --
            --     documentation = cmp.config.window.bordered(),
            --     -- documentation = {
            --     --     border = "rounded",
            --     --     winhighlight = 'normal:pmenu,floatborder:pmenu',
            --     -- },
            -- },
            window = {
                documentation = {
                    maxheight = 15,
                    maxwidth = 50,
                    border = "rounded",
                },
                completion = {
                    -- col_offset = -3,
                    -- side_padding = 0,
                    winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                },
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Esc>"] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    local copilot = require 'copilot.suggestion'
                    if copilot.is_visible() then
                        copilot.accept()
                    elseif cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                        else
                            cmp.confirm()
                        end
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", group_index = 1 },
                { name = "luasnip",  group_index = 3 },
                { name = "path",     keyword_length = 1, group_index = 4 },
                { name = "buffer",   group_index = 2 },
            }),
            formatting = {
                fields = { "kind", "abbr" },
                format = function(_, vim_item)
                    vim_item.kind = require("aquila.core.global").icons.kind_with_space[vim_item.kind] or ""
                    return vim_item
                end,
            },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    { name = 'path' }
                },
                {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                }
            )
        })
    end,
}
