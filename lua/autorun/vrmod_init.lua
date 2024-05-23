local paths = {}

local _, folders = file.Find("vrmod/*","LUA")
table.sort(folders, function(a,b) return tonumber(a) < tonumber(b) end)
for k,v in ipairs(folders) do
	paths[#paths+1] = "vrmod/"..v.."/"
end
paths[#paths+1] = "vrmod/"

for k,v in ipairs(paths) do
	for k2,v2 in ipairs(file.Find(v.."*","LUA")) do
		AddCSLuaFile(v..v2)
		include(v..v2)
	end
end
-- local function AddFiles(folder)
--      local files, directories = file.Find(folder .. "/*", "LUA")
--
--      for _, file in ipairs(files) do
--          if string.EndsWith(file, ".lua") then
--             AddCSLuaFile(folder .. "/" .. file)
--             include(folder .. "/" .. file)
--          end
--      end
--
--      for _, directory in ipairs(directories) do
--          AddFiles(folder .. "/" .. directory)
--      end
--  end
--
--  AddFiles("vrmod") -- Replace with your addon's root folder
