vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

require('conform').setup({
  notify_on_error = false,
  formatters_by_ft = {},
  format_on_save = function(bufnr)
    if require('conform').formatters_by_ft[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    end
  end,
})

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
