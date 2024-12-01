return {
	"ellisonleao/gruvbox.nvim",
	name = "gruvbox",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			transparent_mode = true, -- Enable transparency
			contrast = "hard",      -- Choose "hard", "soft", or "medium"
		})
		--vim.cmd.colorscheme "gruvbox"
	end
}

