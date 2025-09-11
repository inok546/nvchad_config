-- lua/configs/mini-surround.lua
local M = {}

function M.setup()
  local ok, surround = pcall(require, "mini.surround")
  if not ok then return end

  surround.setup({
    mappings = {
      add = "sa",            -- добавить окружение
      delete = "sd",         -- удалить
      find = "sf",           -- найти справа
      find_left = "sF",      -- найти слева
      highlight = "sh",      -- подсветить
      replace = "sr",        -- заменить
      update_n_lines = "sn", -- радиус поиска
    },
    search_method = "cover_or_next",
  })

  -- which-key 
  pcall(function()
    local wk = require "which-key"

    -- v3 API (предпочтительно)
    local ok_add = pcall(wk.add, {
      { "s",  group = "surround", mode = { "n", "x" } },
      { "sa", desc  = "Add surround",       mode = { "n", "x" } },
      { "sd", desc  = "Delete surround",    mode = "n" },
      { "sr", desc  = "Replace surround",   mode = "n" },
      { "sf", desc  = "Find right",         mode = "n" },
      { "sF", desc  = "Find left",          mode = "n" },
      { "sh", desc  = "Highlight",          mode = "n" },
      { "sn", desc  = "Set n_lines radius", mode = "n" },
    })

    -- fallback для старого API (если вдруг нет :add)
    if not ok_add and wk.register then
      wk.register({
        s = {
          name = "surround",
          a = { "Add surround" },
          d = { "Delete surround" },
          r = { "Replace surround" },
          f = { "Find right" },
          F = { "Find left" },
          h = { "Highlight" },
          n = { "Set n_lines radius" },
        },
      }, { mode = "n" })

      wk.register({
        s = {
          name = "surround",
          a = { "Add surround" },
        },
      }, { mode = "x" })
    end
  end)
end

return M

