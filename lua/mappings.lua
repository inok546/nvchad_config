require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- debugger
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add/remove breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start/continue the debugger" })
map("n", "<leader>dn", "<cmd> DapStepOver <CR>", { desc = "Step over" })
map("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "Step into" })
map("n", "<leader>do", "<cmd> DapStepOut <CR>", { desc = "Step out" })
map("n", "<leader>dp", "<cmd> DapPause <CR>", { desc = "Pause the debugger" })
map("n", "<leader>dq", "<cmd> DapTerminate <CR>", { desc = "Terminate the debugger" })
map("n", "<leader>dc", "<cmd> lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Set conditional breakpoint" })
map("n", "<leader>dl", "<cmd> lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { desc = "Set log point" })
map("n", "<leader>du", "<cmd> DapUI <CR>", { desc = "Toggle DAP UI" })
