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

    require("nvim-treesitter.install").ensure_installed(
      "bash", "c", "css", "dockerfile", "gitignore", "go", "gomod", "gosum",
      "gotmpl", "gowork", "hcl", "html", "json", "javascript", "lua",
      "markdown", "markdown_inline", "terraform", "typescript", "tsx",
      "yaml", "vim", "rust"
    )
  end,
}
