if SERVER then return end
local convars, convarValues = vrmod.GetConvars()
hook.Add(
    "VRMod_Menu",
    "addsettings04",
    function(frame)
        --Settings02 Start
        --add VRMod_Menu Settings02 propertysheet start
        local sheet = vgui.Create("DPropertySheet", frame.DPropertySheet)
        frame.DPropertySheet:AddSheet("Non-VR Weapons", sheet)
        sheet:Dock(FILL)
        local MenuTab12 = vgui.Create("DPanel", sheet)
        sheet:AddSheet("Non-VR Weapons", MenuTab12, "icon16/gun.png")
        MenuTab12.Paint = function(self, w, h) end
        -- vrmod_release.luaのconvarを操作するメニュー項目の追加
        local releaseenable_checkbox = MenuTab12:Add("DCheckBoxLabel")
        releaseenable_checkbox:SetPos(20, 10)
        releaseenable_checkbox:SetText("[release -> Emptyhand] Enable")
        releaseenable_checkbox:SetConVar("vrmod_pickupoff_weaponholster")
        releaseenable_checkbox:SizeToContents()
        local dropenable_checkbox = MenuTab12:Add("DCheckBoxLabel")
        dropenable_checkbox:SetPos(20, 40)
        dropenable_checkbox:SetText("[Tediore like reload] Enable")
        dropenable_checkbox:SetConVar("vrmod_weapondrop_enable")
        dropenable_checkbox:SizeToContents()
        local dropmode_checkbox = MenuTab12:Add("DCheckBoxLabel")
        dropmode_checkbox:SetPos(20, 70)
        dropmode_checkbox:SetText("Trash Weapon on Drop")
        dropmode_checkbox:SetConVar("vrmod_weapondrop_trashwep")
        dropmode_checkbox:SizeToContents()
        -- vrmod_pouch_weapon_1からvrmod_pouch_weapon_5を操作するメニュー項目の追加
        for i = 1, 5 do
            local weapon_textentry = vgui.Create("DTextEntry", MenuTab12)
            weapon_textentry:SetPos(20, 160 + (i - 1) * 30)
            weapon_textentry:SetSize(370, 25)
            weapon_textentry:SetText("Weapon Slot " .. i)
            weapon_textentry:SetConVar("vrmod_pouch_weapon_" .. i)
        end
    end
)
