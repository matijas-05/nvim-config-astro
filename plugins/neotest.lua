return {
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      {
        "thenbe/neotest-playwright",
        keys = {
          {
            "<leader>ta",
            function() require("neotest").playwright.attachment() end,
            desc = "Launch test attachment",
          },
        },
      },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-playwright").adapter {
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
              preset = "headed",
            },
          },
        },
        consumers = {
          playwright = require("neotest-playwright.consumers").consumers,
        },
      }
    end,
    keys = {
      {
        "<leader>tr",
        function() require("neotest").run.run() end,
        desc = "Run test",
      },
      {
        "<leader>tR",
        function() require("neotest").run.run(vim.fn.expand "%") end,
        desc = "Run tests in file",
      },
      {
        "<leader>ts",
        function() require("neotest").run.stop() end,
        desc = "Stop test",
      },
      {
        "<leader>tk",
        function() require("neotest").output.open { enter = true } end,
        desc = "Open test output",
      },
      {
        "<leader>tt",
        function() require("neotest.consumers.summary").toggle() end,
        desc = "Toggle test tree",
      },
      {
        "<leader>to",
        function() require("neotest.consumers.output_panel").toggle() end,
        desc = "Toggle test output panel",
      },
    },
  },
}
