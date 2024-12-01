return {
	"neovim/nvim-lspconfig",
	config = function()
		require("lspconfig").clangd.setup({
			vim.diagnostic.config({
				virtual_text = true,      -- Show errors inline as virtual text
				signs = true,             -- Show errors in the gutter
				underline = true,         -- Underline errors in the text
				update_in_insert = false, -- Update diagnostics only after leaving insert mode
			})
		})
	end
}
