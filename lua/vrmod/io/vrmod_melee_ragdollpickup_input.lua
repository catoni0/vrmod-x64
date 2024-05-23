if CLIENT then
	local cl_pickupdisable = CreateClientConVar("vrmelee_ragdoll_pickup", 0, true, FCVAR_ARCHIVE)
	hook.Add(
		"VRMod_Input",
		"vrmod_nearragdollpick",
		function(action, pressed)
			if hook.Call("VRMod_AllowDefaultAction", nil, action) == false then return end
			if action == "boolean_left_pickup" and pressed then
				if !cl_pickupdisable:GetBool() then return end
				LocalPlayer():ConCommand("vrmelee_ragdollpickup_left prop_ragdoll")

				return
			end

			if action == "boolean_right_pickup" and pressed then
				if !cl_pickupdisable:GetBool() then return end
				LocalPlayer():ConCommand("vrmelee_ragdollpickup_right prop_ragdoll")

				return
			end
		end
	)
end