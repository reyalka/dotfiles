local set = vim.keymap.set

set("i", "jk", "<esc>")
set({ "n", "i", "v" }, "<c-s>", "<cmd>w<cr>", { desc = "Save file" })
set("n", "<Space>", "<NOP>")
-- set({ "i", "v" }, "<esc>", "<esc><cmd>w<cr>")
set({ "n", "v" }, "gy", '"+y')
set({ "n", "v" }, "gp", '"+p')
set("n", "gf", "gF")
set("n", "<Space>w", "<Cmd>bd<CR>", { desc = "Close buffer" })

-- -- Copilot
-- set("n", "<space>e", "<cmd>Copilot enable<cr>")
-- set("n", "<space>d", "<cmd>Copilot disable<cr>")
-- set("n", "<space>cs", "<cmd>Copilot status<cr>")

-- -- telescope keymap
-- set("n", "<space><space>", "<cmd>Telescope find_files<cr>")
-- set("n", "<space>tg", "<cmd>Telescope live_grep<cr>")
-- set("n", "<space>tt", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
-- set("n", "<space>tb", "<cmd>Telescope file_browser<cr>")
-- set("n", "<space>tf", "<cmd>Telescope frecency<cr>")

-- -- translate
-- set("x", "<space>tr", "<cmd>Translate ja<CR>")

-- -- Lspsaga terminal
-- set("n", "<space>ter", "<cmd>ToggleTerm direction=float<CR>")

-- WhichKey
set("n", "<Space>?", "<cmd>WhichKey<CR>")

-- NeoTree
set("n", "<Space>nt", "<cmd>Neotree<CR>", { desc = "Open neotree" })

-- Lazy
set("n", "<Space>l", "<cmd>Lazy<CR>")

--jaq-nvim
set("n", "<Space>j", "<cmd>Jaq<CR>")

-- nvim-window
set("n", "<Space>p", "<cmd>lua require('nvim-window').pick()<CR>", { desc = "Pick window" })
