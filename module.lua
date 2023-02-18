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

    local c = 0
    for i,v in pairs(alt_list) do
        c = c + 1
        if tostring(v) == tostring(alt_id) then
            return lib[c]
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
        Part.Size = Vector3.new(120,1,120)
        Part.Transparency = 1
        Part.CFrame = CFrame.new(math.random(-5000,5000), math.random(1000,4000), math.random(-5000,5000))
        Part.Anchored = true
    end

    plr.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild(homeName).CFrame * CFrame.new(0,2,0)
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

functions.kick = function(plr, host) -- server kick a buyer / hacker anyone.
    if host then
        local MainEvent = game:service"ReplicatedStorage".MainEvent
        MainEvent:FireServer("VIP_CMD","Kick",game:service"Players"[plr])
    else
        game:service"ReplicatedStorage".DefaultChatSystemChatEvents.SayMessageRequest:FireServer("kick "..tostring(plr:sub(1,4)), 'All')
    end
end

functions.getPlayer = function(arg) -- fetches the player instance
    for i,v in pairs(game:service"Players":GetChildren()) do
        if v.Name:lower():sub(1,arg:len()) == arg:lower():sub(1,arg:len()) then
            return v
        end
    end
    return nil
end

functions.crashHelper = function() -- crash
    loadstring(game:HttpGet("https://raw.githubusercontent.com/yXP4O/BountyControl/main/crash.lua"))()
end

functions.minifyNum = function(num) -- fancy number converter
    num = tostring(num)
    if num:len() <= 3 then
        return num
    elseif num:len() == 4 then
        return num:sub(1,1).."."..num:sub(2,2).."K"
    elseif num:len() == 5 then
        return num:sub(1,2).."."..num:sub(3,4).."K"
    elseif num:len() == 6 then
        return num:sub(1,3).."."..num:sub(4,5).."K"
    elseif num:len() == 7 then
        return num:sub(1,1).."."..num:sub(2,3).."M"
    elseif num:len() == 8 then
        return num:sub(1,2).."."..num:sub(3,4).."M"
    elseif num:len() == 9 then
        return num:sub(1,3).."."..num:sub(4,5).."M"
    elseif num:len() == 10 then
        return num:sub(1,1).."."..num:sub(2,3).."B"
    end

    return 'error'
end

functions.requestPos = function(pose)
    local circle = {
        "4.5,0,0","0,0,4.5","-4.5,0,0","0,0,-4.5","3,0,3",
        "-3,0,3","-3,0,-3","3,0,-3","6.5,0,0","5,0,3",
        "3.5,0,5","0,0,6.5","-5,0,3","-3.5,0,5","-6.5,0,0",
        "-5,0,-3","-3.5,0,-5","0,0,-6.5","5,0,-3","3.5,0,-5",
        "4.5,7,0","0,7,4.5","-4.5,7,0","0,7,-4.5","3,7,3",
        "-3,7,3","-3,7,-3","3,7,-3","6.5,7,0","5,7,3",
        "3.5,7,5","0,7,6.5","-5,7,3","-3.5,7,5","-6.5,7,0",
        "-5,7,-3","-3.5,7,-5","0,7,-6.5","5,7,-3","3.5,7,-5"
    }
    return circle[pose]
end

return functions
