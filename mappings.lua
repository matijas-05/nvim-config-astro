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
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
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
    ["<leader>c"] = false,
    ["<leader>C"] = false,
    ["<leader>x"] = {
      function() require("astronvim.utils.buffer").close() end,
      desc = "Close buffer",
    },
    ["<leader>X"] = {
      function() require("astronvim.utils.buffer").close(nil, true) end,
      desc = "Force close buffer",
    },

    ["<A-j>"] = ":m .+1<CR>==",
    ["<A-k>"] = ":m .-2<CR>==",
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  v = {
    ["<A-j>"] = "dp`[V`]",
    ["<A-k>"] = "dkP`[V`]",
  },
}
