return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter', --{{{0
    build = ':TSUpdate',
    opts = {
      ensure_installed = { -- {{{1
        'bash',
        'c',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
      }, -- 1}}}
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { -- {{{1
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      }, -- 1}}}
      indent = { -- {{{1
        enable = true,
        disable = {
          'ruby',
          'python',
        },
      }, -- 1}}}
      incremental_selection = { -- {{{1
        enable = true,
        keymaps = {
          init_selection = '<A-w>',
          node_incremental = '<A-w>',
          scope_incremental = '<A-e>',
          node_decremental = '<A-C-w>',
        },
      }, -- }}}1
      textobjects = { -- {{{1
        -- Need to install nvim-treesitter/nvim-treesitter-textobjects
        select = { -- {{{2
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
            -- You can also use captures from other query groups like `locals.scm`
            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        }, -- 2}}}
        swap = { -- {{{2
          -- swap the node under the cursor with the next or previous one,
          -- like function parameters or arguments.
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        }, -- 2}}}
        move = { -- {{{2
          -- jump to the next or previous text object.
          -- This is similar to ]m, [m, ]M, [M Neovim's mappings
          -- to jump to the next or previous function.
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = { query = '@class.outer', desc = 'Next class start' },
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass
            -- a list in a "query" key to group multiple queires.
            [']o'] = '@loop.*',
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            [']d'] = '@conditional.outer',
          },
          goto_previous = {
            ['[d'] = '@conditional.outer',
          },

          -- You can make the movements repeatable like ; and ,.
          -- See →REPEATABLE MOVEMENTS← below.
        }, -- 2}}}
        lsp_interop = { -- {{{2
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            ['<leader>df'] = '@function.outer',
            ['<leader>dF'] = '@class.outer',
          }, -- 2}}}
        }, -- 1}}}
        autotag = { -- {{{1
          -- Need nvim-ts-autotag
          enable = true,
        }, -- 1}}}
      },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context

      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      -- →REPEATABLE MOVEMENTS← --{{{1
      local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

      -- vim way: ; goes to the direction you were moving.
      -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
      -- }}}1
    end,
  }, --0}}}
  { -- Syntax aware text-objects, select, move, swap, and peek support
    'nvim-treesitter/nvim-treesitter-textobjects', --{{{1
  }, --1}}}
  { -- Use treesitter to autoclose and autorename html tag
    'windwp/nvim-ts-autotag', -- {{{1
  }, -- 1}}}
  { -- Setting the commentstring when there are embedded languages. {{{1
    'JoosepAlviste/nvim-ts-context-commentstring',
  }, -- 1}}}
  { -- Magical code layout {{{1
    'ckolkey/ts-node-action',
    dependencies = { 'nvim-treesitter' },
    opts = {},
    keys = {
      {
        '<leader>cn',
        function()
          require('ts-node-action').node_action()
        end,
        { noremap = true, desc = 'Trigger node action' },
      },
    },
  }, -- 1}}}
}
-- vim: ts=2 sts=2 sw=2 et fdm=marker fdl=0
