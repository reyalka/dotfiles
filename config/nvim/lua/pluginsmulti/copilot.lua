return {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "LspAttach",
    config = function()
        local CopilotGroup = vim.api.nvim_create_augroup("MyCopilotController", { clear = true })

        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = "oil",
            group = CopilotGroup,
            callback = function()
                vim.cmd("Copilot disable")
            end,
        })
        vim.api.nvim_create_autocmd({ "BufLeave" }, {
            group = CopilotGroup,
            callback = function()
                if vim.bo.filetype == "oil" then
                    vim.cmd("Copilot enable")
                end
            end,
        })
    end,
}
