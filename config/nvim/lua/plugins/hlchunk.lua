---@class LazySpec
return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("hlchunk").setup({
            -- chunk = {
            --     enable = false,
            -- },
            -- line_num = {
            --     enable = false,
            -- },
        })
    end,
}
