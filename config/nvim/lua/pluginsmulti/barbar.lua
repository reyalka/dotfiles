return
---@class LazySpec
{
    "romgrk/barbar.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<M-1>", "<cmd>BufferGoto 1<CR>", mode = "n" },
        { "<M-2>", "<cmd>BufferGoto 2<CR>", mode = "n" },
        { "<M-3>", "<cmd>BufferGoto 3<CR>", mode = "n" },
        { "<M-4>", "<cmd>BufferGoto 4<CR>", mode = "n" },
        { "<M-5>", "<cmd>BufferGoto 5<CR>", mode = "n" },
        { "<M-6>", "<cmd>BufferGoto 6<CR>", mode = "n" },
        { "<M-7>", "<cmd>BufferGoto 7<CR>", mode = "n" },
        { "<M-8>", "<cmd>BufferGoto 8<CR>", mode = "n" },
        { "<M-9>", "<cmd>BufferGoto 9<CR>", mode = "n" },
        { "<M-0>", "<cmd>BufferLast<CR>", mode = "n" },
        { "<M->>", "<cmd>BufferMoveNext<CR>", mode = "n" },
        { "<M-<>", "<cmd>BufferMovePrevious<CR>", mode = "n" },
        { "<M-,>", "<cmd>BufferNext<CR>", mode = "n" },
        { "<M-.>", "<cmd>BufferPrevious<CR>", mode = "n" },
    },
    opts = {},
}
