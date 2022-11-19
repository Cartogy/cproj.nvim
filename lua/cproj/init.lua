local ProjData = require('cproj.proj_data')
local Utils = require('cproj.utils')

local M = {}
local CurrentProject = ProjData.create_empty_proj()

local run_gdb = function()
    vim.cmd("packadd termdebug")
	vim.cmd("Termdebug")
    -- Move to Source window
    vim.cmd("Source")
    -- Move the Source window to the right.
    vim.cmd('execute "normal! \\<c-w>L"')
end

M.setup = function(opts)
    local root_dir = Utils.root_directory()

    if root_dir == "" then
        return
    end

    local relative_build_path = ""

    if opts['build_path'] == nil then
        relative_build_path = "/out/build/"
    else
        relative_build_path = opts['build_path']
    end

    local build_path = root_dir .. relative_build_path

    local comp = ProjData.create_compilation("cmake", {"--build", build_path})
    local conf = ProjData.create_configuration("cmake", {"-S", root_dir, "-B", build_path})

    ProjData.set_root_dir(CurrentProject, root_dir)
    ProjData.set_configure_build(CurrentProject, conf)
    ProjData.set_debugger(CurrentProject, run_gdb)
    ProjData.set_compilation(CurrentProject, comp)
    ProjData.set_build_path(CurrentProject, build_path)

end

M.debug = function()
    CurrentProject.debug()
end

M.compile = function()
    local  comp_command = ProjData.build_cmd(ProjData.get_compilation(CurrentProject))
    vim.cmd("!"..comp_command)
end

M.conf_build = function()
    local conf_command = ProjData.build_cmd(ProjData.get_conf_build(CurrentProject))
    vim.cmd("!"..conf_command)
end

M.test = function()

    -- Create window to store tests.
    vim.cmd("vnew")
    local bufnr = vim.api.nvim_get_current_buf()
    local path_test = ProjData.get_build_path(CurrentProject)
    vim.fn.jobstart({"ctest", "--verbose","--test-dir", path_test},
    {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, data)
            end
        end,
    })
end

vim.api.nvim_create_user_command("CTest", function()
    M.test()
end, {})

vim.api.nvim_create_user_command("CDbg", function()
    M.debug()
end, {})

vim.api.nvim_create_user_command("CCompile", function()
    M.compile()
end, {})

vim.api.nvim_create_user_command("CConf", function()
    M.compile()
end, {})


return M
