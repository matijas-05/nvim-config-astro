return {
  -- You can also add new plugins here as well:
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup() end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = "markdown",
    keys = { { "gm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
    config = function()
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_open_to_the_world = false
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = "8888"
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_page_title = "${name}"
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle menu" },
      {
        "<leader>xw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Toggle workspace diagnostics menu",
      },
      {
        "<leader>xd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Toggle document diagnostics menu",
      },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Toggle quickfix menu" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Toggle location list menu" },
    },
    opts = function()
      local os = vim.loop.os_uname().sysname

      if os == "Darwin" then
        return {
          height = 20,
          width = 87,
          position = "bottom",
        }
      else
        return {
          height = 25,
          width = 87,
          position = "right",
        }
      end
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "TodoQuickFix",
      "TodoLocList",
      "TodoTrouble",
      "TodoTelescope",
    },
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Toggle todo-comments list" },
    },
    config = function() require("todo-comments").setup() end,
  },
  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat",
    },
    keys = {
      "s",
      "S",
      "gs",
    },
    config = function() require("leap").add_default_mappings() end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function() vim.g.copilot_assume_mapped = true end,
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set(
          "n",
          key,
          function() require("illuminate")["goto_" .. dir .. "_reference"](false) end,
          { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer }
        )
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      {
        "<leader>fr",
        function() require("spectre").open() end,
        desc = "Replace in files (Spectre)",
      },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      local colors = require "astrotheme.colors"
      require("scrollbar").setup {
        handle = {
          color = colors.bg_1,
        },
        marks = {
          Search = { color = colors.orange_1 },
          Error = { color = colors.red_1 },
          Warn = { color = colors.yellow_1 },
          Info = { color = colors.blue_1 },
          Hint = { color = colors.green_1 },
          Misc = { color = colors.purple_1 },
        },
      }
    end,
  },
  {
    "echasnovski/mini.move",
    version = "*",
    keys = {
      { "<M-h>", mode = "n" },
      { "<M-j>", mode = "n" },
      { "<M-k>", mode = "n" },
      { "<M-l>", mode = "n" },
      { "<M-h>", mode = "v" },
      { "<M-j>", mode = "v" },
      { "<M-k>", mode = "v" },
      { "<M-l>", mode = "v" },
    },
    config = function() require("mini.move").setup() end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    keys = {
      { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo history" },
    },
    config = function()
      require("telescope").setup {}
      require("telescope").load_extension "undo"
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    cmd = { "NoNeckPain" },
    keys = {
      { "<leader>bn", "<cmd>NoNeckPain<cr>", desc = "Toggle NoNeckPain" },
    },
    opts = {
      width = 150,
    },
  },
  {
    "mg979/vim-visual-multi",
    keys = {
      "<c-n>",
    },
  },
  {
    "nguyenvukhang/nvim-toggler",
    keys = {
      { "<leader>i", desc = "Invert word" },
    },
    config = function() require("nvim-toggler").setup() end,
  },
}
