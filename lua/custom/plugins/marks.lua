return {
  {
    'LintaoAmons/bookmarks.nvim',
    dependencies = {
      { 'stevearc/dressing.nvim' }, -- optional: to have the same UI shown in the GIF
    },
    keys = {
      { 'mm', '<cmd>BookmarksMark<cr>', { desc = 'Mark current line into active BookmarkList', mode = { 'n', 'v' } } },
      { 'mg', '<cmd>BookmarksGoto<cr>', { desc = 'Go to bookmark at current active BookmarkList', mode = { 'n', 'v' } } },
      { 'ma', '<cmd>BookmarksCommands<cr>', { desc = 'Find and trigger a bookmark command', mode = { 'n', 'v' } } },
      { 'mr', '<cmd>BookmarksGotoRecent<cr>', { desc = 'Go to latest visited/created Bookmark', mode = { 'n', 'v' } } },
    },
    -- 'kshenoy/vim-signature',
    -- 'chentoast/marks.nvim',
  },
}
-- vim: ts=2 sts=2 sw=2 et fdm=marker fdl=0
