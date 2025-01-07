---@class LazySpec
return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
        require("fidget").setup({
            text = {
                spinner = {},
            },
        })
    end,
}
