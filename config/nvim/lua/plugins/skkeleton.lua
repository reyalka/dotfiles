---@class LazySpec
return {
    "vim-skk/skkeleton",
    dependencies = {
        { "vim-denops/denops.vim" },
        { "delphinus/skkeleton_indicator.nvim", opts = {} },
    },
    event = "InsertEnter",
    enabled = false,
    config = function()
        local opts = { noremap = true, silent = true }
        local set = vim.keymap.set
        set({ "n", "i", "t" }, "<M-j>", "<Plug>(skkeleton-toggle)", opts)
        vim.fn["skkeleton#config"]({
            globalDictionaries = { "~/.skk/SKK-JISYO.L" },
            eggLikeNewline = true,
        })
    end,
}
