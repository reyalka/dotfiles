return {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = false,
            },
            line_num = {
                enable = false,
            },
        })
    end,
}
