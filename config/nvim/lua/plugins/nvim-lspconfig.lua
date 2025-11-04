local servers = {
    "astro",
    "bashls",
    "biome",
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
    "tailwindcss",
    "ts_ls",
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
    event = { "BufRead", "BufNewFile" },
    config = function()
        require("lspsaga").setup({})

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        local function on_attach(client, bufnr)
            local set = vim.keymap.set
            set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { buffer = bufnr, desc = "Go to Definition" })
            set("n", "gr", "<cmd>Lspsaga finder<CR>", { buffer = bufnr, desc = "References" })
            set("n", "ga", "<cmd>Lspsaga code_action<CR>", { buffer = bufnr, desc = "Code Action" })
            set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { buffer = bufnr, desc = "Hover Documentation" })
            set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { buffer = bufnr, desc = "Rename" })
            set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { buffer = bufnr, desc = "Previous Diagnostic" })
            set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { buffer = bufnr, desc = "Next Diagnostic" })

            if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end
        end

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })

        vim.lsp.config("*", {
            capabilities = capabilities,
            on_attach = on_attach,
        })
        vim.lsp.enable(servers)

        vim.diagnostic.config({
            severity_sort = true,
            float = {
                title = "Diagnostics",
                border = "solid",
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
