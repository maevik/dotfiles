vim.pack.add { 'https://github.com/folke/snacks.nvim' }

require('snacks').setup {
  dashboard = {
    enabled = true,
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
    },
  },
  explorer = { enabled = true, replace_netrw = true },
  picker = { enabled = true },
  terminal = { enabled = true },
  notifier = { enabled = true },
  git = { enabled = true },
  words = { enabled = true },
  bigfile = { enabled = true },
  quickfile = { enabled = true },
}

vim.keymap.set('n', '<leader>e', function() require('snacks').explorer() end, { desc = 'Toggle File Explorer' })
vim.keymap.set('n', '<leader>t', function() require('snacks').terminal() end, { desc = 'Toggle Terminal' })
vim.keymap.set('n', '<leader>ff', function() require('snacks').picker.files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', function() require('snacks').picker.grep() end, { desc = 'Grep Text' })
vim.keymap.set('n', '<leader>fb', function() require('snacks').picker.buffers() end, { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>gi', function() require('snacks').picker.gh_issue() end, { desc = 'GitHub Issues' })
vim.keymap.set('n', '<leader>gp', function() require('snacks').picker.gh_pr() end, { desc = 'GitHub Pull Request' })
