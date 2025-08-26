-- Functions
local M = {}

function M.quick_run()
  vim.cmd("write")

  local file = vim.fn.expand("%:p")
  local ft   = vim.bo.filetype or ""
  local ext  = vim.fn.expand("%:e")

  -- Python
  if ft == "python" or ext == "py" then
    return "python3 " .. vim.fn.shellescape(file) .. " && exit"
  end

  -- C/C++
  local cc, std
  if ft == "c" or ext == "c" then
    cc, std = "gcc", "c17"
  elseif ft == "cpp" or ext == "cpp" or ext == "cc" or ext == "cxx" then
    cc, std = "clang++", "c++20"
  else
    vim.notify("Supports only C/C++ and python (ft=" .. tostring(ft) .. ")", vim.log.levels.WARN)
    return "echo 'No recipe for this filetype'"
  end

  local cmd = table.concat({
    [[td="$(mktemp -d 2>/dev/null || mktemp -d -t nvim)"]],
    cc .. " " .. vim.fn.shellescape(file) 
       .. " -g -O0 -Wall -Wextra -Werror -std=" .. std 
       .. " -lm"
       .. [[ -o "$td/a.out"]],
    [[ "$td/a.out" && exit ]], 
  }, " && ")

  return cmd
end

return M
