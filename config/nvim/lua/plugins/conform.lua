---@class LazySpec
return {
    "stevearc/conform.nvim",
    keys = {
        { "<space>f", "<cmd>Format<cr>", mode = "n", desc = "Format" },
    },
    opts = {
        formatters_by_ft = {
            astro = { "prettierd", "prettier" },
            css = { "prettierd", "prettier" },
            html = { "prettierd", "prettier" },
            javascript = { "biome", "prettierd", "prettier" },
            javascriptreact = { "biome", "prettierd", "prettier" },
            json = { "biome", "prettierd", "prettier" },
            lua = { "stylua" },
            nix = { "nixfmt" },
            rust = { "rustfmt" },
            scss = { "prettierd", "prettier" },
            typescript = { "biome", "prettierd", "prettier" },
            typescriptreact = { "biome", "prettierd", "prettier" },
            yaml = { "yamlfmt" },
            ["_"] = { "trim_whitespace" },
        },
        format_on_save = {
            lsp_fallback = true,
            timeout = 500,
        },
    },
    config = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args) require("conform").format({ bufnr = args.buf }) end,
        })
    end,
}
