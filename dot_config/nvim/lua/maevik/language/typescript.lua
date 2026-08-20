vim.lsp.config('ts_ls', {})
vim.lsp.enable('ts_ls')

require('conform').formatters_by_ft.typescript = { 'prettierd', 'prettier', stop_after_first = true }
