return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory (Oil)" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
  },
}
