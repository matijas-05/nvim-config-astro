local utils = require "astronvim.utils"

return {
  { import = "astrocommunity.pack.json" },
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
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
    opts = function() return { server = require("astronvim.utils.lsp").config "tsserver" } end,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    opts = {},
  },
}
