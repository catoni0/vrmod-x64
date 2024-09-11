local mat = "models/sligwolf/unique_props/nodraw"

local function SetPlayerWeaponsMaterial(ply, material)
    local weapons = ply:GetWeapons()
    for _, weapon in ipairs(weapons) do
        if IsValid(weapon) then
            weapon:SetMaterial(material)
        end
    end
end

hook.Add("VRMod_Start", "VRFix-ON", function()
	for k, ply in ipairs(player.GetHumans()) do
		if !IsValid(ply) then continue end
		SetPlayerWeaponsMaterial(ply,mat)
	end
end)

hook.Add("VRMod_Exit", "VRFix-OFF", function()
	for k, ply in ipairs(player.GetHumans()) do
		if !IsValid(ply) then continue end
		SetPlayerWeaponsMaterial(ply,"")
	end
end)