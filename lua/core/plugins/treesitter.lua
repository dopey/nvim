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

    -- Install parsers that aren't already installed
    local ensure_installed = {
      "bash", "c", "css", "dockerfile", "gitignore", "go", "gomod", "gosum",
      "gotmpl", "gowork", "hcl", "html", "json", "javascript", "lua",
      "markdown", "markdown_inline", "terraform", "typescript", "tsx",
      "yaml", "vim", "rust",
    }
    local installed = require("nvim-treesitter.config").get_installed("parsers")
    local to_install = {}
    for _, lang in ipairs(ensure_installed) do
      if not vim.tbl_contains(installed, lang) then
        table.insert(to_install, lang)
      end
    end
    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end
  end,
}
