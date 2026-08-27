local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

local g1 = Instance.new("ScreenGui")
if syn and syn.protect_gui then syn.protect_gui(g1) end
g1.Parent = game:GetService("CoreGui")
g1.Name = "InventoryPhoneTest"
g1.ResetOnSpawn = false
g1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local g2 = Instance.new("Frame")
g2.Parent = g1
g2.Name = "InventoryFrame"
g2.Visible = true
g2.Size = UDim2.new(0, 672, 0, 375)
g2.Position = UDim2.new(0.3, 0, 0.2, 0)
g2.BackgroundColor3 = Color3.fromRGB(24, 45, 83)
g2.BackgroundTransparency = 0.2
g2.Active = true

local r1 = Instance.new("UICorner")
r1.Parent = g2
r1.CornerRadius = UDim.new(0, 8)

local g3 = Instance.new("TextLabel")
g3.Parent = g2
g3.Text = "Astral MM2"
g3.TextColor3 = Color3.fromRGB(151,198,255)
g3.TextSize = 25
g3.Size = UDim2.new(0, 145, 0, 29)
g3.Position = UDim2.new(0.027, 0, 0.04, 0)
g3.BackgroundTransparency = 1
g3.Font = Enum.Font.Ubuntu

local g4 = Instance.new("Frame")
g4.Parent = g2
g4.Name = "FrameForCratesWhereAllCratesWithKnifesAndGunsAndOtherStuffThere..."
g4.BackgroundTransparency = 1
g4.Position = UDim2.new(0.257, 0, 0.024, 0)
g4.Size = UDim2.new(0, 491, 0, 357)

local g5 = Instance.new("Frame")
g5.Parent = g2
g5.Name = "CratesLol"
g5.BackgroundTransparency = 1
g5.Position = UDim2.new(0.257, 0, 0.024, 0)
g5.Size = UDim2.new(0, 491, 0, 357)

local r3 = Instance.new("Frame")
r3.Parent = g2
r3.BackgroundColor3 = Color3.fromRGB(16, 31, 56)
r3.BackgroundTransparency = 0.9
r3.Position = UDim2.new(0.243, 0, 0, 0)
r3.Size = UDim2.new(0, 1, 0, 375)

local g6 = Instance.new("TextButton")
g6.Parent = g2
g6.Text = "Home"
g6.TextColor3 = Color3.fromRGB(151, 198, 255)
g6.TextSize = 14
g6.Font = Enum.Font.Ubuntu
g6.Position = UDim2.new(0.027, 0, 0.157, 0)
g6.Size = UDim2.new(0, 126, 0, 37)
g6.BackgroundTransparency = 0.9
Instance.new("UICorner", g6).CornerRadius = UDim.new(0, 8)

local g7 = Instance.new("TextButton")
g7.Parent = g2
g7.Text = "MainFunctions"
g7.TextColor3 = Color3.fromRGB(151, 198, 255)
g7.TextSize = 14
g7.Font = Enum.Font.Ubuntu
g7.Position = UDim2.new(0.027, 0, 0.291, 0)
g7.Size = UDim2.new(0, 126, 0, 37)
g7.BackgroundTransparency = 0.9
Instance.new("UICorner", g7).CornerRadius = UDim.new(0, 8)

local g8 = Instance.new("TextButton")
g8.Parent = g5
g8.Name = "Text"
g8.Font = Enum.Font.Ubuntu
g8.TextSize = 14
g8.Position = UDim2.new(0.202, 0, 0.148, 0)
g8.Size = UDim2.new(0, 100, 0, 30)
g8.TextColor3 = Color3.fromRGB(255, 255, 255)
g8.BackgroundTransparency = 0.3
Instance.new("UICorner", g8).CornerRadius = UDim.new(0, 8)

local g9 = Instance.new("TextButton")
g9.Parent = g5
g9.Name = "TextButton"
g9.Font = Enum.Font.Ubuntu
g9.TextSize = 14
g9.Position = UDim2.new(0.167, 0, 0.034, 0)
g9.Size = UDim2.new(0, 100, 0, 30)
g9.TextColor3 = Color3.fromRGB(255, 255, 255)
g9.BackgroundTransparency = 0.2
Instance.new("UICorner", g9).CornerRadius = UDim.new(0, 8)

local g10 = Instance.new("TextLabel")
g10.Parent = g5
g10.Text = "ESP"
g10.TextColor3 = Color3.fromRGB(138, 182, 237)
g10.TextSize = 20
g10.Font = Enum.Font.Ubuntu
g10.Position = UDim2.new(0.039, 0, 0.056, 0)
g10.Size = UDim2.new(0, 34, 0, 15)
g10.BackgroundTransparency = 1

