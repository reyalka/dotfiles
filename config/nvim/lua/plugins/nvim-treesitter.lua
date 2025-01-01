return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "LspAttach",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = {
                "fish",
                "json",
                "astro",
                "css",
                "html",
                "javascript",
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
