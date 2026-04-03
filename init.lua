-- Suppress vim.lsp.with() deprecation warning from plugins not yet updated for Neovim 0.12
if vim.fn.has("nvim-0.12") == 1 then
  local orig_with = vim.lsp.with
  vim.lsp.with = function(handler, opts)
    return function(err, result, ctx, config)
      return handler(err, result, ctx, vim.tbl_extend("force", opts or {}, config or {}))
    end
  end
  -- Restore after startup so other code can detect the deprecation if needed
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function() vim.lsp.with = orig_with end,
  })
end

require("config")
