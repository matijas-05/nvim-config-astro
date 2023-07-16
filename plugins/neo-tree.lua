return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "A",
            modified = "M",
            deleted = "D",
            renamed = "R",
            -- Status type
            untracked = "",
            unstaged = "",
            staged = "",
            conflict = "",

            -- -- Change type
            -- added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            -- modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            -- deleted = "✖", -- this can only be used in the git_status source
            -- renamed = "󰁕", -- this can only be used in the git_status source
            -- -- Status type
            -- untracked = "",
            -- ignored = "",
            -- unstaged = "󰄱",
            -- staged = "",
            -- conflict = "",
          },
        },
      },
      window = {
        width = 40,
      },
      source_selector = {
        winbar = false,
      },
    },
  },
}
