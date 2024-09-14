AddCSLuaFile()

include("vrmod/base/vrmod_api.lua")
include("vrmod/base/vrmod.lua")

local paths = {}

local _, folders = file.Find("vrmod/*","LUA")
table.sort(folders, function(a,b) return tonumber(a) < tonumber(b) end)
for k,v in ipairs(folders) do
	paths[#paths+1] = "vrmod/"..v.."/"
end
paths[#paths+1] = "vrmod/"

for k,v in ipairs(paths) do
	for k2,v2 in ipairs(file.Find(v.."*","LUA")) do
		if v2 ~= "vrmod.lua" and v2 ~= "vrmod_api.lua" then
			AddCSLuaFile(v..v2)
			include(v..v2)
		end
	end
end