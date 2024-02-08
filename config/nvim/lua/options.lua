local opts = {
	tabstop = 4,
	shiftwidth = 4,
	-- expandtab = true,
	number = true,
	swapfile = false,
	ambiwidth = "single",
	signcolumn = "yes",
	history = 100,
	termguicolors = true,
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end

vim.opt.clipboard:append({ unnamedeplus = true })
