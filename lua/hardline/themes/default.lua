local colors = {
  black = {gui = '#282C34', cterm = '235', cterm16 = '0'},
  blue = {gui = '#61AFEF', cterm = '39', cterm16 = '4'},
  cyan = { gui = '#56B6C2', cterm = '38', cterm16 = '6'},
  green = {gui = '#98C379', cterm = '114', cterm16 = '2'},
  grey_comment = {gui = '#5C6370', cterm = '59', cterm16 = '15'},
  grey_cursor = {gui = '#2C323C', cterm = '236', cterm16 = '8'},
  grey_menu = {gui = '#3E4452', cterm = '237', cterm16 = '8'},
  purple = {gui = '#C678DD', cterm = '170', cterm16 = '5'},
  red = {gui = '#E06C75', cterm = '204', cterm16 = '1'},
  white = {gui = '#ABB2BF', cterm = '145', cterm16 = '7'},
  yellow = {gui = '#E5C07B', cterm = '180', cterm16 = '3'},
}

local inactive = {
  guifg = colors.grey_comment.gui,
  guibg = "NONE",
  ctermfg = colors.grey_comment.cterm,
  ctermbg = "NONE",
}

return {
  mode = {
    inactive = inactive,
    normal = {
      guifg = colors.green.gui,
      guibg = "NONE",
      ctermfg = colors.green.cterm,
      ctermbg = "NONE",
    },
    insert = {
      guifg = colors.blue.gui,
      guibg = "NONE",
      ctermfg = colors.blue.cterm,
      ctermbg = "NONE",
    },
    replace = {
      guifg = colors.cyan.gui,
      guibg = "NONE",
      ctermfg = colors.cyan.cterm,
      ctermbg = "NONE",
    },
    visual = {
      guifg = colors.purple.gui,
      guibg = "NONE",
      ctermfg = colors.purple.cterm,
      ctermbg = "NONE",
    },
    command = {
      guifg = colors.red.gui,
      guibg = "NONE",
      ctermfg = colors.red.cterm,
      ctermbg = "NONE",
    },
  },
  low = {
    active = {
      guifg = colors.white.gui,
      guibg = "NONE",
      ctermfg = colors.white.cterm,
      ctermbg = "NONE",
    },
    inactive = inactive,
  },
  med = {
    active = {
      guifg = colors.yellow.gui,
      guibg = "NONE",
      ctermfg = colors.yellow.cterm,
      ctermbg = "NONE",
    },
    inactive = inactive,
  },
  high = {
    active = {
      guifg = colors.white.gui,
      guibg = "NONE",
      ctermfg = colors.white.cterm,
      ctermbg = "NONE",
    },
    inactive = inactive,
  },
  error = {
    active = {
      guifg = colors.red.gui,
      guibg = "NONE",
      ctermfg = colors.red.cterm,
      ctermbg = "NONE",
    },
    inactive = inactive,
  },
  warning = {
    active = {
      guifg = colors.yellow.gui,
      guibg = "NONE",
      ctermfg = colors.yellow.cterm,
      ctermbg = "NONE",
    },
    inactive = inactive,
  },
}
