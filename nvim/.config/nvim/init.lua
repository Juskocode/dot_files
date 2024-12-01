require("remap")
require("lazyplugin")
require("set")
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  pattern = "*",
  command = "silent! write",
})

