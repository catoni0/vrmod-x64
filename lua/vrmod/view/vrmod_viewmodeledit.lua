if CLIENT then
	-- 読み込み関数の修正
	local function LoadViewModelConfig()
		if file.Exists("vrmod/viewmodelinfo.json", "DATA") then
			local json = file.Read("vrmod/viewmodelinfo.json", "DATA")
			viewModelConfig = util.JSONToTable(json)
		else
			viewModelConfig = {}
		end
	end

	LoadViewModelConfig()
	-- GUIの作成
	function CreateWeaponConfigGUI()
		local frame = vgui.Create("DFrame")
		frame:SetSize(600, 400)
		frame:Center()
		frame:SetTitle("Weapon ViewModel Configuration")
		frame:MakePopup()
		local listview = vgui.Create("DListView", frame)
		listview:Dock(FILL)
		listview:AddColumn("Weapon Class")
		listview:AddColumn("Offset Position")
		listview:AddColumn("Offset Angle")
		-- 一覧の更新
		local function UpdateListView()
			if not viewModelConfig then return end -- 追加: viewModelConfigが空の場合は何もしない
			listview:Clear()
			for class, data in pairs(viewModelConfig) do
				listview:AddLine(class, tostring(data.offsetPos), tostring(data.offsetAng))
			end
		end

		-- 一覧にデータを追加
		UpdateListView()
		-- 新規追加ボタン
		local addButton = vgui.Create("DButton", frame)
		addButton:SetText("New")
		addButton:Dock(BOTTOM)
		addButton.DoClick = function()
			local currentWeapon = LocalPlayer():GetActiveWeapon()
			if IsValid(currentWeapon) then
				CreateAddWeaponConfigGUI(currentWeapon:GetClass())
				frame:Close()
			end
		end

		-- 編集ボタン
		local editButton = vgui.Create("DButton", frame)
		editButton:SetText("Edit")
		editButton:Dock(BOTTOM)
		editButton.DoClick = function()
			local selected = listview:GetSelectedLine()
			if selected then
				local class = listview:GetLine(selected):GetValue(1)
				CreateAddWeaponConfigGUI(class, true)
				frame:Close()
			end
		end

		-- 削除ボタン
		local deleteButton = vgui.Create("DButton", frame)
		deleteButton:SetText("Delete")
		deleteButton:Dock(BOTTOM)
		deleteButton.DoClick = function()
			local selected = listview:GetSelectedLine()
			if selected then
				local class = listview:GetLine(selected):GetValue(1)
				viewModelConfig[class] = nil
				UpdateListView()
				SaveViewModelConfig()
			end
		end
	end

	-- viewModelConfigのグローバル宣言
	viewModelConfig = viewModelConfig or {}
	-- 読み込み関数の修正
	local function LoadViewModelConfig()
		if file.Exists("vrmod/viewmodelinfo.json", "DATA") then
			local json = file.Read("vrmod/viewmodelinfo.json", "DATA")
			viewModelConfig = util.JSONToTable(json)
		else
			viewModelConfig = {}
		end
	end

	-- 新規追加・編集画面の作成
	function CreateAddWeaponConfigGUI(class, isEditing)
		local frame = vgui.Create("DFrame")
		frame:SetSize(300, 300)
		frame:Center()
		frame:SetTitle(isEditing and "Edit ViewModel Config" or "Add ViewModel Config")
		frame:MakePopup()
		local data = viewModelConfig[class] or {
			offsetPos = Vector(),
			offsetAng = Angle()
		}

		-- 元の設定を保持
		local originalData = table.Copy(data)

		-- Offset Positionの設定
		local posPanel = vgui.Create("DPanel", frame)
		posPanel:Dock(TOP)
		posPanel:SetHeight(100)
		posPanel:SetPaintBackground(false)
		local posLabel = vgui.Create("DLabel", posPanel)
		posLabel:SetText("Offset Position:")
		posLabel:Dock(TOP)
		local posSliders = {}
		for i, axis in ipairs({"X", "Y", "Z"}) do
			local slider = vgui.Create("DNumSlider", posPanel)
			slider:Dock(TOP)
			slider:SetText(axis)
			slider:SetMin(-100)
			slider:SetMax(100)
			slider:SetValue(data.offsetPos[i])
			slider:SetDecimals(3)
			posSliders[i] = slider
		end

		-- Offset Angleの設定
		local angPanel = vgui.Create("DPanel", frame)
		angPanel:Dock(TOP)
		angPanel:SetHeight(100)
		angPanel:SetPaintBackground(false)
		local angLabel = vgui.Create("DLabel", angPanel)
		angLabel:SetText("Offset Angle:")
		angLabel:Dock(TOP)
		local angSliders = {}
		for i, axis in ipairs({"P", "Y", "R"}) do
			local slider = vgui.Create("DNumSlider", angPanel)
			slider:Dock(TOP)
			slider:SetText(axis)
			slider:SetMin(-180)
			slider:SetMax(180)
			slider:SetValue(data.offsetAng[i])
			slider:SetDecimals(3)
			angSliders[i] = slider
		end

		-- Offset Position スライダーのイベントハンドラ
		for i, slider in ipairs(posSliders) do
			slider.OnValueChanged = function()
				local pos = Vector(posSliders[1]:GetValue(), posSliders[2]:GetValue(), posSliders[3]:GetValue())
				local ang = Angle(angSliders[1]:GetValue(), angSliders[2]:GetValue(), angSliders[3]:GetValue())
				-- ViewModelにリアルタイムで反映
				vrmod.SetViewModelOffsetForWeaponClass(class, pos, ang)
			end
		end

		-- Offset Angle スライダーのイベントハンドラ
		for i, slider in ipairs(angSliders) do
			slider.OnValueChanged = function()
				local pos = Vector(posSliders[1]:GetValue(), posSliders[2]:GetValue(), posSliders[3]:GetValue())
				local ang = Angle(angSliders[1]:GetValue(), angSliders[2]:GetValue(), angSliders[3]:GetValue())
				-- ViewModelにリアルタイムで反映
				vrmod.SetViewModelOffsetForWeaponClass(class, pos, ang)
			end
		end

		-- SaveViewModelConfig関数の定義
		local function SaveViewModelConfig()
			if not viewModelConfig then return end
			local json = util.TableToJSON(viewModelConfig, true) -- JSON形式で保存
			file.Write("vrmod/viewmodelinfo.json", json)
		end

		-- 適用ボタン
		local applyButton = vgui.Create("DButton", frame)
		applyButton:SetText("Apply")
		applyButton:Dock(BOTTOM)
		-- 適用ボタンのイベントハンドラ内
		applyButton.DoClick = function()
			data.offsetPos = Vector(posSliders[1]:GetValue(), posSliders[2]:GetValue(), posSliders[3]:GetValue())
			data.offsetAng = Angle(angSliders[1]:GetValue(), angSliders[2]:GetValue(), angSliders[3]:GetValue())
			-- 新しい設定を適用
			vrmod.SetViewModelOffsetForWeaponClass(class, data.offsetPos, data.offsetAng)
			-- 設定を保存
			viewModelConfig[class] = data
			SaveViewModelConfig()
			frame:Close()
		end


		-- 破棄ボタン
		local cancelButton = vgui.Create("DButton", frame)
		-- 元の設定に戻す
		vrmod.SetViewModelOffsetForWeaponClass(class, originalData.offsetPos, originalData.offsetAng)
		cancelButton:SetText("Cancel")
		cancelButton:Dock(BOTTOM)
		cancelButton.DoClick = function()
			frame:Close()
		end
	end

	-- GUI呼び出し時の初期化チェック
	concommand.Add(
		"vrmod_weaponconfig",
		function()
			if not viewModelConfig then
				LoadViewModelConfig() -- 念のための再読み込み
			end

			CreateWeaponConfigGUI()
		end
	)

	-- VRModが初期化されたときに呼び出される関数
	local function InitializeVRModViewModelSettings()
		-- 設定を読み込む
		LoadViewModelConfig()
		-- 各武器クラスに設定を適用する
		for classname, settings in pairs(viewModelConfig) do
			if settings.offsetPos and settings.offsetAng then
				vrmod.SetViewModelOffsetForWeaponClass(classname, settings.offsetPos, settings.offsetAng)
			end
		end
	end

	-- VRModの初期化時に上記の関数を呼び出す
	hook.Add("VRMod_Start", "InitializeViewModelSettings", InitializeVRModViewModelSettings)
end