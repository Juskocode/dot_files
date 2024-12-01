vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tm', ':vsplit term://%:p:h//bash<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('v', '<C-y>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>yy', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>dd', '"+d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dd', '"+yy', { noremap = true, silent = true })
