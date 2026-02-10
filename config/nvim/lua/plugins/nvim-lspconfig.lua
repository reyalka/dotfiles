local servers = {
    "astro",
    "bashls",
    "biome",
    "clangd",
    "cssls",
    "denols",
    "emmet_language_server",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "nil_ls",
    "pyright",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
    "tombi",
    "ts_ls",
}
local filetypes = {
    "astro",
    "bash",
    "c",
    "css",
    "go",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "nix",
    "python",
    "rust",
    "sass",
    "scss",
    "sh",
    "svelte",
    "svelte",
    "toml",
    "typescript",
    "typescriptreact",
    "xml",
}
---@class LazySpec
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason.nvim",
            cmd = "Mason",
            opts = servers,
        },
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        { "nvimdev/lspsaga.nvim" },
    },
    ft = filetypes,
    config = function()
        require("lspsaga").setup({})
        local set = vim.keymap.set
        set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Go to Definition" })
        set("n", "gr", "<cmd>Lspsaga finder<CR>", { desc = "References" })
        set("n", "ga", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
        set("n", "gs", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show Line Diagnostics" })
        set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Documentation" })
        set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
        set("n", "<F2>", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
        set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Previous Diagnostic" })
        set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })
        set("n", "g@", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show Cursor Diagnostics" })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        local function on_attach(client, bufnr)
            if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end
        end

        vim.lsp.config("*", {
            capabilities = capabilities,
            on_attach = on_attach,
        })

        local copied_servers = vim.tbl_extend("force", {}, servers)
        local enabled_servers = vim.tbl_filter(
            function(server) return server ~= "denols" or server ~= "ts_ls" end,
            copied_servers
        )
        vim.lsp.enable(enabled_servers)

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("LspStartJS", { clear = true }),
            callback = function(ctx)
                if
                    not vim.tbl_contains({
                        "javascript",
                        "javascriptreact",
                        "javascript.jsx",
                        "typescript",
                        "typescriptreact",
                    }, ctx.match)
                then
                    return
                end

                if vim.fn.findfile("package.json", ".;") ~= "" then
                    vim.lsp.enable("ts_ls")
                else
                    vim.lsp.enable("denols")
                end
            end,
        })

        vim.diagnostic.config({
            severity_sort = true,
            float = {
                title = "Diagnostics",
                border = "double",
                format = function(diagnostic)
                    if diagnostic.code then
                        return string.format("%s [%s](%s)", diagnostic.message, diagnostic.source, diagnostic.code)
                    end
                    return string.format("%s [%s]", diagnostic.message, diagnostic.source)
                end,
            },
        })
    end,
}
