--this is a lua matlab module
--mainly deal with matrix cacilating problems

---------data type--------
--array = {1,2,3,4,5}
--matrix = {
--      [1] = {1,2,3,4,5},
--      [2] = {2,3,4,5,6},
--      [3] = {3,4,5,6,7}
--}

matlab = {}
matlab.version = '0.0.1'

--given the table{1,2,3,4,5} and return an array obj
function matlab.array(tbl,t)
    if not tbl or type(tbl) ~= 'table' then 
        return nil, "not table datatype or a nil table!"
    end
    local array = {}
    array.data = {}
    for _,v in ipairs(tbl) do
        array.data[#(array.data) + 1] = v
    end
    local mt = {
        __index = {
            T = function()  
                    if array.datatype == 'a' then 
                        array.datatype = 'a_t' 
                    else 
                        array.datatype = 'a'
                    end
                        return array  
                end    
        }
    } 
    setmetatable(array,mt)
    if not t then 
        array.datatype = "a"
    else 
        array.datatype = "a_t"
    end
    return array
end

local function array_len(array)
    if not string.find(array.datatype, 'a') then 
        return nil, "not a array type"
    end
    return #(array.data)
end

local function matrix_size(matrix)
end

local function judge_cal(a, b, op)
    if op == '+' or op == '-' then 
        if string.find(a.datatype, 'a') and string.find(b.datatype, 'a') then
            if a.datatype ~= b.datatype then 
                return false, "two different arrays"
            elseif array_len(a) ~= array_len(b) then 
                return false, "two array in different length" 
            else 
                return true
            end
        end
        if string.find(a.datatype, 'm') and string.find(b.datatype, 'm') then 
            
        end
    end
    if op == '*' or op == '/' then 

    end
end

function matlab.plus(a1, a2)
    if a1.datatype ~= a2.datatype then 
       return  nil, "not same datatype or exists transferred array"
    end

    
    if a1.datatype == 'a' then 
        result = matlab.array(a1) 
        len = #(result.data)
        for i=1, len do
        end
    end
end

--[[
array = matlab.array({1,2,3})
array1 = matlab.array({4,5,6})
s = array.T()
a = (array1.T())
print(s.data[2],a.datatype)

--]]
