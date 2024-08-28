require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- debugger
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add/remove breakpoint at line" })
-- TODO: Сделать чтобы автоматом компилился текущий файл при вызове дебагера
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start/continue the debugger" })
map("n", "<leader>dn", "<cmd> DapStepOver <CR>", { desc = "Step over" })
map("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "Step into" })
map("n", "<leader>do", "<cmd> DapStepOut <CR>", { desc = "Step out" })
map("n", "<leader>dp", "<cmd> DapPause <CR>", { desc = "Pause the debugger" })
map("n", "<leader>dq", "<cmd> DapTerminate <CR>", { desc = "Terminate the debugger" })
map(
  "n",
  "<leader>dc",
  "<cmd> lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Set conditional breakpoint" }
)
map(
  "n",
  "<leader>dl",
  "<cmd> lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  { desc = "Set log point" }
)
map("n", "<leader>?", function()
  require("dapui").eval(nil, { enter = true })
end, { desc = "Eval var under cursor" })

-- compile and run in terminal
-- TODO: Сделать чтобы файл сохранялся, прежде чем компилировался
map("n", "<leader>rt", function()
  require("nvchad.term").runner {
    id = "run",
    pos = "sp",
    cmd = function()
      vim.cmd("write")
      local file = vim.fn.expand "%"
      local ft_cmds = {
        cpp = "clang++ " .. file .. " -g -O0 -Wall -Wextra -Werror && ./a.out && exit",
      }
      return ft_cmds[vim.bo.ft]
    end,
  }
end, { desc = "Save, compile and run", noremap = true, silent = true })
