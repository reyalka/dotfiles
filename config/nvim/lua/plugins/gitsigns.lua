---@class LazySpec
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function() require("gitsigns").setup() end,
}
