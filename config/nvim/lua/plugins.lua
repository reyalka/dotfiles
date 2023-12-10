return {
  {
    "folke/tokyonight.nvim",
    dependencies = {
      {
        "junegunn/seoul256.vim",
      },
    },
    cmd = {
      "LoadColorSheme",
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
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").opts)
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
    version = "*",
    enabled = false,
    config = true,
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
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require("fidget").setup({
        text = {
          spinner = "moon",
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
      { "windwp/nvim-ts-autotag" },
    },
    event = "VeryLazy",
    config = function()
      require("mason").setup({})
      require("nvim-ts-autotag").setup()
      local lspconfig = require("lspconfig")
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
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          lspconfig[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
          lspconfig.tsserver.setup({
            on_attach = function(client)
              client.resolved_capabilities.document_formatting = false
            end,
          })
          lspconfig.tailwindcss.setup({
            filetypes = {
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
          set("n", "<Space>gh", "<cmd>Lspsaga hover_doc<CR>")
          set("n", "<Space>gf", "<cmd>lua vim.lsp.buf.format()<CR>")
          set("n", "<Space>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
          set("n", "<Space>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
          set("n", "<Space>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
          set("n", "<Space>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
          set("n", "<Space>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
          set("n", "<Space>gn", "<cmd>lua vim.lsp.buf.rename()<CR>")
          set("n", "<Space>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
          set("n", "<Space>ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
          set("n", "<Space>g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
          set("n", "<Space>g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
        end,
      })
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
          format = function(diagnostic)
            return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
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
      local formatter = require("formatter")
      local biome = function()
        local util = require("formatter.util")
        return {
          exe = "biome",
          args = {
            "format",
            "--indent-style=space",
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
          -- scss = { getFormatter("scss", "prettier") },
          lua = { getFormatter("lua", "stylua") },
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
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "onsails/lspkind.nvim" },
      { "saadparwaiz1/cmp_luasnip" },
      { "L3MON4D3/LuaSnip" },
      { "uga-rosa/cmp-skkeleton" },
      { "hrsh7th/cmp-copilot" },
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
          { name = "nvim_lsp", group_index = 2 },
          { name = "luasnip" },
          { name = "path" },
          { name = "cmdline" },
          { name = "skkeleton" },
        }),
        cmp.setup.cmdline(":", {
          sources = {
            { name = "cmdline" },
            { name = "path" },
          },
        }),
        cmp.setup.cmdline({ "/", "?" }, {
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
    event = { "BufRead", "BufNewFile" },
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
      { "nvim-telescope/telescope-file-browser.nvim", event = "VeryLazy" },
      { "nvim-telescope/telescope-frecency.nvim", event = "VeryLazy" },
      { "xiyaowong/telescope-emoji.nvim", event = "VeryLazy" },
      { "sankantsu/telescope-zenn.nvim", event = "VeryLazy" },
    },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      telescope.setup({})
      telescope.load_extension("file_browser")
      telescope.load_extension("frecency")
      telescope.load_extension("emoji")
      telescope.load_extension("zenn")
      -- to avoid error about "not found keymap"
      local set = vim.keymap.set
      set("n", "<esc>", "<cmd>Telescope close<cr>")
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
    "brenoprata10/nvim-highlight-colors",
    cmd = { "HighlightColorsOn", "HighlightColorsOff", "HighlightColorsToggle" },
    config = function()
      require("nvim-highlight-colors").setup()
    end,
  },
  {
    "vim-skk/skkeleton",
    dependencies = {
      "vim-denops/denops.vim",
    },
    event = "VeryLazy",
    config = function()
      vim.cmd([[
        call skkeleton#config({ 'globalJisyo': '~/.skk/SKK-JISYO.L' })
        imap <C-l> <Plug>(skkeleton-enable)
        cmap <C-l> <Plug>(skkeleton-enable)
      ]])
    end,
  },
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
      "ScouterClear",
      "ScouterToggle",
      "ScouterToggleClear",
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    cmd = {
      "Oil",
    },
    config = function()
      require("oil").setup()
    end,
  },
}
