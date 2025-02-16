return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = { -- extend the plugin options
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
      window = {
        auto_expand_width = true,
        mappings = {
          -- disable fuzzy finder
          ["/"] = "noop"
        },
      },
    },
  },
}