local g11 = Instance.new("TextLabel")
g11.Parent = g5
g11.Text = "Speed"
g11.TextColor3 = Color3.fromRGB(138, 182, 237)
g11.TextSize = 20
g11.Font = Enum.Font.Ubuntu
g11.Position = UDim2.new(0.039, 0, 0.171, 0)
g11.Size = UDim2.new(0, 34, 0, 15)
g11.BackgroundTransparency = 1

local dragging, dragStartPos, frameStartPos, currentDragTween = false, nil, nil, nil
g2.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStartPos = Vector2.new(mouse.X, mouse.Y)
		frameStartPos = g2.Position
		local moveConn
		moveConn = UserInputService.InputChanged:Connect(function(changed)
			if changed.UserInputType == Enum.UserInputType.MouseMovement and dragging then
				local delta = Vector2.new(mouse.X, mouse.Y) - dragStartPos
				local target = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
				if currentDragTween then currentDragTween:Cancel() end
				currentDragTween = TweenService:Create(g2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = target})
				currentDragTween:Play()
			elseif not dragging then
				moveConn:Disconnect()
			end
		end)
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

local espEnabled, playerColors, checkThread, renderConnection = false, {}, nil, nil
local speedOn, speedConnection = false, nil
local colorOn, colorOff = Color3.fromRGB(46, 204, 113), Color3.fromRGB(231, 76, 60)
local tInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

g8.BackgroundColor3 = colorOff g8.Text = "OFF"
g9.BackgroundColor3 = colorOff g9.Text = "OFF"

local function drawHeadMarker(player, color)
	local char = player.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end
	local marker = head:FindFirstChild("CustomHeadMarker")
	if espEnabled and color then
		if not marker then
			marker = Instance.new("BoxHandleAdornment")
			marker.Name = "CustomHeadMarker"
			marker.Adornee = head
			marker.AlwaysOnTop = true
			marker.Size = head.Size + Vector3.new(0.1, 0.1, 0.1)
			marker.ZIndex = 10
			marker.Parent = head
		end
		marker.Color3 = color
		marker.Transparency = 0.4
	else
		if marker then marker:Destroy() end
	end
end

local function clearAllMarkers()
	for _, player in ipairs(Players:GetPlayers()) do
		local char = player.Character
		if char and char:FindFirstChild("Head") then
			local m = char.Head:FindFirstChild("CustomHeadMarker")
			if m then m:Destroy() end
		end
	end
	playerColors = {}
end

local function startESP()
	checkThread = task.spawn(function()
		while true do
			for _, player in ipairs(Players:GetPlayers()) do
				if player == LocalPlayer then continue end
				local backpack = player:FindFirstChild("Backpack")
				local char = player.Character
				if char and char:FindFirstChild("Head") then
					local hasGun = false
					local hasKnife = false
					if backpack then
						if backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver") then hasGun = true end
						if backpack:FindFirstChild("Knife") then hasKnife = true end
					end
					if char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") then hasGun = true end
					if char:FindFirstChild("Knife") then hasKnife = true end
					if hasKnife then playerColors[player] = Color3.fromRGB(255, 0, 0)
					elseif hasGun then playerColors[player] = Color3.fromRGB(0, 100, 255)
					else playerColors[player] = Color3.fromRGB(0, 255, 0) end
				else playerColors[player] = nil end
			end
			task.wait(0.2)
		end
	end)
	renderConnection = RunService.RenderStepped:Connect(function()
		for _, player in ipairs(Players:GetPlayers()) do drawHeadMarker(player, playerColors[player]) end
	end)
end

local function stopESP()
	if checkThread then task.cancel(checkThread) checkThread = nil end
	if renderConnection then renderConnection:Disconnect() renderConnection = nil end
	clearAllMarkers()
end

g9.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		g9.Text = "ON"
		TweenService:Create(g9, tInfo, {BackgroundColor3 = colorOn}):Play()
		startESP()
	else
		g9.Text = "OFF"
		TweenService:Create(g9, tInfo, {BackgroundColor3 = colorOff}):Play()
		stopESP()
	end
end)

local function startSpeedLock()
	if speedConnection then speedConnection:Disconnect() end
	speedConnection = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum and hum.WalkSpeed ~= 35 then hum.WalkSpeed = 35 end
		end
	end)
end

local function stopSpeedLock()
	if speedConnection then speedConnection:Disconnect() speedConnection = nil end
	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = 16 end
	end
end

g8.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	if speedOn then
		g8.Text = "ON"
		TweenService:Create(g8, tInfo, {BackgroundColor3 = colorOn}):Play()
		startSpeedLock()
	else
		g8.Text = "OFF"
		TweenService:Create(g8, tInfo, {BackgroundColor3 = colorOff}):Play()
		stopSpeedLock()
	end
end)

LocalPlayer.CharacterAdded:Connect(function()
	if speedOn then task.wait(0.5) startSpeedLock() end
end)

Players.PlayerRemoving:Connect(function(player) playerColors[player] = nil end)
