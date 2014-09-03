local tool = require 'tool'
--a = {a=1,b=2,c={1,2},w = 1 }
--print(tool:table2string(a))
--print(tool:checkNilTable({{},{s={}}}))

s  = '1,2,34,4,5,6'
b  = tool:split(s,',')
print(b[1])
