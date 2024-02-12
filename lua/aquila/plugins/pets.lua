return {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
    event = "BufRead",
    config = function()
        require("pets").setup({
            row = 5,
            col = 0,
            speed_multiplier = 1,
            default_pet = "dog",
            default_style = "brown",
            random = false,
            death_animation = true,
            popup = {
                width = "30%",
                winblend = 100,
                hl = { Normal = "Normal" },
                avoid_statusline = true,
            }
        })
    end
}
