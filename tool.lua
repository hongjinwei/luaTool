local Class = require 'luaTool.Class'
local tool = Class:new()
local gsub = string.gsub
local insert = table.insert
local lower = string.lower
--change table to string
function tool:table2string(t)
    if type(t) ~= 'table' then 
        return tostring(t)
    end
    local str = ""
    local sep = ""
    for k,v in pairs(t)do
        if type(k) == 'number' then 
            str = str .. sep   .. '[' .. self:table2string(k) .. ']' .. " = " ..  self:table2string(v) 
            sep = ", "
        else 
            str = str .. sep   ..'"'.. self:table2string(k)..'"' .. " = " ..  self:table2string(v) 
            sep = ", "
        end
    end
    return '{' .. str ..'}'
end

--check if table in nil , if use next, when tbl={a={},b={}},next(tbl) is ture
--but we need to know whether it has any member, so false is returned when you use
--this function checkNilTable(tbl)
function tool:checkNilTable(tbl)
    if not tbl then
        return true
    end
    if type(tbl) ~= 'table' then
        return false
    end
    if  not next(tbl) then
        return true
    end
    local sign = true
    for k,v in pairs(tbl) do
        if not self:checkNilTable(v) then
            sign = false
            break
        end
    end
    return sign
end

function tool:split(str, sep)
    if not str or not sep then 
        return nil
    end
    local t = {}
    gsub(str, '[^' .. sep .. ']+', function(w) insert(t,w) end)
    return t
end
return tool

--change a string type to boolean type which should be bool type
function tool:tobool(s)
    if not s then return false end
    if type(s) == 'boolean' then return s end
    if type(s) == 'string' then 
        return (lower(s) == 'true') and true or false
    end
end
