---@LazySpec
return {
    "hrsh7th/nvim-ix",
    dependencies = {
        "hrsh7th/nvim-cmp-kit",
    },
    event = "InsertEnter",
    enabled = false,
    config = function()
        vim.o.winborder = "rounded" -- set window border style.

        local ix = require("ix")

        -- update lsp capabilities.
        vim.lsp.config("*", {
            capabilities = ix.get_capabilities(),
        })

        -- setup autocmds and configurations.
        ix.setup({})

        -- common.
        ix.charmap({ "i", "c" }, "<C-d>", ix.action.scroll(0 + 3))
        ix.charmap({ "i", "c" }, "<C-u>", ix.action.scroll(0 - 3))

        -- completion.
        ix.charmap({ "i", "c" }, "<C-Space>", ix.action.completion.complete())
        ix.charmap({ "i", "c" }, "<C-n>", ix.action.completion.select_next())
        ix.charmap({ "i", "c" }, "<C-p>", ix.action.completion.select_prev())
        ix.charmap({ "i", "c" }, "<C-e>", ix.action.completion.close())
        ix.charmap("c", "<CR>", ix.action.completion.commit_cmdline())
        ix.charmap("i", "<CR>", ix.action.completion.commit({ select_first = true }))
        ix.charmap("i", "<Down>", ix.action.completion.select_next())
        ix.charmap("i", "<Up>", ix.action.completion.select_prev())
        ix.charmap(
            "i",
            "<C-y>",
            ix.action.completion.commit({ select_first = true, replace = true, no_snippet = true })
        )

        -- signature_help.
        ix.charmap("i", "<C-o>", ix.action.signature_help.trigger())
        ix.charmap("i", "<C-j>", ix.action.signature_help.select_next())
        ix.charmap("i", "<C-k>", ix.action.signature_help.select_prev())
    end,
}
