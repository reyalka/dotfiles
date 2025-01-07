---@class LazySpec
return {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            theme = "nekonight",
            icons_enabled = true,
            sections = {
                lualine_x = { "encoding", "filetype" },
            },
        })
    end,
}
