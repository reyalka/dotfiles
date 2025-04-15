---@class LazySpec
return {
    "echasnovski/mini.comment",
    event = "InsertEnter",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "InsertEnter",
    },
    version = false,
    config = function()
        require("mini.comment").setup({
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        })
    end,
}
