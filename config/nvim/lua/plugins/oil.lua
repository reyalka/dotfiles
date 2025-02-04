---@class LazySpec
return {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 6,
            },
        })

        local OilGroup = vim.api.nvim_create_augroup("OilGroup", { clear = false })

        -- q or <esc> to close oil
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function ()
                vim.keymap.set("n", "q", "<cmd>lua require('oil').close()<CR>", { buffer = 0 })
                vim.keymap.set("n", "<esc>", "<cmd>lua require('oil').close()<CR>", { buffer = 0 })
                vim.keymap.set("n", "<space>w", "<nop>", { buffer = 0 })
            end,
            group = OilGroup
        })

        -- disable copilot when oil is open
        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = "oil",
            group = OilGroup,
            callback = function() vim.cmd("Copilot disable") end,
        })
        vim.api.nvim_create_autocmd({ "BufLeave" }, {
            group = OilGroup,
            callback = function()
                if vim.bo.filetype == "oil" then vim.cmd("Copilot enable") end
            end,
        })
    end
}
