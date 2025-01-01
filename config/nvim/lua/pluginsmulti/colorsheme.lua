return {
    "BrunoCiccarino/nekonight",
    lazy = false,
    priority = 1000,
    config = function()
        require("nekonight").setup({
            on_colors = function(colors) colors.bg_float = colors.bg end,
        })

        vim.cmd("colorscheme nekonight")

        local highlights = {
            Front = { bg = "#4c3f5c" },
        }
        for gorup, hl in pairs(highlights) do
            vim.api.nvim_set_hl(0, gorup, hl)
        end
    end,
}
