return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    require("everforest").setup({
	    ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
    background = "soft",  -- Use "soft" for a lighter feel on a light background
    ---How much of the background should be transparent.
    transparent_background_level = 2,  -- Slight transparency for UI components
    ---Whether italics should be used for keywords and more.
    italics = false,  -- Enable italics for better text distinction
    ---Disable italic fonts for comments. 
    disable_italic_comments = true,  -- Make comments non-italic for readability
    ---Color of the sign column background
    sign_column_background = "none",  -- Keep it transparent for blending
    ---The contrast of line numbers, indent lines, etc.
    ui_contrast = "high",  -- High contrast for better visibility
    ---Dim inactive windows.
    dim_inactive_windows = true,  -- Dimmed inactive windows can reduce clutter
    ---Diagnostic text highlighting
    diagnostic_text_highlight = true,  -- Highlight diagnostic texts for clarity
    ---Which colour the diagnostic text should be.
    diagnostic_virtual_text = "grey",  -- Use grey for less distraction
    ---Floating windows style
    float_style = "dim",  -- Dim floating windows to differentiate from active content
    ---Inlay hints background
    inlay_hints_background = "dimmed",  -- Use a dimmed background for inlay hints
    ---Override specific highlights
    on_highlights = function(highlight_groups, palette)
        highlight_groups.Normal = { bg = palette.bg, fg = palette.fg }
        highlight_groups.Comment = { fg = "#D3D3D3", italic = true }  -- Ensure comments blend well
        highlight_groups.Identifier = { fg = palette.blue }  -- Change identifier color to blue
        highlight_groups.String = { fg = palette.orange }  -- Change string color to orange
        highlight_groups.Function = { fg = palette.pink }  -- Change function color to pink
        highlight_groups.Keyword = { fg = palette.red }  -- Change keywords to red
        highlight_groups.Type = { fg = palette.cyan }  -- Change types to cyan
    end,
    ---Override colours in the palette
    colours_override = function(palette)
        palette.red = "#FF6F61"    -- Red for keywords
        palette.green = "#4CAF50"   -- Adjust green if needed, or leave it
        palette.blue = "#2196F3"    -- Bright blue for identifiers
        palette.orange = "#FF9800"   -- Orange for strings
        palette.pink = "#E91E63"     -- Pink for functions
        palette.cyan = "#00BCD4"     -- Cyan for types
    end,
    })
    vim.cmd.colorscheme "everforest"
  end
}
