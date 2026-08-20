vim.lsp.config('clangd', {})
vim.lsp.enable('clangd')

require('conform').formatters_by_ft.c = { 'clang_format' }
