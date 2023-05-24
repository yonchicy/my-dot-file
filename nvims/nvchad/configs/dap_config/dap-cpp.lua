local present,dap = pcall(require,'dap')
if not present then
    print("not find dap")
    return
end
dap.adapters.codelldb = {

  type = "server",
  host = '127.0.0.1',
  port = 13000,
  executable = {
    command =  vim.fn.stdpath"data" .. "/mason/bin/codelldb",
    args = {"--port" , "13000"}
  }
}
dap.configurations.cpp = {
-- launch exe
{
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    setupCommands = {
    {
        description =  'enable pretty printing',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
},
-- attach process
-- {
--     name = "Attach process",
--     type = "cppdbg",
--     request = "attach",
--     processId = require('dap.utils').pick_process,
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = "${workspaceFolder}",
--     setupCommands = {
--     {
--         description =  'enable pretty printing',
--         text = '-enable-pretty-printing',
--         ignoreFailures = false
--       },
--     },
-- },
-- -- attach server
-- {
--     name = 'Attach to gdbserver :1234',
--     type = 'cppdbg',
--     request = 'launch',
--     MIMode = 'gdb',
--     miDebuggerServerAddress = 'localhost:1234',
--     miDebuggerPath = '/usr/bin/gdb', cwd = '${workspaceFolder}',
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     setupCommands = {
--       {
--         text = '-enable-pretty-printing',
--         description =  'enable pretty printing',
--         ignoreFailures = false
--       },
--     },
--   },
}

-- setup other language
dap.configurations.c = dap.configurations.cpp

