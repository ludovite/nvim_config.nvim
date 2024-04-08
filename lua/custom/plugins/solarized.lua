return {
  {
    'maxmx03/solarized.nvim',
    priority = 999, -- Make sure to load this before all the other start plugins.
    lazy = false,
    opts = {
      styles = {
        comments = { italic = true, bold = false },
        functions = { italic = false },
        variables = { italic = false },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et fdm=marker fdl=0
