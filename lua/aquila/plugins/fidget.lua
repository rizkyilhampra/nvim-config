return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
        require('fidget').setup({
            window = {
                blend = 0
            },
        })
    end
}
