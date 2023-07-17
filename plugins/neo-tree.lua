local function on_file_remove(args)
  local ts_clients = vim.lsp.get_active_clients { name = "tsserver" }
  for _, ts_client in ipairs(ts_clients) do
    ts_client.request("workspace/executeCommand", {
      command = "_typescript.applyRenameFile",
      arguments = {
        {
          sourceUri = vim.uri_from_fname(args.source),
          targetUri = vim.uri_from_fname(args.destination),
        },
      },
    })
  end
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      event_handlers = (function()
        local events = require "neo-tree.events"

        return {
          {
            event = events.FILE_MOVED,
            handler = on_file_remove,
          },
          {
            event = events.FILE_RENAMED,
            handler = on_file_remove,
          },
        }
      end)(),
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
        width = function()
          local os = vim.loop.os_uname().sysname
          if os == "Darwin" then
            return 30
          else
            return 40
          end
        end,
      },
      source_selector = {
        winbar = false,
      },
    },
  },
}
