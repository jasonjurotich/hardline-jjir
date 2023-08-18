-- Custom colorscheme

local M = {}

M.set = function(color_table)
  local inactive = {
    guifg = color_table.inactive_comment.gui,
    guibg = "NONE",
    ctermfg = color_table.inactive_comment.cterm,
    ctermbg = "NONE",
  }

  return {
    mode = {
      inactive = inactive,
      normal = {
        guifg = color_table.text.gui,
        guibg = color_table.normal.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.normal.cterm,
      },
      insert = {
        guifg = color_table.text.gui,
        guibg = color_table.insert.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.insert.cterm,
      },
      replace = {
        guifg = color_table.text.gui,
        guibg = color_table.replace.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.replace.cterm,
      },
      visual = {
        guifg = color_table.text.gui,
        guibg = color_table.visual.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.visual.cterm,
      },
      command = {
        guifg = color_table.text.gui,
        guibg = color_table.command.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.command.cterm,
      },
    },
    low = {
      active = {
        guifg = color_table.alt_text.gui,
        guibg = "NONE",
        ctermfg = color_table.alt_text.cterm,
        ctermbg = "NONE",
      },
      inactive = inactive,
    },
    med = {
      active = {
        guifg = color_table.alt_text.gui,
        guibg = "NONE",
        ctermfg = color_table.alt_text.cterm,
        ctermbg = "NONE",
      },
      inactive = inactive,
    },
    high = {
      active = {
        guifg = color_table.alt_text.gui,
        guibg = "NONE",
        ctermfg = color_table.alt_text.cterm,
        ctermbg = "NONE",
      },
      inactive = inactive,
    },
    error = {
      active = {
        guifg = color_table.text.gui,
        guibg = color_table.command.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.command.cterm,
      },
      inactive = inactive,
    },
    warning = {
      active = {
        guifg = color_table.text.gui,
        guibg = color_table.warning.gui,
        ctermfg = color_table.text.cterm,
        ctermbg = color_table.warning.cterm,
      },
      inactive = inactive,
    },
  }
end

return M
