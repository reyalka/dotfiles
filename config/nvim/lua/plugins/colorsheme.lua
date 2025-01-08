return {
    "folke/tokyonight.nvim",
    -- "BrunoCiccarino/nekonight",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd.colorscheme("tokyonight") end,
}
