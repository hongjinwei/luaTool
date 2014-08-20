local Class = require 'luaTool.Class'
local tool = Class:new()

function tool:table2string(t)
    if type(t) ~= 'table' then 
        return tostring(t)
    end
    local str = ""
    local sep = ""
    for k,v in pairs(t)do
        if type(k) == 'number' then 
            str = str .. sep   .. '[' .. self:table2string(k) .. ']' .. "=" ..  self:table2string(v) 
            sep = ","
        else 
            str = str .. sep   ..'"'.. self:table2string(k)..'"' .. "=" ..  self:table2string(v) 
            sep = ","
        end
    end
    return '{' .. str ..'}'
end

--return tool

s = {a =3,4,{s=1,b=3}}
print(tool:table2string(s))
