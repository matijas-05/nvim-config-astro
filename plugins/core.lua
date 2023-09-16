return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },
  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },
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
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        astro = {
          icon = "󱎯",
          name = "Astro",
          color = "#ec682c",
        },
      },
      override_by_filename = {
        [".env.test"] = {
          icon = "",
          color = "#faf743",
          cterm_color = "227",
          name = "Env",
        },
        [".env.local"] = {
          icon = "",
          color = "#faf743",
          cterm_color = "227",
          name = "Env",
        },
        [".env.development"] = {
          icon = "",
          color = "#faf743",
          cterm_color = "227",
          name = "Env",
        },
        [".env.example"] = {
          icon = "",
          color = "#faf743",
          cterm_color = "227",
          name = "Env",
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    opts = {
      region_check_events = "CursorHold,InsertLeave",
      delete_check_events = "TextChanged,InsertEnter",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
        },
      },
    },
  },
  -- For some reason playwright integration with neotest is not working with this
  -- We can sort of work around it by doing the following but once it's disabled,
  -- it's disabled until restarting nvim
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      select = {
        get_config = function(opts)
          local neotest_playwright = {
            "Select projects to include in the next test run:",
            "Select preset for neotest-playwright:",
          }
          if vim.tbl_contains(neotest_playwright, opts.prompt) then
            return {
              enabled = false,
            }
          end
        end,
      },
    },
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },
}
