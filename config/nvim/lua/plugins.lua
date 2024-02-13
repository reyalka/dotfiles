return {
    {
        "folke/tokyonight.nvim",
        dependencies = {
            "junegunn/seoul256.vim",
            "catppuccin/nvim",
            "cocopon/iceberg.vim",
            "tiagovla/tokyodark.nvim",
        },
        keys = {
			{"colo", mode = "c"},
        },
    },
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[
		        colorscheme everforest
      		]])
        end,
    },
    {
        "echasnovski/mini.starter",
        version = "*",
        lazy = false,
        config = function()
            require("mini.starter").setup()
        end,
    },
    {
        "vim-jp/vimdoc-ja",
        lazy = true,
        keys = {
            { "h", mode = "c" },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        version = "*",
        opts = {},
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "lambdalisue/nerdfont.vim",
            "MunifTanjim/nui.nvim",
        },
        cmd = {
            "Neotree",
        },
        config = function()
            require("neo-tree").setup()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufRead", "BufNewFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            colorscheme = "everforest",
            icons_enabled = true,
        },
        config = function()
            require("lualine").setup()
        end,
    },
    {
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup()
        end,
        event = { "BufRead", "BufNewFile" },
        cmd = {
            "CommentToggle",
            "CommentLine",
            "CommentBlock",
        },
    },
    {
        "hrsh7th/nvim-insx",
        event = "InsertEnter",
        config = function()
            require("insx.preset.standard").setup()
            local insx = require("insx")
            insx.add(
                "*",
                require("insx.recipe.auto_pair")({
                    open = [[/**]],
                    close = [[*/]],
                })
            )
        end,
    },
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        config = function()
            require("fidget").setup({
                text = {
                    spinner = {},
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            { "nvimdev/lspsaga.nvim" },
            { "windwp/nvim-ts-autotag", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
            { "ErichDonGubler/lsp_lines.nvim" },
        },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mason").setup({})
            require("nvim-ts-autotag").setup()
            -- require("lsp_lines").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "html",
                    "jsonls",
                    "tsserver",
                    "gopls",
                    "rust_analyzer",
                    "pyright",
                    "biome",
                    "lua_ls",
                    "emmet_language_server",
                },
            })

            local lspconfig = require("lspconfig")

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()
                    capabilities.textDocument.completion.completionItem.snippetSupport = true
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
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
                    set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
                    set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
                    set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
                end,
            })
            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    virtual_text = {
                        format = function(diagnostic)
                            return string.format("%s [%s: %s]", diagnostic.message, diagnostic.source, diagnostic.code)
                        end,
                        update_in_insert = true,
                    },
                })
            require("lspsaga").setup({})
        end,
    },
    {
        "mhartington/formatter.nvim",
        cmd = {
            "Format",
            "FormatWrite",
        },
        config = function()
            local biome = function()
                local util = require("formatter.util")
                return {
                    exe = "biome",
                    args = {
                        "format",
                        "--indent-style=space",
                        "--indent-width=4",
                        "--stdin-file-path",
                        util.escape_path(util.get_current_buffer_file_path()),
                    },
                    stdin = true,
                }
            end
            local joinWithDot = function(...)
                local args = { ... }
                return table.concat(args, ".")
            end
            local getFormatter = function(filetype, formattertype)
                return require(joinWithDot("formatter", "filetypes", filetype))[formattertype]
            end
            require("formatter").setup({
                filetype = {
                    html = { getFormatter("html", "prettier") },
                    css = { getFormatter("css", "prettier") },
                    scss = { getFormatter("css", "prettier") },
                    lua = { getFormatter("lua", "stylua") },
                    sh = { getFormatter("sh", "shfmt") },
                    rust = { getFormatter("rust", "rustfmt") },
                    json = { biome },
                    javascript = { biome },
                    javascriptreact = { biome },
                    typescriptreact = { biome },
                    typescript = { biome },
                },
            })
        end,
    },
    {
        "github/copilot.vim",
        cmd = "Copilot",
        event = { "BufRead", "BufNewFile" },
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "UIEnter" },
        config = function()
            require("hlchunk").setup({
                line_num = {
                    enable = false,
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-calc" },
            { "onsails/lspkind.nvim" },
            { "saadparwaiz1/cmp_luasnip" },
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "calc" },
                }),
                cmp.setup.cmdline(":", {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = "cmdline" },
                        { name = "path" },
                    },
                }),
                cmp.setup.cmdline({ "/", "?" }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = "path" },
                        { name = "buffer" },
                    },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "LspAttach",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "lua",
                    "vim",
                    "vimdoc",
                    "javascript",
                    "html",
                    "typescript",
                    "tsx",
                    "scss",
                    "css",
                    "markdown",
                    "markdown_inline",
                    "svelte",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                autotag = { enable = true },
            })
            require("nvim-treesitter.parsers").get_parser_configs().tsx.filetype_to_parsername =
                { "javascript", "typescript.tsx" }
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-frecency.nvim" },
            { "xiyaowong/telescope-emoji.nvim" },
            { "sankantsu/telescope-zenn.nvim" },
        },
        cmd = "Telescope",
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            telescope.setup({
                defaults = {
                    mappings = {
                        n = { ["q"] = actions.close },
                        i = { ["<esc>"] = actions.close },
                    },
                },
            })
            telescope.load_extension("file_browser")
            telescope.load_extension("frecency")
            telescope.load_extension("emoji")
            telescope.load_extension("zenn")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("bufferline").setup()
        end,
    },
    {
        "yorickpeterse/nvim-window",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("nvim-window").setup({})
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        cmd = { "HighlightColorsOn", "HighlightColorsOff", "HighlightColorsToggle" },
        config = function()
            require("nvim-highlight-colors").setup()
        end,
    },
    -- {
    --     "vim-skk/skkeleton",
    --     dependencies = {
    --         "vim-denops/denops.vim",
    --     },
    --     keys = {
    --         {
    --             "<C-l>",
    --             "<Plug>(skkeleton-toggle)",
    --             mode = { "i", "c" },
    --             desc = "Enable skkeleton",
    --         },
    --     },
    --     config = function()
    --         vim.cmd([[
    --     call skkeleton#config({ 'globalJisyo': '~/.skk/SKK-JISYO.L' })
    --   ]])
    --     end,
    -- },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            presets = {
                bottom_search = false, -- use a classic bottom cmdline for search
                command_palette = false, -- position the cmdline and popupmenu together
                long_message_to_split = false, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
            lsp = { progress = { enabled = false } },
        },
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            render = "compact",
            stages = "slide",
            timeout = 3000,
        },
    },
    {
        "stevearc/aerial.nvim",
        opts = {},
        cmd = { "Aerial", "AerialOpenAllBuffers", "AerialCloseAllBuffers", "AerialToggle" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("aerial").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        lazy = true,
        cmd = {
            "WhichKey",
        },
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "thinca/vim-scouter",
        cmd = {
            "Scouter",
        },
    },
    {
        "stevearc/oil.nvim",
        cmd = {
            "Oil",
        },
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                },
                float = {
                    padding = 6,
                },
            })
        end,
    },
    {
        "uga-rosa/translate.nvim",
        cmd = "Translate",
        opts = {},
    },
    {
        "simeji/winresizer",
        keys = {
            "<C-e>",
            mode = "n",
        },
    },
    {
        "is0n/jaq-nvim",
        cmd = {
            "Jaq",
        },
        config = function()
            require("jaq-nvim").setup({
                cmds = {
                    internal = {
                        lua = "luafile %",
                        vim = "source %",
                    },
                    external = {
                        python = "python3 %",
                        rust = "cargo run",
                        sh = " bash %",
                        fish = "fish %",
                    },
                },
                ui = {
                    float = {
                        border = "rounded",
                    },
                },
            })
        end,
    },
    {
        "NStefan002/2048.nvim",
        cmd = "Play2048",
        opts = {
            -- your config
        },
    },
}
