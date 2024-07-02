local M = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    highlight = { enable = true },
  indent = { enable = true },
  auto_install = true,
}

return { M }
