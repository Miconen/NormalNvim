-- Themes

return {
  -- tokyonight [theme]
  -- https://github.com/folke/tokyonight.nvim
  {
    "Zeioth/tokyonight.nvim",
    event = "User LoadColorSchemes",
    opts = {
      dim_inactive = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
  },

  -- cyberdream [theme]
  -- scottmckendry/cyberdream.nvim
  {
    "scottmckendry/cyberdream.nvim",
    event = "User LoadColorSchemes",
    opts = {
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
      terminal_colors = true,
    },
  },

  --  astrotheme [theme]
  --  https://github.com/AstroNvim/astrotheme
  {
    "AstroNvim/astrotheme",
    event = "User LoadColorSchemes",
    opts = {
      palette = "astrodark",
      plugins = { ["dashboard-nvim"] = true },
    },
  },

  {
    "tiagovla/tokyodark.nvim",
    event = "User LoadColorSchemes",
    opts = {
      transparent_background = false,
      gamma = 1.00,
    },
  }
}
