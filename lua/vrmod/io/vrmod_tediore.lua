AddCSLuaFile()
if SERVER then
    util.AddNetworkString("ChangeWeapon")
    util.AddNetworkString("ReloadHolster")
    util.AddNetworkString("DropWeapon")
    util.AddNetworkString("SelectEmptyWeapon")
    net.Receive(
        "ChangeWeapon",
        function(len, ply)
            local weaponClass = net.ReadString(8)
            ply:SelectWeapon(weaponClass)
        end
    )

    -- 他のネットワークメッセージの追加
    net.Receive(
        "SelectEmptyWeapon",
        function(len, ply)
            ply:SelectWeapon("weapon_vrmod_empty")
        end
    )

    net.Receive(
        "DropWeapon",
        function(len, ply)
            local wepdropmode = net.ReadBool()
            local rhandvel = net.ReadVector()
            local rhandangvel = net.ReadVector()
            local lhandvel = net.ReadVector()
            local lhandangvel = net.ReadVector()
            local wep = ply:GetActiveWeapon()
            local modelname = wep:GetModel()
            local guninhandpos = vrmod.GetRightHandPos(ply)
            local guninhandang = vrmod.GetRightHandAng(ply)
            local guninlefthandpos = vrmod.GetLeftHandPos(ply)
            local guninlefthandang = vrmod.GetLeftHandAng(ply)
            local gunvelocity = Vector(0, 0, 0)
            wep.VR_Pickup_Tag = false
            if wepdropmode then
                Wwep = ents.Create(wep:GetClass())
            else
                Wwep = ents.Create("prop_physics")
            end

            local wep = ply:GetActiveWeapon()
            if wep:IsValid() then
                local ammoType = wep:GetPrimaryAmmoType()
                local ammoCount = ply:GetAmmoCount(ammoType)
                local clipSize = wep:GetMaxClip1()
                local currentClip = wep:Clip1()
                if ammoCount > 0 and currentClip < clipSize then
                    local ammoNeeded = clipSize - currentClip
                    local ammoToGive = math.min(ammoNeeded, ammoCount)
                    wep:SetClip1(currentClip + ammoToGive)
                    ply:RemoveAmmo(ammoToGive, ammoType)
                end
            end

            ply:Give("weapon_vrmod_empty")
            Wwep:SetModel(modelname)
            ply:LookupBone("ValveBiped.Bip01_R_Hand")
            local Bon, BonAng = ply:GetBonePosition(11)
            Wwep:SetPos(guninhandpos + BonAng:Forward() * 10 - BonAng:Up() * 0 + BonAng:Right() * 4)
            Wwep:SetAngles(guninhandang)
            Wwep:SetModel(wep:GetModel())
            Wwep:Spawn()
            local phys = Wwep:GetPhysicsObject()
            if phys and phys:IsValid() then
                phys:Wake()
                phys:SetMass(99) -- 重さを90に設定
                phys:SetVelocity(ply:GetVelocity() + rhandvel)
                phys:AddAngleVelocity(-phys:GetAngleVelocity() + phys:WorldToLocalVector(rhandangvel))
            end

            if wepdropmode then
                ply:StripWeapon(ply:GetActiveWeapon():GetClass())
            end

            ply:Give("weapon_vrmod_empty")
            ply:SelectWeapon("weapon_vrmod_empty")
            -- 要望1: prop_physicsは投げてから10秒後に自動で消える
            timer.Simple(
                3,
                function()
                    if IsValid(Wwep) and Wwep:GetClass() == "prop_physics" then
                        Wwep:Remove()
                    end
                end
            )
        end
    )
end

if CLIENT then
    local tedioreenable = CreateClientConVar("vrmod_pickupoff_weaponholster", 1, true, FCVAR_ARCHIVE, "", 0, 1)
    local dropenable = CreateClientConVar("vrmod_weapondrop_enable", 0, true, FCVAR_ARCHIVE, "", 0, 1)
    local dropmode = CreateClientConVar("vrmod_weapondrop_trashwep", 0, true, FCVAR_ARCHIVE, "", 0, 1)
    local dummylefthand = CreateClientConVar("vrmod_lefthand", 0, false)
    local ply = LocalPlayer()
    hook.Add(
        "VRMod_Input",
        "ReloadHolsterinput",
        function(action, state)
            if tedioreenable:GetBool() and not dropenable:GetBool() then
                if not GetConVar("vrmod_lefthand"):GetBool() then
                    if action == "boolean_right_pickup" and not state then
                        net.Start("SelectEmptyWeapon")
                        net.SendToServer()

                        return
                    end
                else
                    if action == "boolean_left_pickup" and not state then
                        net.Start("SelectEmptyWeapon")
                        net.SendToServer()

                        return
                    end
                end
            end
        end
    )

    local ply = LocalPlayer()
    local dropmode = CreateClientConVar("vrmod_weapondrop_trashwep", 0, true, FCVAR_ARCHIVE, "", 0, 1)
    hook.Add(
        "VRMod_Input",
        "Tediore_holster_Drop",
        function(action, state)
            if dropenable:GetBool() then
                if GetConVar("vrmod_Foregripmode"):GetBool() then return end
                if not GetConVar("vrmod_lefthand"):GetBool() then
                    if action == "boolean_right_pickup" and not state then
                        net.Start("DropWeapon")
                        net.WriteBool(dropmode:GetBool())
                        net.WriteVector(vrmod.GetRightHandVelocity() * 2.5)
                        net.WriteVector(vrmod.GetRightHandAngularVelocity() * 2.5)
                        net.SendToServer()

                        return
                    end
                else
                    if action == "boolean_left_pickup" and not state then
                        net.Start("DropWeapon")
                        net.WriteBool(dropmode:GetBool())
                        net.WriteVector(vrmod.GetLeftHandVelocity() * 2.5)
                        net.WriteVector(vrmod.GetLeftHandAngularVelocity() * 2.5)
                        net.SendToServer()

                        return
                    end
                end
            end
        end
    )
end