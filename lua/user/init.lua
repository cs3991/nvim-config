require("user.remap")

vim.opt.scrolloff = 8
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.smartindent = true

