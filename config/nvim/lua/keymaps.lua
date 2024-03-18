local set = vim.keymap.set

set("i", "jk", "<esc>")
set({ "n", "i", "v" }, "<c-s>", "<cmd>w<cr>", { desc = "Save file" })
set("n", "<Space>", "<NOP>")
set({ "i", "v" }, "<esc>", "<esc><cmd>w<cr>")

-- Copilot
set("n", "<space>e", "<cmd>Copilot enable<cr>")
set("n", "<space>d", "<cmd>Copilot disable<cr>")
set("n", "<space>cs", "<cmd>Copilot status<cr>")

-- telescope keymap
set("n", "<space><space>", "<cmd>Telescope find_files<cr>")
set("n", "<space>tg", "<cmd>Telescope live_grep<cr>")
set("n", "<space>tt", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
set("n", "<space>tb", "<cmd>Telescope file_browser<cr>")
set("n", "<space>tf", "<cmd>Telescope frecency<cr>")

-- translate
set("x", "<space>tr", "<cmd>Translate ja<CR>")

-- Lspsaga terminal
set("n", "<space>ter", "<cmd>ToggleTerm direction=float<CR>")

-- bufferline
set("n", "<Space>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
set("n", "<Space>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
set("n", "<Space>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
set("n", "<Space>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
set("n", "<Space>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
set("n", "<Space>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
set("n", "<Space>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
set("n", "<Space>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
set("n", "<Space>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })
set("n", "<Space>s", "<Cmd>BufferLineSortByDirectory<CR>", { desc = "Sort buffers by directory" })
set("n", "<Space><tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
set("n", "<Space><S-tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
set("n", "<Space>w", "<Cmd>bd<CR>", { desc = "Close buffer" })

-- WhichKey
set("n", "<Space>?", "<cmd>WhichKey<CR>")

-- Aerial
set("n", "<Space>a", "<cmd>AerialToggle!<CR>", { desc = "Show index" })

-- NeoTree
set("n", "<Space>nt", "<cmd>Neotree<CR>", { desc = "Open neotree" })

-- Oil
set("n", "<Space>o", "<cmd>lua require('oil').open_float()<CR>", { desc = "Open oil in float window" })

-- Lazy
set("n", "<Space>l", "<cmd>Lazy<CR>")

-- --formatter
-- set("n", "<Space>f", "<cmd>FormatWrite<CR>", { desc = "Format and save file" })

-- conform
set("n", "<Space>f", "<cmd>lua require('conform').format()<CR><cmd>w<CR>", { desc = "Format and save file" })

--jaq-nvim
set("n", "<Space>j", "<cmd>Jaq<CR>")

-- nvim-window
set("n", "<Space>p", "<cmd>lua require('nvim-window').pick()<CR>", { desc = "Pick window" })
