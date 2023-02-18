local functions = {}

functions.splitString = function(b) -- turns a string into a dict / table
    b = tostring(b)

    local c = {}

    for i=1,b:len() do
        table.insert(c, b:sub(i,i))
    end

    return c
end

functions.checkPlayer = function(arg) -- checks if a player exists in the game
    for i,v in pairs(game:service"Players":GetChildren()) do
        if type(arg) == "number" then
            if v.UserId == arg then
                return v
            end
        elseif type(arg) == "string" then
            if v.Name:lower(arg:lower()) then
                return v
            end
        end
    end
    return nil
end

functions.fetchMyId = function(alt_list, alt_id) -- gets the alt / host indentification id
    local lib = {
        "a","b","c","d","e","f","g","h","i","j",
        "k","l","m","n","o","p","q","r","s","t",
        "u","v","w","x","y","z","A","B","C","D",
        "E","F","G","H","I","J","K","L","M","N"
    }

    for i,v in pairs(alt_list) do
        if v == game:service"Players".LocalPlayer.UserId then
            return lib[i]
        end 
    end
    return nil
end

functions.say = function(msg) -- sends a chat message / command
    game:service"ReplicatedStorage".DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, 'All')
end

functions.resetChar = function() -- force resets your character
    for i,v in pairs(game:service"Players".LocalPlayer.Character:GetChildren()) do
        if v:IsA("MeshPart") or v:IsA("BasePart") then
            v:Destroy()
        end
    end
end

functions.lowGFX = function(fps) -- low gfx / fps booster
    local fps_capper = setfpscap or set_fps_cap

    pcall(function() fps_capper(fps) end)
    settings().Physics.PhysicsEnvironmentalThrottle = 1
    settings().Rendering.QualityLevel = 'Level01'
    UserSettings():GetService("UserGameSettings").MasterVolume = 0
    for i,v in pairs(game:GetDescendants()) do
        if v:IsA("Part") then
            v.Material = Enum.Material.Pavement
            v.Transparency = 1
        elseif v:IsA("Decal") then
            v:Destroy()
        elseif v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("MeshPart") then
            v.TextureID = 0
            v.Transparency = 1
        elseif v.Name == "Terrian" then
            v.WaterReflectace = 1
            v.WaterTransparency = 1
        elseif v:IsA("SpotLight") then
            v.Range = 0
            v.Enabled = false
        elseif v:IsA("WedgePart") then
            v.Transparency = 1
        elseif v:IsA("UnionOperation") then
            v.Transparency = 1
        end
    end
end

functions.tpHome = function() -- teleports to a safe place
    local plr = game:service"Players".LocalPlayer
    local homeName = "home_"..tostring(plr.Name)

    if not workspace:FindFirstChild(homeName) then
        local Part = Instance.new("Part", workspace)
        Part.Name = homeName
        Part.Size = Vector3.new(20,1,20)
        Part.Transparency = 1
        Part.CFrame = CFrame.new(math.random(-2000,2000), math.random(500,2000), math.random(-2000,2000))
        Part.Anchored = true
    end

    plr.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild(homeName)
end

functions.blockScreen = function() -- blacks out screen
    local Holder = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")

    Holder.Name = "Holder"
    Holder.Parent = game:service"CoreGui"
    Holder.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = Holder
    Frame.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    Frame.BorderColor3 = Color3.fromRGB(13, 13, 13)
    Frame.BorderSizePixel = 100
    Frame.Size = UDim2.new(1, 0, 1, 0)

    TextLabel.Parent = Holder
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.441055715, 0, 0.461656451, 0)
    TextLabel.Size = UDim2.new(0, 200, 0, 50)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 30.000
    TextLabel.Text = game:service"Players".LocalPlayer.Name
end

functions.formatNum = function(c) -- formats the number
    return tostring(c):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", ""):gsub(",",".")
end

functions.kick = function(plr) -- server kick a buyer / hacker anyone.
    local MainEvent = game:service"ReplicatedStorage".MainEvent
    MainEvent:FireServer("VIP_CMD","Kick",game:service"Players"[plr])
end

return functions
