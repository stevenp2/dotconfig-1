local vim_apply = require("utils").vim_apply
local map = require("utils").map

---------------
-- Variables --
---------------
-- Global variables - vim.g
-- Buffer variables - vim.b
-- Window variables - vim.w
-- Tabpage variables - vim.t
-- Predefined Vim variables - vim.v
-- Environment variables - vim.env
-- Options (:set) - vim.o
-- Global options (:setglobal) - vim.go
-- Buffer options (:setlocal for buffer-local options) - vim.bo
-- Window options (:setlocal for window-local options) - vim.wo

-- TODO: vim.o instead of vim.opt?
-- TODO: t_Co = 16?
-- https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim#L94-L99
vim_apply(vim.opt, {
  -- General options
  mouse = "a",
  spell = true,
  scrolloff = 1,
  sidescrolloff = 2,
  cursorline = true,
  splitbelow = true,
  splitright = true,
  hidden = true,
  number = true,
  ruler = true,
  colorcolumn = "80",
  termguicolors = true,
  showmode = false,
  swapfile = false,

  list = true,
  listchars = [[tab:→→,trail:·,extends:▶,precedes:◀,nbsp:␣]],

  wildmenu = true,
  wildmode = "full",
  wildoptions = "tagfile",
  autoread = true,

  showmatch = true,
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,

  -- Coding options
  -- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990
  expandtab = true,
  shiftwidth = 2,
  softtabstop = 2,
  tabstop = 2,
  autoindent = true,
  smartindent = true,
})

----------
-- Misc --
----------

-- Hybrid relative numbers for normal mode, absolute for insert mode
vim.cmd([[
fun! SetRelativeNumber()
  " dashboard\|nvimtree
  if &ft =~ 'dashboard'
    return
  endif
  set relativenumber
endfun

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * call SetRelativeNumber()
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
]])

-- netrw settings (for directory tree view)
vim_apply(vim.g, {
  -- loaded_netrw = 1, -- disables netrw
  netrw_liststyle = 3, -- tree style
  netrw_preview = 1, -- vertical splits for previews
  netrw_altv = true, -- opens vsplit to right
})

-- Auto-resize
vim.cmd("autocmd VimResized * wincmd =")

-- Highlight yank
vim.cmd([[
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
]])

-- Paste last yanked
map({ "n", "\\p", '"0p' })
map({ "v", "\\p", '"0p' })

-- Update (instead of write)
map({ "n", "<space>w", "<cmd>up<CR>" })

-- Disable automatic comment insertion
-- TODO: shift CR continue comment, regular CR won't
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])
vim.cmd([[autocmd BufEnter * setlocal formatoptions-=cro]])

-- Center search result jumps
map({ "n", "n", "nzz" })

-- Apply keybindings
require("plugins.binds").general()
