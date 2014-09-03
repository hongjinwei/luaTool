local class = require 'Class'
s = class:new()

local b = {}

function b:a(n)

    if n == 0 then 
        return 
    else 
        print(n)
    end
    self:a(n-1)
end

b:a(10)
