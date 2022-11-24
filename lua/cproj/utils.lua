local M = {}

local NOROOT = 0
local ROOT = 1

local has_git_root = function(reg)
	vim.cmd("let @"..reg.." = system('git rev-parse --show-toplevel')")

	local no_git = vim.fn.stridx(vim.fn.getreg(reg),"fatal")
	if no_git == 0 then
        return NOROOT, ""
    else
        -- remove 'new line' char.
		local root_dir = vim.fn.getreg('x'):gsub("[\n]","")

        return ROOT, root_dir
    end
end

M.root_directory = function()
    local status, root_dir = has_git_root('x')
    if status == NOROOT then
        -- No GIT
        return ""
    else
        return root_dir
    end
end

M.valid_cmake = function(root_dir)
    local cmake_lists_file = root_dir .. '/CMakeLists.txt'
    local has_cmake = vim.fn.filereadable(cmake_lists_file)

    if has_cmake == 1 then
        return true
    else
        return false
    end
end

M.has_build_path = function(root_dir, build_path)
    local build_dir = root_dir .. build_path
    local has_build = vim.fn.isdirectory(build_dir)

    if has_build == 1 then
        return true
    else
        return false
    end

end

return M
