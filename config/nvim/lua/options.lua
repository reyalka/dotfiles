local opts = {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  number = true,
  swapfile = false,
  ambiwidth = "single",
  signcolumn = "yes",
  history = 100,
  -- line = true,
  -- listchars = { tab = '>>', trail = '-', nbsp = '+' },
}

for k, v in pairs(opts) do
  vim.opt[k] = v
end

vim.opt.clipboard:append({ unnamedeplus = true })
