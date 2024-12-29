return {
    "stevearc/conform.nvim",
    keys = {
        { "<space>f", mode = "n" },
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                astro = { { "prettierd", "prettier" } },
                css = { { "prettierd", "prettier" } },
                html = { { "prettierd", "prettier" } },
                javascript = { { "biome", "prettierd", "prettier" } },
                javascriptreact = { { "biome", "prettierd", "prettier" } },
                json = { { "biome", "prettierd", "prettier" } },
                lua = { "stylua" },
                scss = { { "prettierd", "prettier" } },
                typescript = { { "biome", "prettierd", "prettier" } },
                typescriptreact = { { "biome", "prettierd", "prettier" } },
                yaml = { "yamlfmt" },
                rust = { "rustfmt" },
                ["_"] = { "trim_whitespace" },
            },
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
}
