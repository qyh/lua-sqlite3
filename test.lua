local sqlite = require "sqlite"
print('test.lua')
local o = sqlite.open("./testDB.db");
print(o:test(a, function(t)
	print('on callback function')
	print(string.format('a:%s', a))
	for k, v in pairs(t) do
		print(k, v)
	end
end))


local r = o:sqlite3_exec("select * from user;", function(rv) 
	print('on call back :')
	if rv then
		for k, v in pairs(rv) do
			print(k, v)
		end
	end
end)
print('exec return :', r)
print(o:exec("update user set gold=900 where ID=3"))

local r = o:exec("select * from user;", function(t) 
	print('on batch call back:', t)
	if t then
		for k, v in pairs(t) do
			print(k)
			if type(v) == 'table' then
				for kk, vv in pairs(v) do
					print(kk, vv)
				end
			end
		end
	end
end)
print('exec_bach:', r)


