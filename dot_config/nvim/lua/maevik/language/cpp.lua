vim.lsp.config('clangd', {})
vim.lsp.enable('clangd')

require('conform').formatters_by_ft.cpp = { 'clang_format' }
