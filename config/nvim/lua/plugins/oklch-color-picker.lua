---@class LazySpec
return {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    enabled = false,
    version = "*",
    keys = {
        -- One handed keymap recommended, you will be using the mouse
        {
            "<leader>v",
            function() require("oklch-color-picker").pick_under_cursor() end,
            desc = "Color pick under cursor",
        },
    },
    opts = {},
}
