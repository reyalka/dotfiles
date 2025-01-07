---@class LazySpec
return {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    config = function()
        local insx = require("insx")

        require("insx.preset.standard").setup()

        insx.add("*", {
            enabled = function(ctx) return ctx.match([=[\/\*\%#]=]) end,
            action = function(ctx)
                -- 初期:/*|

                -- ① :/**|
                ctx.send("*")
                -- 位置を保存
                local row, col = ctx.row(), ctx.col()
                -- ② :/** */|
                ctx.send("<space>*/")
                -- ③ :/**| */
                ctx.move(row, col)
            end,
        })
    end,
}
