return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      contrast = "soft",
      transparent_mode = true,
    },
    config = function(_, opts)
      vim.o.background = "dark"
      require("gruvbox").setup(opts)
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
