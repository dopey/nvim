-- Suppress vim.lsp.with() deprecation warning from plugins not yet updated for Neovim 0.12
if vim.fn.has("nvim-0.12") == 1 then
  vim.lsp.with = function(handler, opts)
    return function(err, result, ctx, config)
      return handler(err, result, ctx, vim.tbl_extend("force", opts or {}, config or {}))
    end
  end
end

require("config")
