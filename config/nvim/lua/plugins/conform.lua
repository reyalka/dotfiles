---@class LazySpec
return {
    "stevearc/conform.nvim",
    keys = {
        { "<space>f", "<cmd>Format<cr>", mode = "n" },
    },
    opts = {
        formatters_by_ft = {
            astro = { "prettierd", "prettier" },
            css = { "prettierd", "prettier" },
            html = { "prettierd", "prettier" },
            javascript = { "biome", "prettierd", "prettier" },
            javascriptreact = { "biome", "prettierd", "prettier" },
            json = { "biome", "prettierd", "prettier" },
            scss = { "prettierd", "prettier" },
            typescript = { "biome", "prettierd", "prettier" },
            typescriptreact = { "biome", "prettierd", "prettier" },
            lua = { "stylua" },
            yaml = { "yamlfmt" },
            rust = { "rustfmt" },
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
