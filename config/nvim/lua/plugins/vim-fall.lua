---@class LazySpec
return {
    "vim-fall/fall.vim",
    dependencies = {
        { "vim-denops/denops.vim" },
    },
    keys = {
        { "<space><space>", "<cmd>Fall file<cr>", mode = "n", desc = "Pick file" },
        { "<space>.", "<cmd>Fall file:all", mode = "n", desc = "Pick file including hidden files" },
        { "<space>r", "<cmd>Fall rg<cr>", mode = "n", desc = "Pick with ripgrep" },
        { "<space>/", "<cmd>Fall line<cr>", mode = "n", desc = "Pick current lines" },
        { "<M-space>", "<cmd>Fall buffer<cr>", mode = "n", desc = "Pick buffers" },
    },
    cmd = "Fall",
    event = "VimEnter",
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
