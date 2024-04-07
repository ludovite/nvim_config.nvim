--━━❰ Setting options ❱━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{{{0
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!,
--  For more options, you can see `:help option-list`

vim.loader.enable()
local options = {
  backup = false, -- Creates a backup file
  swapfile = false, -- Creates a swapfile
  clipboard = 'unnamedplus', -- Remove this option if you want your OS clipboard to remain independent. See `:help 'clipboard'`
  cmdheight = 2, -- More space in the neovim command line for displaying messages
  conceallevel = 0, -- So that `` is visible in markdown files
  fileencoding = 'utf-8', -- The encoding written to a file
  hlsearch = true, -- Highlight all matches on previous search pattern
  ignorecase = true, -- Ignore case in command mode
  smartcase = true,
  smartindent = true, -- Make indenting smarter again
  incsearch = true,
  mousemoveevent = true,
  mouse = 'a', -- Allow the mouse to be used in neovim
  pumheight = 10, -- Pop up menu height
  showmode = false, -- Don't show the mode, (already in the status line)
  showtabline = 2, -- Always show tabs
  splitbelow = true, -- Force all horizontal splits to go below current window
  splitright = true, -- Force all vertical splits to go to the right of current window
  termguicolors = true, -- Set term gui colors (most terminals support this)
  timeoutlen = 800, -- Time to wait for a mapped sequence to complete (in ms).Displays which-key popup sooner
  number = true,
  -- relativenumber = true,
  numberwidth = 3, -- Set number column width to 3 {default 4}
  signcolumn = 'yes', -- Always show the sign column, otherwise it would shift the text each time
  breakindent = true, -- Enable break indent
  undofile = true, -- Save undo history
  updatetime = 250, -- Faster completion (4000ms default)
  -- Sets how neovim will display certain whitespace characters in the editor.
  list = true, --  See `:help 'list'`
  wrap = true, -- Display lines as one long line if false
  linebreak = true, -- word wrapping
  showbreak = '↪ ',
  listchars = { tab = '» ', trail = '·', nbsp = '␣' }, -- see `:help 'listchars'`
  inccommand = 'split', -- Preview substitutions live, as you type!
  scrolloff = 999, -- Minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,
  writebackup = false, -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- Convert tabs to spaces
  shiftwidth = 3, -- The number of spaces inserted for each indentation
  tabstop = 3, -- Insert 3 spaces for a tab
  softtabstop = 3, -- Insert 3 spaces for a tab
  cursorline = true, -- Highlight the current line
  guifont = 'monospace:h17', -- the font used in graphical neovim applications
  titlestring = [[%F %h%m%r%w NVIM]],
  title = true, -- Print active filename in window titlebar
  virtualedit = 'block',
  -- inccommand = 'split', -- Open a windows to show every subsitution in the entire buffer
} --}}}0

--━━❰ Activate these options ❱━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{{{1
for k, v in pairs(options) do
  vim.opt[k] = v
end
--}}}1

-- vim: ts=2 sts=2 sw=2 et fdm=marker fdl=0
