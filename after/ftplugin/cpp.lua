if vim.fn.exists ':ClangdSwitchSourceHeader' then
  vim.keymap.set('n', '<Leader>ch', '<cmd>ClangdSwitchSourceHeader<cr>', { desc = 'toggle Header/source file', silent = true, buffer = 0 })
end
