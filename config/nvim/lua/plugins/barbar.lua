---@class LazySpec
return {
    "romgrk/barbar.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<M-1>", "<cmd>BufferGoto 1<CR>", mode = "n", desc = "Go to buffer 1" },
        { "<M-2>", "<cmd>BufferGoto 2<CR>", mode = "n", desc = "Go to buffer 2" },
        { "<M-3>", "<cmd>BufferGoto 3<CR>", mode = "n", desc = "Go to buffer 3" },
        { "<M-4>", "<cmd>BufferGoto 4<CR>", mode = "n", desc = "Go to buffer 4" },
        { "<M-5>", "<cmd>BufferGoto 5<CR>", mode = "n", desc = "Go to buffer 5" },
        { "<M-6>", "<cmd>BufferGoto 6<CR>", mode = "n", desc = "Go to buffer 6" },
        { "<M-7>", "<cmd>BufferGoto 7<CR>", mode = "n", desc = "Go to buffer 7" },
        { "<M-8>", "<cmd>BufferGoto 8<CR>", mode = "n", desc = "Go to buffer 8" },
        { "<M-9>", "<cmd>BufferGoto 9<CR>", mode = "n", desc = "Go to buffer 9" },
        { "<M-0>", "<cmd>BufferLast<CR>", mode = "n", desc = "Go to last buffer" },
        { "<M->>", "<cmd>BufferMoveNext<CR>", mode = "n", desc = "Move buffer to next" },
        { "<M-<>", "<cmd>BufferMovePrevious<CR>", mode = "n", desc = "Move buffer to previous" },
        { "<M-.>", "<cmd>BufferNext<CR>", mode = "n", desc = "Go to next buffer" },
        { "<M-,>", "<cmd>BufferPrevious<CR>", mode = "n", desc = "Goto previous buffer" },
    },
    opts = {},
}
