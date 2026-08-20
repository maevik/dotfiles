vim.pack.add { 'https://github.com/rebelot/kanagawa.nvim' }

require('kanagawa').setup {
  transparent = true,
  styles = {
    comments = { italic = true },
  },
  overrides = function(colors)
    return require('maevik.theme.transparency').get_overrides(colors)
  end,
}

vim.cmd.colorscheme 'kanagawa-dragon'
