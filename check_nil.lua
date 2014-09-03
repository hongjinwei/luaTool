
function checkNilTable(tbl)
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
        if not checkNilTable(v) then 
            sign = false
            break
        end
    end
    return sign
end


a = {ss={},d={s={{},{}}}}
print(checkNilTable(a))
