vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ async = true, lsp_fallback = true, range = range })
    print("Formatted")
end, { range = true, desc = "Format current buffer" })

vim.keymap.set("n", "gf", function()
    local cfile = vim.fn.expand("<cfile>")

    if cfile:match("^https?://") then
        vim.ui.open(cfile)
    elseif cfile:match("^[a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+$") then
        vim.ui.open(("https://github.com/%s"):format(cfile))
    else
        vim.cmd("normal! gf")
    end
end)
