return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    local format = null_ls.builtins.formatting
    local lint = null_ls.builtins.diagnostics

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- lua
      lint.selene,
      format.stylua,
      -- shell
      lint.shellcheck,
      format.shfmt,
    }
    return config
  end,
}
