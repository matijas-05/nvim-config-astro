-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    -- ["<leader>bn"] = { ":tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    ["<leader>pl"] = {
      ":Lazy<cr>",
      desc = "Lazy plugin manager",
    },
    ["<leader>pc"] = {
      ":AstroChangelog<cr>",
      desc = "AstroNvim Changelog",
    },

    ["<tab>"] = ":bnext<cr>",
    ["<s-tab>"] = ":bprev<cr>",

    ["<leader>x"] = { name = " Error list" },
    ["<leader>fr"] = false,

    ["<C-Up>"] = false,
    ["<C-Down>"] = false,
    ["<c-s-up>"] = {
      function()
        if require("astronvim.utils").is_available("smart-splits.nvim") then
          require("smart-splits").resize_up()
        else
          vim.cmd("resize -2")
        end
      end,
      desc = "Resize split up",
    },
    ["<c-s-down>"] = {
      function()
        if require("astronvim.utils").is_available("smart-splits.nvim") then
          require("smart-splits").resize_down()
        else
          vim.cmd("resize +2")
        end
      end,
      desc = "Resize split down",
    },
    ["<c-s-right>"] = {
      function()
        if require("astronvim.utils").is_available("smart-splits.nvim") then
          require("smart-splits").resize_right()
        else
          vim.cmd("vertical resize +2")
        end
      end,
      desc = "Resize split right",
    },
    ["<c-s-left>"] = {
      function()
        if require("astronvim.utils").is_available("smart-splits.nvim") then
          require("smart-splits").resize_left()
        else
          vim.cmd("vertical resize -2")
        end
      end,
      desc = "Resize split left",
    },
    ["<leader>pu"] = {
      function()
        require("package-info").change_version()
      end,
      desc = "Update package",
    },
    ["<leader>pd"] = {
      function()
        require("package-info").delete()
      end,
      desc = "Delete package",
    },
    ["<C-a>"] = { "ggVG" },
    ["H"] = { "_" },
    ["L"] = { "$" },
    ["<leader>tt"] = {
      function()
        require("neotest.consumers.summary").toggle()
      end,
      desc = "Toggle test summary",
    },
    ["<leader>tb"] = {
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local btm = Terminal:new({ cmd = "btm", hidden = true })
        btm:toggle()
      end,
      desc = "ToggleTerm btm",
    },
    ["<C-U>"] = "<C-U>zz",
    ["<C-D>"] = "<C-D>zz",
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  v = {
    ["H"] = { "_" },
    ["L"] = { "$" },
  },
  t = {
    ["<M-q>"] = {
      "<C-\\><C-n>",
      desc = "Exit terminal mode",
    },
  },
}
