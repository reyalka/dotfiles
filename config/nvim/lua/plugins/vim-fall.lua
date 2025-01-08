---@class LazySpec
return {
    "vim-fall/fall.vim",
    dependencies = {
        { "vim-denops/denops.vim" },
    },
    keys = {
        { "<space><space>", "<cmd>Fall file<cr>", mode = "n" },
        { "<space>.", "<cmd>Fall file:all", mode = "n" },
        { "<space>g", "<cmd>Fall rg<cr>", mode = "n" },
        { "<space>/", "<cmd>Fall line<cr>", mode = "n" },
        { "<M-space>", "<cmd>Fall buffer<cr>", mode = "n" },
    },
    cmd = "Fall",
    config = function()
        local FallPicker = vim.api.nvim_create_augroup("FallPicker", { clear = true })

        vim.api.nvim_create_autocmd("User", {
            group = FallPicker,
            pattern = "FallPickerEnter:*",
            callback = function() vim.cmd("Noice disable") end,
        })

        vim.api.nvim_create_autocmd("User", {
            group = FallPicker,
            pattern = "FallPickerLeave:*",
            callback = function() vim.cmd("Noice enable") end,
        })
    end,
}
