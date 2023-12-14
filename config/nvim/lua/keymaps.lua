local set = vim.keymap.set

set("i", "jk", "<esc>")
set("i", "ｊｋ", "<esc>")
set({ "n", "i", "v" }, "<c-s>", "<cmd>w<cr>")
-- set("n", "J", "10j")
-- set("n", "K", "10k")
set("n", "<Space>", "<NOP>")

-- Copilot
set("n", "<space>e", "<cmd>Copilot enable<cr>")
set("n", "<space>cd", "<cmd>Copilot disable<cr>")
set("n", "<space>cs", "<cmd>Copilot status<cr>")

-- telescope keymap
set("n", "<space><space>", "<cmd>Telescope find_files<cr>")
set("n", "<space>tg", "<cmd>Telescope live_grep<cr>")
set("n", "<space>tt", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
set("n", "<space>tb", "<cmd>Telescope file_browser<cr>")
set("n", "<space>tf", "<cmd>Telescope frecency<cr>")
set("n", "<space>te", "<cmd>Telescope emoji<cr>")

-- bufferline
set('n', '<Space>1', '<Cmd>BufferLineGoToBuffer 1<CR>')
set('n', '<Space>2', '<Cmd>BufferLineGoToBuffer 2<CR>')
set('n', '<Space>3', '<Cmd>BufferLineGoToBuffer 3<CR>')
set('n', '<Space>4', '<Cmd>BufferLineGoToBuffer 4<CR>')
set('n', '<Space>5', '<Cmd>BufferLineGoToBuffer 5<CR>')
set('n', '<Space>6', '<Cmd>BufferLineGoToBuffer 6<CR>')
set('n', '<Space>7', '<Cmd>BufferLineGoToBuffer 7<CR>')
set('n', '<Space>8', '<Cmd>BufferLineGoToBuffer 8<CR>')
set('n', '<Space>9', '<Cmd>BufferLineGoToBuffer 9<CR>')
set("n", "<Space>w", "<Cmd>bd<CR>")

-- WhichKey
set("n", "<Space>?", "<cmd>WhichKey<CR>")

-- Aerial
set("n", "<Space>a", "<cmd>AerialToggle!<CR>")

-- NeoTree
set("n", "<Space>nt", "<cmd>Neotree<CR>")

-- Oil
set("n", "<Space>o", "<cmd>Oil<CR>")

-- Lazy
set("n", "<Space>l", "<cmd>Lazy<CR>")

--formatter
set("n", "<Space>f", "<cmd>FormatWrite<CR>")

--jaq-nvim
set("n", "<Space>j", "<cmd>Jaq<CR>")

