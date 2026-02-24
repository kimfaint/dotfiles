local dap = require('dap')

dap.adapters.robotframework = {
  type = 'server',
  port = 6612,
}

dap.configurations.robot = {
  {
    type = 'robotframework',
    request = 'launch',
    name = 'Robot Code debugger',
    program = 'robotcode',
    programArgs = {'--log', '--log-level', 'TRACE', '--log-filename', '/tmp/robotcode.log', '--log-calls', 'debug'},
    cwd = "${workspaceFolder}",
  }
}


vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
