-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------
local common = require('hardline.common')
local custom_colors = require('hardline.themes.custom_colors')
local fmt = string.format
local M = {}

-------------------- OPTIONS -------------------------------
M.options = {
  theme = 'default',
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'med', item = require('hardline.parts.filename').get_item},

    {class = 'high', item = require('hardline.parts.git').get_item, hide = 100},

    '%<',
    {class = 'med', item = '%='},
    {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 100},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},

    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
  custom_theme = {
    text = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    normal = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    insert = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    replace = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    inactive_comment = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    inactive_cursor = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    inactive_menu = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    visual = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    command = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    alt_text = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
    warning = {gui = "NONE", cterm = "NONE", cterm16 = "NONE"},
  },
}

-------------------- SECTION MANAGEMENT --------------------
local function aggregate_sections(sections)
  local aggregated, piv = {}, 1
  while piv <= #sections do
    if type(sections[piv]) == 'table' then
      local items = {}
      for j = piv, #sections + 1 do
        if j == #sections + 1 or sections[j].class ~= sections[piv].class then
          table.insert(aggregated, {
            class = sections[piv].class,
            item = fmt(' %s ', table.concat(items, ' ')),
          })
          piv = j
          break
        end
        table.insert(items, sections[j].item)
      end
    else
      table.insert(aggregated, sections[piv])
      piv = piv + 1
    end
  end
  return aggregated
end

local function remove_empty_sections(sections)
  local filter = function(section)
    if type(section) == 'table' then
      return section.item ~= ''
    end
    return section ~= ''
  end
  return vim.tbl_filter(filter, sections)
end

local function load_sections(sections)
  function load_section(section)
    if type(section) == 'string' then
      return section
    end
    if type(section) == 'function' then
      return section()
    end
    if type(section) == 'table' then
      return {
        class = section.class or 'none',
        item = load_section(section.item),
      }
    end
    common.echo('Invalid section', 'WarningMsg')
    return ''
  end
  return vim.tbl_map(load_section, sections)
end

local function remove_hidden_sections(sections)
  local filter = function(section)
    return not section.hide or section.hide <= vim.fn.winwidth(0)
  end
  return vim.tbl_filter(filter, sections)
end

-------------------- SECTION HIGHLIGHTING ------------------
local function get_section_state(section, is_active)
  if section.class == 'mode' then
    if is_active then
      local mode = common.modes[vim.fn.mode()] or common.modes['?']
      return mode.state
    end
  end
  return is_active and 'active' or 'inactive'
end

local function highlight_sections(sections, is_active)
  function highlight_section(section)
    if type(section) ~= 'table' then
      return section
    end
    if section.class == 'none' then
      return section.item
    end
    local state = get_section_state(section, is_active)
    local hlgroup = fmt('Hardline_%s_%s', section.class, state)
    if vim.fn.hlexists(hlgroup) == 0 then
      return section.item
    end
    return fmt('%%#%s#%s%%*', hlgroup, section.item)
  end
  return vim.tbl_map(highlight_section, sections)
end

-------------------- STATUSLINE ----------------------------
function M.update_statusline(is_active)
  local sections = M.options.sections
  sections = remove_hidden_sections(sections)
  sections = load_sections(sections)
  sections = remove_empty_sections(sections)
  sections = aggregate_sections(sections)
  sections = highlight_sections(sections, is_active)
  return table.concat(sections)
end

-------------------- SETUP -----------------------------
local function set_theme()
  if type(M.options.theme) ~= 'string' then
    return
  end
  if M.options.theme == 'custom' then
    M.options.theme = custom_colors.set(M.options.custom_theme)
  else
    local theme = fmt('hardline.themes.%s', M.options.theme)
    M.options.theme = require(theme)
  end
end

local function set_hlgroups()
  for class, attr in pairs(M.options.theme) do
    for state, args in pairs(attr) do
      local hlgroup = fmt('Hardline_%s_%s', class, state)
      local a = {}
      for k, v in pairs(args) do
        table.insert(a, fmt('%s=%s', k, v))
      end
      a = table.concat(a, ' ')
      vim.cmd(fmt('autocmd VimEnter,ColorScheme * hi %s %s', hlgroup, a))
    end
  end
end

local function set_statusline()
  vim.opt.showmode = false
  vim.opt.statusline = [[%{%luaeval('require("hardline").update_statusline(false)')%}]]
  vim.cmd([[
  augroup hardline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%{%luaeval('require(\"hardline\").update_statusline(true)')%}
    autocmd WinLeave,BufLeave * setlocal statusline=%{%luaeval('require(\"hardline\").update_statusline(false)')%}
  augroup END
  ]])
end

function M.setup(user_options)
  if user_options then
    M.options = vim.tbl_extend('force', M.options, user_options)
  end
  set_theme()
  set_hlgroups()
  set_statusline()
end

------------------------------------------------------------
return M
