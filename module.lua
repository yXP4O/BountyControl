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

functions.lowGFX = function(fps, host) -- low gfx / fps booster
    host = host or false
    local fps_capper = setfpscap or set_fps_cap

    pcall(function() fps_capper(fps) end)
    settings().Physics.PhysicsEnvironmentalThrottle = 1
    settings().Rendering.QualityLevel = 'Level01'
    UserSettings():GetService("UserGameSettings").MasterVolume = 0
    game:service"RunService":Set3dRenderingEnabled(false)
    for i,v in pairs(game:GetDescendants()) do
        if v:IsA("Part") then
            v.Material = Enum.Material.Pavement
            if host then
                v.Transparency = 1
            end
        elseif v:IsA("Decal") then
            v:Destroy()
        elseif v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("MeshPart") then
            v.TextureID = 0
            if host then
                v.Transparency = 1
            end
        elseif v.Name == "Terrian" then
            v.WaterReflectace = 1
            v.WaterTransparency = 1
        elseif v:IsA("SpotLight") then
            v.Range = 0
            v.Enabled = false
        elseif v:IsA("WedgePart") then
            if host then
                v.Transparency = 1
            end
        elseif v:IsA("UnionOperation") then
            if host then
                v.Transparency = 1
            end
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

functions.sarchTool = function(baseName)
    baseName = tostring(baseName):lower()
    for i,v in pairs(workspace.Ignored.Shop:GetChildren()) do
        if v.Name:lower():sub(1,baseName:len()) == baseName:sub(1,baseName:len()) then
            return v
        end
    end
    return nil
end

functions.removeTools = function()
    for i,v in pairs(game:service"Players".LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            v.Parent = game:service"Players".LocalPlayer.Backpack
        end
    end
end

functions.removeCuffs = function()
    local player = game:service"Players".LocalPlayer
    local keys = functions.sarchTool("[Key]")
    functions.removeTools()

    if player.Character and keys then
        if player.Character:FindFirstChild("BodyEffects"):FindFirstChild("Cuff").Value == true and player.DataFolder.Currency.Value >= 200 then
            if not player.Character:FindFirstChild("[Key]") and not player.Backpack:FindFirstChild("[Key]") then
                repeat
                    player.Character.HumanoidRootPart.CFrame = keys.Head.CFrame * CFrame.new(0,1.3,0)
                    fireclickdetector(keys:FindFirstChildWhichIsA("ClickDetector"))
                    wait(0.01)
                until player.Character:FindFirstChild("[Key]") or player.Backpack:FindFirstChild("[Key]")
            
                if player.Backpack:FindFirstChild("[Key]") then
                    player.Backpack:FindFirstChild("[Key]").Parent = player.Character
                end
                player.Character:FindFirstChild("[Key]"):Activate()
                functions.tpHome()
            end
        end
    end
end

functions.calculateTimeToCrash = function(totalAccs, goal)
    goal = goal or 1500

    local intialTime = ((math.floor(math.floor(goal / 3)) / totalAccs) * 7)

    local hours = math.floor(intialTime/3600)
    local minutes = math.floor(((intialTime)-(hours*3600))/60)
    local seconds = math.floor(intialTime-((hours*3600)+(minutes*60)))

    return tostring(hours).."h "..tostring(minutes).."m "..tostring(seconds).."s"
end

return functions
