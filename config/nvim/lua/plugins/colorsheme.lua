---@type LazySpec[]
local colorschemes = {
    tokyonight = {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function() vim.cmd.colorscheme("tokyonight") end,
    },
    ayu = {
        "ayu-theme/ayu-vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("ayu")
            vim.g.ayucolor = "mirage"
        end,
    },
    gruvbox = {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function() vim.cmd.colorscheme("gruvbox") end,
    },
    nekonight = {
        "BrunoCiccarino/nekonight",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function() vim.cmd.colorscheme("nekonight-moon") end,
    },
}

return colorschemes.tokyonight
