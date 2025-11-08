---@class LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "main",
    -- dependencies = {
    --     "RRethy/nvim-treesitter-endwise",
    -- },
    opts = {
        ensure_installed = {
            "astro",
            "css",
            "fish",
            "html",
            "javascript",
            "json",
            "just",
            "kdl",
            "lua",
            "markdown",
            "markdown_inline",
            "scss",
            "svelte",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    },
}
