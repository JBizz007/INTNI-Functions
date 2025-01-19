--Save/Load Pos, Num7 to save - Num9 to load.

-- Store the part and the player
local part = nil
local player = game.Players.LocalPlayer

-- Function to create or update the part
local function createOrUpdatePart()
	-- Remove the old part if it exists
	if part then
		part:Destroy()
	end

	-- Create a new part
	part = Instance.new("Part")
	part.Size = Vector3.new(1, 1, 1) -- Adjust size as needed
	part.Transparency = 0.7
	part.CanCollide = false
	part.Anchored = true -- Prevents the part from falling
	part.Parent = workspace

	-- Position the part at the player's character's position (HumanoidRootPart is recommended)
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		part.Position = character.HumanoidRootPart.Position
	else
		warn("Character or HumanoidRootPart not found!")
	end
end

-- Function to teleport the player to the part
local function teleportToPart()
	if part then
		local character = player.Character
		if character and character:FindFirstChild("HumanoidRootPart") then
			-- Teleport the player's character
			character.HumanoidRootPart.CFrame = part.CFrame * CFrame.new(0, 3, 0) -- Offset to avoid getting stuck inside the part
		else
			warn("Character or HumanoidRootPart not found!")
		end
	else
		warn("No saved part location!")
	end
end

-- Get the UserInputService
local UserInputService = game:GetService("UserInputService")

-- Connect input events to functions
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end -- Ignore input if the game is already processing it (e.g., typing in chat)

	if input.KeyCode == Enum.KeyCode.KeypadSeven then
		createOrUpdatePart()
	elseif input.KeyCode == Enum.KeyCode.KeypadNine then
		teleportToPart()
	end
end)
