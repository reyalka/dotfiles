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
        local lspconfig = require("lspconfig")
        require("lspsaga").setup({})

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        -- capabilities.textDocument.completion.completionItem.snippetSupport = true

        vim.lsp.config("*", {
            capabilities = capabilities,
        })
        vim.lsp.enable(servers)
        -- local function is_node_dir()
        --     return lspconfig.util.root_pattern("package.json")(vim.fn.getcwd())
        -- end
        --
        -- local server_configs = {
        --     lua_ls = {
        --         settings = {
        --             Lua = {
        --                 runtime = {
        --                     version = "LuaJIT",
        --                 },
        --                 diagnostics = {
        --                     globals = { "vim" },
        --                 },
        --                 workspace = {
        --                     library = vim.api.nvim_get_runtime_file("", true),
        --                     checkThirdParty = false,
        --                 },
        --             },
        --         },
        --     },
        --     tsserver = {
        --         on_attach = function(client, bufnr)
        --             on_attach(client, bufnr)
        --             if not is_node_dir() then
        --                 client.stop(true)
        --             end
        --         end,
        --     },
        --     denols = {
        --         on_attach = function(client, bufnr)
        --             on_attach(client, bufnr)
        --             if is_node_dir() then
        --                 client.stop(true)
        --             end
        --         end,
        --     },
        --     tailwindcss = {
        --         filetypes = {
        --             "astro",
        --             "javascriptreact",
        --             "typescriptreact",
        --             "svelte",
        --             "vue",
        --         },
        --     },
        --     emmet_language_server = {
        --         filetypes = {
        --             "astro",
        --             "css",
        --             "html",
        --             "javascript",
        --             "javascriptreact",
        --             "scss",
        --             "typescript",
        --             "typescriptreact",
        --         },
        --     },
        -- }
        --
        -- for _, server_name in ipairs(servers) do
        --     local config = {
        --         on_attach = on_attach,
        --         capabilities = capabilities,
        --     }
        --     if server_configs[server_name] then
        --         config = vim.tbl_deep_extend("force", config, server_configs[server_name])
        --     end
        --     lspconfig[server_name].setup(config)
        -- end

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {
                format = function(diagnostic)
                    if diagnostic.code then
                        return string.format("%s [%s](%s)", diagnostic.message, diagnostic.source, diagnostic.code)
                    end
                    return string.format("%s [%s]", diagnostic.message, diagnostic.source)
                end,
                update_in_insert = true,
            },
        })

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
