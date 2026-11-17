return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    keys = {
      { "<leader>mp", "<cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "Toggle Markdown render" },
    },
    opts = {
      html = { enabled = false },
      latex = { enabled = false },
    },
    config = function(_, opts)
      -- Start Neovim's built-in markdown treesitter parser without needing nvim-treesitter plugin
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
      pcall(vim.treesitter.start, 0)
      require("render-markdown").setup(opts)
    end,
  },
}
