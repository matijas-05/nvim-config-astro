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
    keys = { { "<leader>m", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
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
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      {
        "S",
        mode = { "n", "o" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc = "Toggle Flash Search",
      },
    },
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
    "mbbill/undotree",
    keys = {
      { "<leader>fu", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_SplitWidth = 35
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
      "<c-up>",
      "<c-down>",
      "<s-left>",
      "<s-right>",
    },
    config = function() vim.g.VM_Mono_hl = "Visual" end,
  },
  {
    "nguyenvukhang/nvim-toggler",
    keys = {
      { "<leader>i", desc = "Invert word" },
    },
    config = function() require("nvim-toggler").setup() end,
  },
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.splitjoin",
    version = "*",
    keys = {
      { "<leader>s", desc = "Split/join line" },
    },
    config = function()
      require("mini.splitjoin").setup {
        mappings = {
          toggle = "<leader>s",
        },
      }
    end,
  },
}
