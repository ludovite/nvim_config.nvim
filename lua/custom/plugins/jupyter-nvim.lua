return {
  {
    'jupyter-vim/jupyter-vim',
    -- ft = { 'python' },
    init = function()
      vim.g.jupyter_mapkeys = 0
      vim.g.jupyter_cell_separators = {
        '# %%',
        '#%%',
        '##',
        '# <codecell>',
      }
    end,
    config = function()
      local wk_status_ok, wk = pcall(require, 'which-key')
      local description = ''
      local bufnr = vim.api.nvim_get_current_buf()
      local map = function(mode, lhs, rhs, desc, opts) --{{{1
        local options = {
          noremap = true,
          silent = true,
          buffer = bufnr or 0,
          desc = desc,
        }
        if opts then
          options = vim.tbl_extend('force', options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
      end
      local nmap = function(lhs, rhs, desc, opts)
        map('n', lhs, rhs, desc, opts)
      end
      local imap = function(lhs, rhs, desc, opts)
        map('i', lhs, rhs, desc, opts)
      end
      local vmap = function(lhs, rhs, desc, opts)
        map('v', lhs, rhs, desc, opts)
      end
      --}}}1

      description = 'Launch a QtConsole' -- \Q {{{1
      nmap('<localleader>Q', function()
        vim.fn.jobstart 'jupyter qtconsole'
        vim.cmd [[sleep 3]]
        vim.cmd [[JupyterConnect]]
      end, description)
      if wk_status_ok then
        wk.register({
          ['Q'] = { description, buffer = bufnr },
        }, { prefix = '<localleader>' })
      end
      --}}}1

      description = 'styling Matplotlib (Qt)' -- \M {{{1
      nmap('<LocalLeader>M', function()
        vim.cmd [[JupyterSendCode '%matplotlib qt']]
      end, description)
      -- if wk_status_ok then
      --   wk.register({
      --     ['M'] = { description, buffer = bufnr },
      --   }, { prefix = '<localleader>' })
      -- end
      --}}}1

      description = 'styling Matplotlib (inline)' -- \m {{{1
      nmap('<LocalLeader>m', function()
        vim.cmd [[JupyterSendCode '%matplotlib inline']]
      end, description)
      -- if wk_status_ok then
      --   wk.register({
      --     ['m'] = { description, buffer = bufnr },
      --   }, { prefix = '<localleader>' })
      -- end
      --}}}1

      description = 'Send visual selection' -- \v {{{1
      vmap('<LocalLeader><LocalLeader>', '<Plug>JupyterRunVisual|<Esc>j', description, { noremap = false })
      -- if wk_status_ok then
      --   wk.register({
      --     ['ù'] = { description, buffer = bufnr },
      --   }, { prefix = '<localleader>' })
      -- end
      --}}}1

      description = 'Run this file' -- \f {{{1
      nmap('<LocalLeader>f', function()
        vim.cmd [[JupyterRunFile]]
      end, description)
      -- if wk_status_ok then
      --   wk.register({
      --     ['f'] = { description, buffer = bufnr },
      --   }, { prefix = '<localleader>' })
      -- end
      --}}}1

      description = 'Send cell' -- \\ {{{1
      nmap('<LocalLeader><LocalLeader>', function()
        vim.cmd [[JupyterSendCell]]
      end, description)
      -- if wk_status_ok then
      --   wk.register({
      --     ['<LocalLeader>'] = { description, buffer = bufnr },
      --   }, { prefix = '<localleader>' })
      -- end
      --}}}1

      description = 'Send this line' -- \<Space> {{{1
      nmap('<LocalLeader><Space>', function()
        if vim.fn.getline '.' ~= '' then
          vim.cmd [[JupyterSendRange]]
        end
        vim.cmd 'norm! j^'
      end, description)
      -- if wk_status_ok then
      --   wk.register({
      --     ['<CR>'] = { description, buffer = bufnr },
      --   }, { prefix = '<localleader>' })
      -- end
      --}}}1

      description = 'Clear IPython screen'
      nmap('<LocalLeader>l', function()
        vim.cmd [[JupyterSendCode("%clear")]]
      end, description)

      description = 'Goto next cell'
      nmap('<C-j>', function()
        if 0 == #vim.g.jupyter_cell_separators then
          return nil -- if no cell delimitor, then no action
        end
        local mycmd = '/' -- begin a search command
        for i, v in pairs(vim.g.jupyter_cell_separators) do
          mycmd = mycmd .. '\\(^' .. v .. '\\)'
          if i < #vim.g.jupyter_cell_separators then
            mycmd = mycmd .. '\\|' -- or another delimitor
          end
        end
        mycmd = mycmd .. '/1' -- go to the next line after the delimitor
        vim.cmd(mycmd) -- let's search
        vim.cmd [[:nohlsearch]] -- disable delimitors higlights
      end, description)

      description = 'Goto previous cell'
      nmap('<C-k>', function()
        if 0 == #vim.g.jupyter_cell_separators then
          return nil -- if no cell delimitor, then no action
        end
        vim.cmd '-1'
        local mycmd = '?' -- begin a reverse search command
        for i, v in pairs(vim.g.jupyter_cell_separators) do
          mycmd = mycmd .. '\\(^' .. v .. '\\)'
          if i < #vim.g.jupyter_cell_separators then
            mycmd = mycmd .. '\\|' -- or another delimitor
          end
        end
        mycmd = mycmd .. '?1' -- go to the next line after the delimitor
        vim.cmd(mycmd) -- let's search
        vim.cmd [[:nohlsearch]] -- disable delimitors higlights
      end, description)

      description = 'add a cell separator'
      imap('<C-Enter>', function()
        local actual_line = vim.fn.getline '.'
        -- check if the actual line already contains a cell delimitor
        for _, v in pairs(vim.g.jupyter_cell_separators) do
          if actual_line:sub(1, #v) == v then
            return nil
          end
        end
        -- check if actual line is blanck
        if actual_line ~= '' then
          vim.cmd [[normal! o]]
        end
        vim.cmd [[normal! o]]
        vim.api.nvim_set_current_line(vim.g.jupyter_cell_separators[1])
        vim.cmd [[normal! o]]
        vim.cmd [[startinsert]]
      end, description)
    end,
  },
}
