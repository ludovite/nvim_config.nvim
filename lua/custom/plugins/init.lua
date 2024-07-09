-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  require 'custom/plugins/repeat',
  require 'custom/plugins/rainbow-delimiter',
  require 'custom/plugins/nord', -- main colorscheme
  require 'custom/plugins/solarized', -- second colorscheme
  require 'custom/plugins/bufferline', -- display buffers name in tab display
  require 'custom/plugins/nvim-colorizer', -- colorize color names or #hexa
  require 'custom/plugins/marks', -- Manage & display marks
  require 'custom/plugins/surround', -- surround objects
  require 'custom/plugins/nvim-ufo', -- modern look folding
  -- require 'custom/plugins/magma-nvim', -- jupyter-like
  -- require 'custom/plugins/barbecue', -- make sure barbecue loads after your colorscheme
}
-- vim: ts=2 sts=2 sw=2 et fdm=marker fdl=0
