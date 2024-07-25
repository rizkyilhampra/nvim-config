local workspaces = {
    {
        name = "aquila-blog",
        path = "~/Notes/aquila-notes/blog",
        strict = true,
        overrides = {
            new_notes_location = "current_dir",
            templates = {
                subdir = "templates",
            },
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.date("%Y-%m-%d")) .. "-" .. suffix
            end,
            note_frontmatter_func = function(note)
                local out = {
                    title = note.title,
                    date = os.date("%Y-%m-%d %H:%M:%S %z"),
                    tags = note.tag,
                    categories = note.categories,
                    author = 'rip'
                }

                -- `note.metadata` contains any manually added fields in the frontmatter.
                -- So here we just make sure those fields are kept in the frontmatter.
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end

                return out
            end
        }
    },
    {
        name = "aquila",
        path = "~/Notes/aquila-notes",
    },
    {
        name = "blog",
        path = "~/Projects/rizkyilhampra.github.io/_posts",
        overrides = {
            templates = {
                subdir = "templates",
            },
            note_id_func = function(title)
                -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
                -- In this case a note with the title 'My new note' will be given an ID that looks
                -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
                local suffix = ""
                if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.date("%Y-%m-%d")) .. "-" .. suffix
            end,
            note_frontmatter_func = function(note)
                local out = {
                    title = note.title,
                    date = os.date("%Y-%m-%d %H:%M:%S %z"),
                    tags = {},
                    categories = {},
                    author = 'rip'
                }

                -- `note.metadata` contains any manually added fields in the frontmatter.
                -- So here we just make sure those fields are kept in the frontmatter.
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end

                return out
            end
        }
    }
}

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = {
        workspaces = workspaces
    }
}