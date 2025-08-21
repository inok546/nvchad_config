require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Debugger
map("n", "<leader>dq", "<cmd> DapTerminate <CR>", { desc = "Terminate the debugger" })
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add/remove breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start the debugger", noremap = true, silent = true })
map("n", "<leader>dn", "<cmd> DapStepOver <CR>", { desc = "Step over" })
map("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "Step into" })
map("n", "<leader>do", "<cmd> DapStepOut <CR>", { desc = "Step out" })
map("n", "<leader>dp", "<cmd> DapPause <CR>", { desc = "Pause the debugger" })
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
local term = require("nvchad.term")
local run  = require("configs.run")

vim.keymap.set("n", "<leader>rt", function()
  term.runner {
    id  = "run",
    pos = "sp",         
    cmd = run.quick_run 
  }
end, { desc = "Save, compile/run (temp dir / python), close on success", noremap = true, silent = true })

-- Duplicated debug shortcuts
-- NOTE: Depends on the terminal being used
map("n", "<F9>", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add/remove breakpoint at line" })
map("n", "<F5>", "<cmd> DapContinue <CR>", { desc = "Start/continue the debugger" })
map("n", "<F10>", "<cmd> DapStepOver <CR>", { desc = "Step over" })
map("n", "<F11>", "<cmd> DapStepInto <CR>", { desc = "Step into" })
map("n", "<F10>", "<cmd> DapStepOut <CR>", { desc = "Step out" })
map("n", "<F6>", "<cmd> DapPause <CR>", { desc = "Pause the debugger" })
map("n", "<S-F5>", "<cmd> DapTerminate <CR>", { desc = "Terminate the debugger" })
map("n", "<S-F7>", "<cmd> DapEval <CR>", { desc = "Evaluate expression" })
