-- Leader key must be set before lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.clipboard = "unnamedplus"

-- 2-space indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI & editing ergonomics
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.wrap = false
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 250
opt.undofile = true
opt.swapfile = false

-- Code folding (open unfolded by default; use Treesitter when available, fallback to indent)
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "indent"

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if pcall(vim.treesitter.get_parser, args.buf) then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})

-- Clear search highlight with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Fold shortcuts
vim.keymap.set("n", "<leader>z", "za", { desc = "Toggle fold under cursor" })
vim.keymap.set("n", "<leader>zc", "zM", { desc = "Fold all" })
vim.keymap.set("n", "<leader>zo", "zR", { desc = "Unfold all" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins/
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
