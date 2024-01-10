return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    enabled = false,
    config = function()
        require('fidget').setup({
            window = {
                blend = 0
            },
        })
    end
}
