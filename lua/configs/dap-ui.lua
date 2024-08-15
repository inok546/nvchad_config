local dap = require "dap"
local dapui = require "dapui"

dapui.setup()
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })

-- local function after_session()
--   dapui.close()
--   dap.repl.close()
-- end

-- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
-- dap.listeners.after.event_terminated["dapui_config"] = after_session
-- dap.listeners.after.event_exited["dapui_config"] = after_session
-- dap.listeners.after.disconnect["dapui_config"] = after_session

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
