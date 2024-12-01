return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "javascript", "typescript", "c", "lua", "rust" },
			highlight = { enable = true },
			indent = { enable = false},
		})
	end
}
