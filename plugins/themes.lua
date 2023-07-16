return {
  {
    "AstroNvim/astrotheme",
    opts = {
      style = {
        italic_comments = false,
      },
      terminal_colors = false,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      dim_inactive = {
        enabled = true,
      },
      styles = {
        -- test
        comments = {},
      },
    },
  },
}
