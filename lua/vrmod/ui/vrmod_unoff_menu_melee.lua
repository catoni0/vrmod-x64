-- vrmod_vr_melee.lua
--------[vrmod_addmenu03.lua]Start--------
AddCSLuaFile()
if SERVER then return end
local convars, convarValues = vrmod.GetConvars()
-- 新しいタブを追加
hook.Add(
    "VRMod_Menu",
    "addsettingsmelee",
    function(frame)
        local sheet = vgui.Create("DPropertySheet", frame.DPropertySheet)
        frame.DPropertySheet:AddSheet("VRMelee", sheet)
        sheet:Dock(FILL)
        local MenuTabmelee = vgui.Create("DPanel", sheet)
        sheet:AddSheet("VRMelee1", MenuTabmelee, "icon16/briefcase.png")
        MenuTabmelee.Paint = function(self, w, h) end
        local form = vgui.Create("DForm", sheet)
        form:SetName("VRMelee")
        form:Dock(TOP)
        form.Header:SetVisible(false)
        form.Paint = function(self, w, h) end
        -- form:CheckBox("Allow Gun Melee", "vrmelee_gunmelee")
        form:CheckBox("Use Gun Melee", "vrmelee_usegunmelee")
        -- form:CheckBox("Allow Fist Attacks", "vrmelee_fist")
        form:CheckBox("Use Fist Attacks", "vrmelee_usefist")
        -- form:CheckBox("Allow Kick Attacks [FBT]", "vrmelee_kick")
        form:CheckBox("Use Kick Attacks [FBT]", "vrmelee_usekick")
        form:NumSlider("Melee Velocity Threshold", "vrmelee_velthreshold", 0.1, 10, 1)
        form:NumSlider("Melee Damage", "vrmelee_damage", 0, 1000, 0)
        form:NumSlider("Melee Delay", "vrmelee_delay", 0.01, 1, 2)
        form:CheckBox("Fist Collision", "vrmelee_fist_collision")
        form:CheckBox("Fist Collision Visible", "vrmelee_fist_visible")
        form:CheckBox("ragdoll wide pickup", "vrmelee_ragdoll_pickup")
        form:NumSlider("ragdoll pickup range", "vrmelee_ragdollpickup_range",0,40,1)
        form:TextEntry("Collision Model", "vrmelee_fist_collisionmodel")
    end
)