
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})

-- Copy to clipboard
vim.keymap.set('v', '<leader>y', '"+y')      -- Visual mode: Copy selection to system clipboard
vim.keymap.set('n', '<leader>Y', '"+yg_')    -- Normal mode: Copy to end of line to system clipboard
vim.keymap.set('n', '<leader>y', '"+y')      -- Normal mode: Copy to system clipboard (single operation)
vim.keymap.set('n', '<leader>yy', '"+yy')    -- Normal mode: Copy entire line to system clipboard

-- Paste from clipboard
vim.keymap.set('n', '<leader>p', '"+p')      -- Normal mode: Paste after cursor from system clipboard
vim.keymap.set('n', '<leader>P', '"+P')      -- Normal mode: Paste before cursor from system clipboard
vim.keymap.set('v', '<leader>p', '"+p')      -- Visual mode: Paste and replace selection with clipboard content
vim.keymap.set('v', '<leader>P', '"+P')      -- Visual mode: Paste before selection from clipboard

