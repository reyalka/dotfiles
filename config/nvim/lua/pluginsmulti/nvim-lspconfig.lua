return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        { "nvimdev/lspsaga.nvim" },
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")
        require("mason").setup({})
        require("lspsaga").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "astro",
                "bashls",
                "biome",
                "cssls",
                "emmet_language_server",
                "html",
                "jsonls",
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "tsserver",
            },
        })

        ---@param names string[]
        ---@return string[]
        local function get_plugin_paths(names)
            local plugins = require("lazy.core.config").plugins
            local paths = {}
            for _, name in ipairs(names) do
                if plugins[name] then
                    table.insert(paths, plugins[name].dir .. "/lua")
                else
                    vim.notify("Invalid plugin name: " .. name)
                end
            end
            return paths
        end

        ---@param plugins string[]
        ---@return string[]
        local function library(plugins)
            local paths = get_plugin_paths(plugins)
            table.insert(paths, vim.fn.stdpath("config") .. "/lua")
            table.insert(paths, vim.env.VIMRUNTIME .. "/lua")
            table.insert(paths, "${3rd}/luv/library")
            table.insert(paths, "${3rd}/busted/library")
            table.insert(paths, "${3rd}/luassert/library")
            return paths
        end

        require("mason-lspconfig").setup_handlers({
            function(server_name)
                -- TODO: fix after cmp
                -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
                -- capabilities.textDocument.completion.completionItem.snippetSupport = true
                -- lspconfig[server_name].setup({
                --     capabilities = capabilities,
                -- })
            end,
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup({
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                                pathStrict = true,
                                path = { "?.lua", "?/init.lua" },
                            },
                            workspace = {
                                library = library({ "lazy.nvim", "nvim-insx" }),
                                checkThirdParty = "Disable",
                            },
                        },
                    },
                })
            end,
            ["tsserver"] = function()
                lspconfig.tsserver.setup({
                    on_attach = function(client)
                        client.resolved_capabilities.document_formatting = false
                    end,
                })
            end,
            ["tailwindcss"] = function()
                lspconfig.tailwindcss.setup({
                    filetypes = {
                        "astro",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                    },
                })
            end,
            ["emmet_language_server"] = function()
                lspconfig.emmet_language_server.setup({
                    filetypes = {
                        "html",
                        "css",
                        "scss",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                    },
                })
            end,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(_)
                local set = vim.keymap.set
                set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
                set("n", "gF", "<cmd>Lspsaga finder<CR>")
                set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
                set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
                set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
                set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>")
                set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
                set("n", "<Space>n", "<cmd>Lspsaga rename<CR>")
                set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
                set("n", "g@", "<cmd>lua vim.diagnostic.open_float()<CR>")
                set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
                set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
            end,
        })
        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = {
                format = function(diagnostic)
                    return string.format("%s [%s : \n%s]", diagnostic.message, diagnostic.source, diagnostic.code)
                end,
                update_in_insert = true,
            },
        })
    end,
}
