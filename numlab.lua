--this is a lua matlab module
--mainly deal with matrix cacilating problems

---------data type--------
--array = {1,2,3,4,5}
--matrix = {
--      [1] = {1,2,3,4,5},
--      [2] = {2,3,4,5,6},
--      [3] = {3,4,5,6,7}
--}
local cjson = require 'cjson'

lab = {}
lab.version = '0.0.1'

--------------------------------------------------------------
------ local util function
-------------------------------------------------------------
local function array_len(array)
    if not string.find(array.datatype, 'a') then 
        return nil, "not a array type"
    end
    return #(array.data)
end

local function matrix_size(matrix)
    if type(matrix) ~= 'table' or not string.find(matrix.datatype, 'm') 
          or not next(matrix.data) then 
        return nil, 'not correct type'
    end
    
    size = {}
    size.len = #(matrix.data[1])
    size.height = #(matrix.data)
    return size
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
        elseif string.find(a.datatype, 'm') and string.find(b.datatype, 'm') then 
            
        end
    end
    if op == '*' or op == '/' then 

    end
end
---------------------------------------------
---------------------------------------------
--given the table{1,2,3,4,5} and return an array obj
function lab.array(tbl,t)
    if not tbl or type(tbl) ~= 'table' then 
        return nil, "not table datatype or a nil table!"
    end
    local array = {}
    if not t then 
        array.datatype = "a"
    else 
        array.datatype = "a_t"
    end
    array.data = {}
    for _,v in ipairs(tbl) do
        array.data[#(array.data) + 1] = v
    end
    local mt = {
        __index = {
            size = array_len(array),
            T = function()  
                    local mat = {}
                    if array.datatype == 'a' then 
                        mat.datatype = 'a_t' 
                    else 
                        mat.datatype = 'a'
                    end
                    return mat 
                end    
        }
    } 
    setmetatable(array,mt)
    return array
end

--give table like  {{1,2,3},{4,5,6}} create a matrix obj
function lab.matrix(tbl)
    if type(tbl) ~= 'table' or type(tbl[1]) ~= 'table' then 
        return nil, 'not correct argument'
    end
    
    if not next(tbl[1]) then 
        return nil, 'empty table'
    end

    len = #(tbl[1])
    for _,v in ipairs(tbl) do
        if len ~= #v then 
            return nil,'not correct argument'
        end
    end

    matrix = {}
    matrix.datatype = 'm'
    matrix.data = tbl
    matrix.size = matrix_size(matrix)
    mt = {
        __index = {
            size = matrix_size(matrix),
            T = function()
                    mat = {}
                    mat.data = {}
                    mat.datatype = 'm'
                    mat.size ={
                        len = matrix.size.height,
                        height = matrix.size.len
                    }
                    for i=1,mat.size.height do
                        for j=1,mat.size.len do
                            if type(mat.data[i]) ~= 'table' then 
                                mat.data[i] = {}
                            end
                            mat.data[i][j] =  matrix.data[j][i]
                        end
                    end
                    return mat
                end 
        }
    }
    setmetatable(matrix,mt)
    return matrix
end

--eye function return a nxn eye matrix
function lab.eye(n)
    
    if n <=0 or type(n) ~= 'number' or not tonumber(n) then 
        return nil, 'wrong number!' 
    end
    local tbl = {}
    for i=1, n do 
        tbl[i] = {}
        for j = 1, n do
            if j == i then 
                tbl[i][j] = 1 
            else 
                tbl[i][j] = 0
            end
        end
    end
    return lab.matrix(tbl)
end

function lab.tostring(obj)
    if type(obj) ~= 'table' or not obj.datatype or not (string.find(obj.datatype,'a')
        or string.find(obj.datatype,'m')) then 
        return nil, 'error datatype'
    end
    if obj.datatype == 'a' then 
        local str = 'array['
        local sep = ''
        for _,v in ipairs(obj.data) do
            str = str .. sep .. v 
            sep = ', '
        end
        return str .. ']\n'
    elseif obj.datatype == 'a_t' then 
        local str = 'array[\n'
        local sep = ','
        head = '        ' 
        for k,v in ipairs(obj.data) do
            if k == obj.size then sep = '' end
            str = str .. head .. v .. sep .. '\n' 
        end
        return str .. '     ]\n'
    elseif obj.datatype == 'm' then 
        str = 'matrix{\n'
        head = '        '
        tail = ','
        for k,v in ipairs(obj.data) do
            inner = '['
            sep = ''
            if k == obj.size.height then 
                tail = ''
            end
            for _,e in ipairs(v) do
                inner = inner .. sep .. e 
                sep = ','
            end
            str = str .. head .. inner .. ']' .. tail .. '\n'
        end
        return  str .. '      }\n'
    end
end

function lab.plus(a1, a2)
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


array = lab.array({1,2,3})
c = lab.array({2,3,4},'t')
print(lab.tostring(array))
print(lab.tostring(c))


a = {
    {1,2,3,4},
    {2,3,4,6}
    }

b = lab.matrix(a)
print(lab.tostring(b))
d = b.T()
print(lab.tostring(d))


print(lab.tostring(lab.eye(4)))
