return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "js-everts/cmp-tailwind-colors", opts = {} },
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      local cmp = require "cmp"
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      local utils = require "astronvim.utils"
      if not snip_status_ok then return end
      local border_opts = {
        border = "single",
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }

      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]

        -- Check if the cursor is at the beginning of the line
        if col == 0 then return false end

        -- Check if there is at least one whitespace character before the cursor
        local char_before_cursor = current_line:sub(col - 1, col - 1)
        if char_before_cursor:match "%s" then return true end

        -- Check if there are any non-whitespace characters before the cursor
        local text_before_cursor = current_line:sub(1, col - 1)
        if text_before_cursor:match "%S" then return true end

        return false
      end

      return {
        enabled = function()
          local dap_prompt = utils.is_available "cmp-dap" -- add interoperability with cmp-dap
            and vim.tbl_contains(
              { "dap-repl", "dapui_watches", "dapui_hover" },
              vim.api.nvim_get_option_value("filetype", { buf = 0 })
            )
          if
            vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" and not dap_prompt
          then
            return false
          end
          return vim.g.cmp_enabled
        end,
        preselect = cmp.PreselectMode.None,
        formatting = {
          format = function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group =
                require("nvim-web-devicons").get_icon(entry:get_completion_item().label)

              if vim_item.kind == "Color" then
                vim_item = require("cmp-tailwind-colors").format(entry, vim_item)
                if vim_item.kind == "Color" then return format_kinds(entry, vim_item) end
                return vim_item
              end

              if icon then
                vim_item.kind = icon .. " "
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            return require("lspkind").cmp_format { with_text = true }(entry, vim_item)
          end,
        },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
          cmp_tabnine = 1,
          buffer = 1,
          path = 1,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        },
      }
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_signature").setup {
        hint_enable = false,
      }
    end,
  },
}
