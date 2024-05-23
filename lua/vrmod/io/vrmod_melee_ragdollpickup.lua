


-- クライアント側のコンソール変数を作成
AddCSLuaFile()

CreateClientConVar("vrmelee_ragdollpickup_range", 25, true, FCVAR_ARCHIVE, "Range to check for entities to grab")
CreateClientConVar("vrmod_pickup_weight", 100, true, FCVAR_ARCHIVE, "Max weight of entity to grab")
-- サーバー側でFindNearestEntity関数とTeleportEntityToHand関数を定義
if SERVER then
    -- utilライブラリが利用可能かどうかを確認
    if util ~= nil then
        -- ネットワークストリングを登録
        util.AddNetworkString("vrmelee_ragdollpickup")
        local function FindNearestEntity(ply, handPos, grabRange, maxWeight, excludeEnt)
            local nearestEnt = nil
            local nearestDist = grabRange
            for _, ent in ipairs(ents.FindInSphere(handPos, grabRange)) do
                if IsValid(ent) and not ent:IsPlayer() and ent:GetMoveType() == MOVETYPE_VPHYSICS and ent:GetPhysicsObject():GetMass() <= maxWeight then
                    local dist = handPos:Distance(ent:GetPos())
                    if dist < nearestDist then
                        nearestDist = dist
                        nearestEnt = ent
                    end
                end
            end

            return nearestEnt
        end

        local function TeleportEntityToHand(ply, handPos, ent, isLeftHand)
            if ent then
                ent:SetPos(handPos)
                ent:Activate(false)
                        pickup(ply, isLeftHand, handPos, Angle())

            end
        end

        -- ネットワークメッセージを受信した時の処理
        net.Receive(
            "vrmelee_ragdollpickup",
            function(len, ply)
                if not IsValid(ply) or ply:InVehicle() then return end
                local isLeftHand = net.ReadBool()
                local grabRange = net.ReadFloat()
                local maxWeight = net.ReadFloat()
                local entClass = net.ReadString()
                local handPos
                if isLeftHand then
                    handPos, _ = vrmod.GetLeftHandPose(ply)
                else
                    handPos, _ = vrmod.GetRightHandPose(ply)
                end

                local foundEnt = nil
                local otherHandEnt = g_VR[ply:SteamID()].heldItems and g_VR[ply:SteamID()].heldItems[isLeftHand and 2 or 1] and g_VR[ply:SteamID()].heldItems[isLeftHand and 2 or 1].ent
                if entClass == "" then
                    foundEnt = FindNearestEntity(ply, handPos, grabRange, maxWeight, otherHandEnt)
                else
                    for _, ent in ipairs(ents.FindInSphere(handPos, grabRange)) do
                        if ent:GetClass() == entClass and ent ~= otherHandEnt then
                            foundEnt = ent
                            break
                        end
                    end
                end

                TeleportEntityToHand(ply, handPos, foundEnt, isLeftHand)
            end
        )
    else
        print("util library is not available. Skipping network string registration.")
    end
end

-- クライアント側のコマンド
if CLIENT then
    -- vrmelee_ragdollpickup_leftの改造
    concommand.Add(
        "vrmelee_ragdollpickup_left",
        function(ply, cmd, args)
            if ply:InVehicle() then return end
            local grabRange = GetConVar("vrmelee_ragdollpickup_range"):GetFloat()
            local maxWeight = GetConVar("vrmod_pickup_weight"):GetFloat()
            local entClass = args[1] or ""
            net.Start("vrmelee_ragdollpickup")
            net.WriteBool(true) -- isLeftHand
            net.WriteFloat(grabRange)
            net.WriteFloat(maxWeight)
            net.WriteString(entClass)
            net.SendToServer()
        end 
    )

    -- vrmelee_ragdollpickup_rightの改造
    concommand.Add(
        "vrmelee_ragdollpickup_right",
        function(ply, cmd, args)
            if ply:InVehicle() then return end
            local grabRange = GetConVar("vrmelee_ragdollpickup_range"):GetFloat()
            local maxWeight = GetConVar("vrmod_pickup_weight"):GetFloat()
            local entClass = args[1] or ""
            net.Start("vrmelee_ragdollpickup")
            net.WriteBool(false) -- isLeftHand
            net.WriteFloat(grabRange)
            net.WriteFloat(maxWeight)
            net.WriteString(entClass)
            net.SendToServer()
        end
    )
end