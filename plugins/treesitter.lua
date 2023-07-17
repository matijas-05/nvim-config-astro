return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      "lua",
      "bash",
      "markdown",
      "markdown_inline",
      "comment",
      "gitignore",
      "json",
      "jsonc",
      "yaml",
      "html",
      "css",
      "javascript",
      "jsdoc",
      "typescript",
      "tsx",
    })
    opts.auto_install = true
  end,
}
