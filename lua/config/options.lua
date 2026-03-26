local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.softtabstop = 4
opt.shiftround = true
opt.mouse = "a"
opt.encoding = "utf-8"
opt.clipboard:append("unnamedplus")
opt.background = "dark"
opt.termguicolors = true
opt.modifiable = true
opt.breakindent = true
opt.showbreak = "↪ "
opt.linebreak = true
opt.preserveindent = true

vim.o.verbose = 0

-- Suppress verbose messages in Handlebars buffers (html indent can re-enable it)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "handlebars", "html.handlebars" },
  callback = function()
    vim.o.verbose = 0
  end,
})

vim.g.mapleader = ","
