require("config.lazy")
require("user.init")

vim.opt.termguicolors = true
-- vim.cmd [[colorscheme melange]]
vim.cmd.colorscheme('tokyonight')
vim.g.netrw_liststyle = 3

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

