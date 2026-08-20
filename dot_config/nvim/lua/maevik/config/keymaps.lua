vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,
  virtual_lines = false,
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight yanked text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'move focus up' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'exit terminal mode' })
