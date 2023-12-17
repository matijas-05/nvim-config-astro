-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- Don't fix eslint errors on save because it's laggy on larger files
      vim.api.nvim_del_augroup_by_name "eslint_fix_creator"

      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed =
        require("astronvim.utils").list_insert_unique(opts.ensure_installed, {})
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      local function check_json_key_exists(filename, key)
        -- Open the file in read mode
        local file = io.open(filename, "r")
        if not file then
          return false -- File doesn't exist or cannot be opened
        end

        -- Read the contents of the file
        local content = file:read "*all"
        file:close()

        -- Parse the JSON content
        local json_parsed, json = pcall(vim.fn.json_decode, content)
        if not json_parsed or type(json) ~= "table" then
          return false -- Invalid JSON format
        end

        -- Check if the key exists in the JSON object
        return json[key] ~= nil
      end

      -- Define a function to check if a file exists
      local file_exists = function(file_name)
        local current_directory = vim.fn.getcwd()
        local full_path = current_directory .. "/" .. file_name
        return vim.fn.filereadable(full_path) == 1
      end

      local has_prettier = function()
        -- print(vim.inspect(require("null-ls.config").get().root_dir(vim.api.nvim_buf_get_name(0))))
        return file_exists ".prettierrc"
          or file_exists ".prettierrc.json"
          or file_exists ".prettierrc.yml"
          or file_exists ".prettierrc.yaml"
          or file_exists ".prettierrc.json5"
          or file_exists ".prettierrc.js"
          or file_exists ".prettierrc.cjs"
          or file_exists "prettier.config.js"
          or file_exists "prettier.config.cjs"
          or file_exists ".prettierrc.toml"
          or check_json_key_exists(vim.fn.getcwd() .. "/package.json", "prettier")
      end

      local null_ls = require "null-ls"
      opts.handlers.prettierd = function()
        null_ls.register(null_ls.builtins.formatting.prettierd.with { condition = has_prettier })
      end

      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed =
        require("astronvim.utils").list_insert_unique(opts.ensure_installed, {})
    end,
  },
}
