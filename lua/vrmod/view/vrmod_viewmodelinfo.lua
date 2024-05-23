if CLIENT then

	g_VR = g_VR or {}
	g_VR.viewModelInfo = g_VR.viewModelInfo or {}
	
	g_VR.viewModelInfo.autoOffsetAddPos = Vector(1,0.2, 0)
	
	g_VR.currentvmi = nil
	
	g_VR.viewModelInfo.gmod_tool = {
		--modelOverride = "models/weapons/w_toolgun.mdl",
		offsetPos = Vector(-12, 6.5, 7), --forw, left, up
		offsetAng = Angle(0, 0, 0),
	}
	
	--g_VR.viewModelInfo.weapon_physgun = {
		--offsetPos = Vector(-24.5, 13.4, 14.5),
		--offsetAng = Angle(0, 0, 0),
	--}
	
	--g_VR.viewModelInfo.weapon_physcannon = {
		--offsetPos = Vector(-24.5, 13.4, 14.5),
		--offsetAng = Angle(0, 0, 0),
	--}
	
	
	g_VR.viewModelInfo.weapon_shotgun = {
		offsetPos = Vector(-14.5, 10, 8.5),
		offsetAng = Angle(0, 0, 0),
	}
	
	g_VR.viewModelInfo.weapon_rpg = {
		offsetPos = Vector(-27.5, 19, 10.5),
		offsetAng = Angle(0, 0, 0),
	}
	
	g_VR.viewModelInfo.weapon_crossbow = {
		offsetPos = Vector(-14.5, 10, 8.5),
		offsetAng = Angle(0, 0, 0),
	}
	
	g_VR.viewModelInfo.weapon_medkit = {
		offsetPos = Vector(-23,10,5),
		offsetAng = Angle(0, 0, 0),
	}
	
	g_VR.viewModelInfo.weapon_crowbar = {
		wrongMuzzleAng = true --lol
	}
	
	g_VR.viewModelInfo.weapon_stunstick = {
		wrongMuzzleAng = true
	}

-- custom
	g_VR.viewModelInfo.weapon_microwaverifle = {
		offsetPos = Vector(-9, 6.5, 10),
		offsetAng = Angle(0, 0, 0),
	}
	g_VR.viewModelInfo.weapon_vfirethrower = {
		offsetPos = Vector(13, 2, -6),
		offsetAng = Angle(0, 0, 0),
	}


	g_VR.swepOriginalFovs = g_VR.swepOriginalFovs or {}
	g_VR.lastUpdatedWeapon = ""

	-- local function ResetViewmodelInfo()
	-- 	g_VR.viewModel = nil
	-- 	g_VR.openHandAngles = g_VR.defaultOpenHandAngles
	-- 	g_VR.closedHandAngles = g_VR.defaultClosedHandAngles
	-- 	g_VR.currentvmi = nil
	-- 	g_VR.viewModelMuzzle = nil
	-- end

	-- function vrmod.UpdateViewmodelInfo(wep,force)
	-- 	if !IsValid(wep) then
	-- 		ResetViewmodelInfo()
	-- 		g_VR.lastUpdatedWeapon = ""
	-- 		return
	-- 	end

	-- 	local class = wep:GetClass()
	-- 	if class == g_VR.lastUpdatedWeapon && !force then return end

	-- 	local vm = wep:GetWeaponViewModel()
	-- 	if vm == "" or vm == "models/weapons/c_arms.mdl" then
	-- 		ResetViewmodelInfo()
	-- 		g_VR.lastUpdatedWeapon = class
	-- 		return
	-- 	end

	-- 	-----------------------
		
	-- 	// Drawing with worldmodels
	-- 	/*if vrmod.GetWeaponDrawMode(wep) == VR_WEPDRAWMODE_VIEWMODEL then
	-- 		ResetViewmodelInfo()

	-- 		vrmod.SetRightHandOpenFingerAngles( g_VR.zeroHandAngles )
	-- 		vrmod.SetRightHandClosedFingerAngles( g_VR.zeroHandAngles )

	-- 		g_VR.viewModel = wep
	-- 		return
	-- 	end*/
		
	-- 	-------------------------
	-- 	local drawWorld = vrmod.GetWeaponDrawMode(wep) != VR_WEPDRAWMODE_VIEWMODEL
	-- 	g_VR.viewModel = !drawWorld && LocalPlayer():GetViewModel() or wep

	-- 	if wep.ViewModelFOV then
	-- 		if !g_VR.swepOriginalFovs[class] then
	-- 			g_VR.swepOriginalFovs[class] = wep.ViewModelFOV
	-- 		end
	-- 		wep.ViewModelFOV = GetConVar("fov_desired"):GetFloat()
	-- 	end

	-- 	local vmi = g_VR.viewModelInfo[class] or {}
	-- 	local model = vmi.modelOverride or g_VR.viewModel:GetModel()

	-- 	--create offsets if they don't exist
	-- 	if vmi.offsetPos == nil or vmi.offsetAng == nil then
	-- 		vmi.offsetPos, vmi.offsetAng = Vector(), Angle()

	-- 		local cm = ClientsideModel(wep:GetWeaponViewModel())
	-- 		if IsValid(cm) then
	-- 			cm:SetNoDraw(true)
	-- 			cm:SetupBones()

	-- 			local bone = cm:LookupBone("ValveBiped.Bip01_R_Hand")
	-- 			if bone then
	-- 				local boneMat = cm:GetBoneMatrix(bone)
	-- 				local bonePos, boneAng = boneMat:GetTranslation(), boneMat:GetAngles()
	-- 				boneAng:RotateAroundAxis(boneAng:Forward(),180)

	-- 				vmi.offsetPos, vmi.offsetAng = WorldToLocal(vector_origin,angle_zero,bonePos,boneAng)
	-- 				vmi.offsetPos = vmi.offsetPos + g_VR.viewModelInfo.autoOffsetAddPos
	-- 			end

	-- 			cm:Remove()
	-- 		end
	-- 	end

	-- 	--create finger poses
	-- 	vmi.closedHandAngles = vrmod.GetRightHandFingerAnglesFromModel( model )

	-- 	// TODO: ArcVR weapons set this manually, but only on deploy so we want to avoid breaking it
	-- 	vrmod.SetRightHandClosedFingerAngles( vmi.closedHandAngles )
	-- 	vrmod.SetRightHandOpenFingerAngles( vmi.closedHandAngles )

	-- 	g_VR.viewModelInfo[class] = vmi
	-- 	g_VR.currentvmi = vmi

	-- 	g_VR.lastUpdatedWeapon = class
	-- end
end
