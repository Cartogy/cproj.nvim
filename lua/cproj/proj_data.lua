-- This file contains all functions to manipulate the main data-type.


--[[

{
    root_dir = " "
    build_path = ""
    configure_build = {
        cmd = ""
        arg = { }
    },
    debug = Func,
    compilation = {
        cmd = " "
        arg = { }
    },
}

--]]

-- Field index stored in variables to avoid mis-typing anyone of them.
local _debug = "debug"
local _root_dir = "root_dir"
local _compilation = "compilation"
local _configure_build = "configure_build"
local _build_path = "build_path"

local M = {}

M.create_empty_proj = function()
    -- Default values
    local tbl = {
        root_dir = "",
        build_path = "",
        configure_build = { },
        debug = "",
        compilation = { }
    }
    return tbl
end

-- Getters for data type
M.get_root_dir = function(tbl)
    return tbl[_root_dir]
end

M.get_conf_build = function(tbl)
    return tbl[_configure_build]
end

M.get_debugger = function(tbl)
    return tbl[_debug]
end

M.get_compilation = function(tbl)
    return tbl[_compilation]
end

M.get_build_path = function(tbl)
    return tbl[_build_path]
end

-- Setters for data type
M.set_root_dir = function(tbl, dir)
    tbl[_root_dir] = dir
end

M.set_configure_build = function(tbl, cf)
    tbl[_configure_build] = cf
end

M.set_debugger = function(tbl, f)
    tbl[_debug] = f
end

M.set_compilation = function(tbl, cmp)
    tbl[_compilation] = cmp
end

M.set_build_path = function(tbl, build_path)
    tbl[_build_path] = build_path
end

--** Compilation table **

-- [[
-- 
--  compilation = {
--      cmd = " "
--      args = {...}
--      build_path = " "
--  }
--
-- ]]

M.create_compilation = function(cmd, args)
    local tbl = {}
    tbl['cmd'] = cmd
    tbl['args'] = args

    return tbl
end

M.build_cmd = function(tbl)
    local command = ""
    command = command .. tbl['cmd']
    for _, arg in pairs(tbl['args']) do
        command = command .. " "
        command = command .. arg
    end

    return command
end

M.create_configuration = function(cmd, args)
    local tbl = {}
    tbl['cmd'] = cmd
    tbl['args'] = args

    return tbl
end


return M
