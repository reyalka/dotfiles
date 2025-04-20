---@class LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "LspAttach",
    dependencies = {
        "RRethy/nvim-treesitter-endwise",
    },
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
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
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
        })

        require("nvim-treesitter.parsers").get_parser_configs().tsx.filetype_to_parsername =
            { "javascript", "typescript.tsx" }
    end,
}
