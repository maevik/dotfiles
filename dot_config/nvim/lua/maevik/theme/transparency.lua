local M = {}

function M.get_overrides(colors)
  local theme = colors and colors.theme or {}

  return {
    NormalFloat = { bg = 'none' },
    FloatBorder = { bg = 'none' },
    CursorLine  = { bg = theme.ui and theme.ui.bg_p1 or 'none' },

    LineNr       = { bg = 'none' },
    CursorLineNr = { bg = 'none' },
    SignColumn   = { bg = 'none' },
    StatusLine   = { bg = 'none' },
    StatusLineNC = { bg = 'none' },

    SnacksNormal    = { bg = 'none' },
    SnacksBackdrop  = { bg = 'none' },
    SnacksPicker    = { bg = 'none' },
    SnacksPickerRow = { bg = 'none' },
  }
end

return M
