---@class LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "main",
    -- dependencies = {
    --     "RRethy/nvim-treesitter-endwise",
    -- },
    config = function()
        require("nvim-treesitter").setup({})

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
            callback = function(ctx) pcall(vim.treesitter.start) end,
        })
    end,
}
