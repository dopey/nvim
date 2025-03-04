return {
  -- Disable alpha-nvim
  { 'goolord/alpha-nvim', enabled = false },
  {
    'RRethy/vim-illuminate',
    opts = function(_, opts)
      local illuminate = require("illuminate")
      local map = vim.keymap.set

      map("n", "<C-n>", function() illuminate.goto_next_reference(true) end, { desc = "Go to next reference" })
      map("n", "<C-p>", function() illuminate.goto_prev_reference(true) end, { desc = "Go to previous reference" })

      -- disable default keymaps
      opts.disable_keymaps = true
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(plugin, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- use `extend_tbl` to easily merge into the `opts` table
      -- NOTE: this function does not merge in place and needs to be
      --       returned at the end of the function
      return require("astrocore").extend_tbl(opts, {
        mapping = {
          ['<CR>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                  if luasnip.expandable() then
                      luasnip.expand()
                  else
                      cmp.confirm({
                          select = true,
                      })
                  end
              else
                  fallback()
              end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-Y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, _opts)
          _opts = _opts or {}
          _opts.buffer = bufnr
          vim.keymap.set(mode, l, r, _opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk" })
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage buffer" })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset buffer" })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview hunk" })
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = "Blame line" })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = "Show diff" })
        map('n', '<leader>hD',
          function()
            vim.cmd(':wincmd p')
            vim.cmd(':q')
          end,
          { desc = "Close diff" })
        map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "Toggle deleted" })

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
      end,
    },
  },
}
