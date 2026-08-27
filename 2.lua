local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera
local activeConnections = {}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2_AntiDesyncEngine"
screenGui.ResetOnSpawn = false
screenGui.Parent = lp:WaitForChild("PlayerGui")

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 300, 0, 40)
statusLabel.Position = UDim2.new(0.5, -150, 0, 20)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "gundropped = false"
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
statusLabel.TextSize = 24
statusLabel.Font = Enum.Font.Code
statusLabel.TextStrokeTransparency = 0.2
statusLabel.Parent = screenGui

local function hasItem(player, itemName)
	if not player then return false end
	local backpack = player:FindFirstChild("Backpack")
	if backpack and backpack:FindFirstChild(itemName) then return true end
	local char = player.Character
	if char and char:FindFirstChild(itemName) then return true end
	return false
end

local function getPlayerData()
	local murderer, sheriff = nil, nil
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= lp then
			if hasItem(p, "Knife") then murderer = p end
			if hasItem(p, "Gun") then sheriff = p end
		end
	end
	return murderer, sheriff
end

local function fixDesyncedModel(player)
	if not player or not player.Character then return nil end
	local root = player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return nil end
	
	local playerData = player:FindFirstChild("PlayerData") or game:GetService("ReplicatedStorage"):FindFirstChild("PlayerData")
	if playerData then
		local livePosition = playerData:FindFirstChild("RealPosition") or playerData:FindFirstChild("Position")
		if livePosition and livePosition:IsA("Vector3Value") then
			if (root.Position - livePosition.Value).Magnitude > 15 then
				root.CFrame = CFrame.new(livePosition.Value)
			end
		end
	end
	return root
end

local function cleanup()
	for _, conn in ipairs(activeConnections) do
		if conn then conn:Disconnect() end
	end
	activeConnections = {}
end

local function initSystem()
	cleanup()
	
	local heartbeatConn = RunService.Heartbeat:Connect(function()
		local gun = workspace:FindFirstChild("GunDrop", true)
		if gun and gun:IsA("BasePart") then
			statusLabel.Text = "gundropped = true"
			statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		else
			statusLabel.Text = "gundropped = false"
			statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		end
		
		local mud, sher = getPlayerData()
		if mud then fixDesyncedModel(mud) end
		if sher then fixDesyncedModel(sher) end
	end)
	
	local renderConn = RunService.RenderStepped:Connect(function()
		local gunTool = lp.Character and lp.Character:FindFirstChild("Gun")
		if not gunTool then return end
		
		local char = lp.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if not hum or hum.Health <= 0 or not root then return end

		local isShiftLock = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
		if isShiftLock then
			local mud, _ = getPlayerData()
			local targetPart = mud and fixDesyncedModel(mud)
			if targetPart then
				local targetPos = targetPart.Position
				camera.CFrame = CFrame.new(camera.CFrame.Position, targetPos)
				root.CFrame = CFrame.new(root.Position, Vector3.new(targetPos.X, root.Position.Y, targetPos.Z))
				gunTool:Activate()
			end
		end
	end)
	
	table.insert(activeConnections, heartbeatConn)
	table.insert(activeConnections, renderConn)
end

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	
	if input.KeyCode == Enum.KeyCode.Z then
		local gun = workspace:FindFirstChild("GunDrop", true)
		if gun and gun:IsA("BasePart") then
			local char = lp.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if root then
				local oldCFrame = root.CFrame
				root.CFrame = gun.CFrame
				task.wait(0.05)
				root.CFrame = oldCFrame
			end
		end
	end

	if input.KeyCode == Enum.KeyCode.Y then
		local _, targetPlayer = getPlayerData()
		local targetPart = targetPlayer and fixDesyncedModel(targetPlayer)
		local myChar = lp.Character
		local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
		
		if targetPart and myRoot then
			local savedCFrame = myRoot.CFrame
			
			local bAV = Instance.new("BodyAngularVelocity")
			bAV.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			bAV.AngularVelocity = Vector3.new(0, 99999, 0)
			bAV.Parent = myRoot
			
			local bV = Instance.new("BodyVelocity")
			bV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			bV.Velocity = Vector3.new(99999, 0, 99999)
			bV.Parent = myRoot
			
			local startTime = tick()
			while tick() - startTime < 2.3 do
				if not targetPlayer or not targetPart.Parent then break end
				
				for _, part in ipairs(myChar:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = false end
				end
				
				myRoot.CFrame = targetPart.CFrame * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(math.random(-5, 5)), 0, math.rad(math.random(-5, 5)))
				task.wait()
			end
			
			bAV:Destroy()
			bV:Destroy()
			
			myRoot.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			myRoot.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			myRoot.CFrame = savedCFrame
			
			for _, part in ipairs(myChar:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = true end
			end
			
			myRoot.Anchored = true
			task.wait(0.4)
			myRoot.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			myRoot.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			myRoot.Anchored = false
		end
	end
end)

lp.CharacterAdded:Connect(function()
	task.wait(0.5)
	initSystem()
end)

initSystem()
