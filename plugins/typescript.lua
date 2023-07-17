local utils = require "astronvim.utils"

return {
  { import = "astrocommunity.pack.json" },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = { force = true },
    keys = {
      {
        "<leader>pi",
        "<cmd>lua require('package-info').show()<cr>",
        desc = "Show package.json info",
      },
      {
        "<leader>pd",
        "<cmd>lua require('package-info').delete()<cr>",
        desc = "Delete an npm package",
      },
      {
        "<leader>pu",
        "<cmd>lua require('package-info').change_version()<cr>",
        desc = "Change version of an npm package",
      },
    },
    event = "BufRead package.json",
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    init = function()
      astronvim.lsp.skip_setup = utils.list_insert_unique(astronvim.lsp.skip_setup, "tsserver")
    end,
    ft = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
    },
    opts = function()
      local server1 = require("astronvim.utils.lsp").config "tsserver"
      local server2 = {
        settings = {
          -- specify some or all of the following settings if you want to adjust the default behavior
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      }

      return {
        server = vim.tbl_deep_extend("force", server1, server2),
      }
    end,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    opts = {},
  },
}
