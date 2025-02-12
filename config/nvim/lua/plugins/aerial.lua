---@class LazySpec
return {
    "stevearc/aerial.nvim",
    cmd = { "Aerial", "AerialOpenAllBuffers", "AerialCloseAllBuffers", "AerialToggle" },
    keys = {
        -- { "<space>a", "<cmd>AerialNavToggle<CR>", mode = "n" },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
        layout = {
            default_direction = "prefer_left",
        },
    },
}
