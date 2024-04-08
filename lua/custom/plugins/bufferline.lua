return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        show_buffer_close_icon = true,
        show_close_icon = false,
        separator_style = 'slant', -- 'slope' | 'thick' | 'thin'
        hover = {
          enabled = false,
          delay = 200,
          reveal = { 'close' },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et fdm=marker fdl=0
