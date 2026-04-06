return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter").setup()
    require("nvim-ts-autotag").setup()

    -- Fix nvim-treesitter's set-lang-from-info-string! directive for Neovim 0.12.
    -- In 0.12, iter_matches returns match[id] as TSNode[] instead of TSNode,
    -- causing get_node_text() to fail with "attempt to call method 'range' (a nil value)".
    if vim.fn.has("nvim-0.12") == 1 then
      local aliases = { ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript" }
      vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local capture_id = pred[2]
        local nodes = match[capture_id]
        if not nodes then return end
        local node = type(nodes) == "table" and nodes[1] or nodes
        if not node then return end
        local text = vim.treesitter.get_node_text(node, bufnr):lower()
        metadata["injection.language"] = vim.filetype.match({ filename = "a." .. text }) or aliases[text] or text
      end, { force = true, all = false })
    end

    require("nvim-treesitter.install").ensure_installed(
      "bash", "c", "css", "dockerfile", "gitignore", "go", "gomod", "gosum",
      "gotmpl", "gowork", "hcl", "html", "json", "javascript", "lua",
      "markdown", "markdown_inline", "terraform", "typescript", "tsx",
      "yaml", "vim", "rust"
    )
  end,
}
