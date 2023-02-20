if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not game.PlaceId == 2788229376 then return end

repeat wait(0.01) until workspace.Players:FindFirstChild(game:service"Players".LocalPlayer.Name)

local player = game:service"Players".LocalPlayer

local remotes = {
    "CHECKER_1",
    "CHECKER_2",
    "TeleportDetect",
    "OneMoreTime",
    "BreathingHAMON",
    "VirusCough"
}

local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    local args = {...}
    local method = getnamecallmethod()
    if (method == "FireServer" and args[1].Name == "MainEvent" and table.find(remotes, args[2])) then
        return
    end
    return __namecall(table.unpack(args))
end)

game:service"Players".LocalPlayer.Idled:connect(function()
    game:service"VirtualUser":Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    game:service"VirtualUser":Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local Part = Instance.new("Part", workspace)
Part.Size = Vector3.new(100,1,100)
Part.Transparency = 1
Part.CFrame = CFrame.new(1000,10000,1000)
Part.Anchored = true

if table.find(getgenv().Seperators["stompers"], player.UserId) then
    local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/theracisthub/libs/main/ocinhot"))()
    local main = lib:Create("AutoStomper")
    local txt = main:NewLabel("Rate: ???")

    game:service"Players".LocalPlayer.leaderstats.Wanted.Changed:Connect(function()
        if game:service"Players".LocalPlayer.leaderstats.Wanted.Value >= 2000000 then
            game:service"Players".LocalPlayer:Kick("overuled")
        end
    end)

    local functionName = "runner3000"

    game:service"RunService":BindToRenderStep(functionName, 1, function()
        for i,v in pairs(game:service"Players":GetChildren()) do
            if v.Name ~= game:service"Players".LocalPlayer.Name and v.Character and v.Character.BodyEffects["K.O"].Value == true and v.Character.BodyEffects["Dead"].Value == false then
                game:service"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.UpperTorso.Position.X,v.Character.UpperTorso.Position.Y+1.3,v.Character.UpperTorso.Position.Z)
                game:service"ReplicatedStorage".MainEvent:FireServer("Stomp")
            end
        end
    end)

    local function minifyNum(num)
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

    local firstWanted = player.leaderstats.Wanted.Value
    task.spawn(function()
        while true do wait(1)
            local cal = math.floor((player.leaderstats.Wanted.Value - firstWanted) * 60)
            firstWanted = player.leaderstats.Wanted.Value
            txt:Update("rate: "..tostring(minifyNum(cal)).." / min")
        end
    end)

    task.spawn(function()
        settings().Physics.PhysicsEnvironmentalThrottle = 1
        settings().Rendering.QualityLevel = 'Level01'
        UserSettings():GetService("UserGameSettings").MasterVolume = 0
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("Part") then
                v.Material = Enum.Material.SmoothPlastic
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
    end)
elseif table.find(getgenv().Seperators["killers"], player.UserId) then    
    game:GetService("RunService"):Set3dRenderingEnabled(false)
    UserSettings().GameSettings.MasterVolume = 0
    pcall(function() setfpscap(5) end)
    
    task.spawn(function()
        settings().Physics.PhysicsEnvironmentalThrottle = 1
        settings().Rendering.QualityLevel = 'Level01'
        UserSettings():GetService("UserGameSettings").MasterVolume = 0
        game:service"RunService":Set3dRenderingEnabled(false)
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("Part") then
                v.Material = Enum.Material.SmoothPlastic
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
    end)

    local function findTool(baseName)
        baseName = tostring(baseName):lower()
        for i,v in pairs(workspace.Ignored.Shop:GetChildren()) do
            if v.Name:lower():sub(1,baseName:len()) == baseName:sub(1,baseName:len()) then
                return v
            end
        end
        return nil
    end
    local bat = findTool("[Bat]")
    
    local player = game:service"Players".LocalPlayer
    task.spawn(function()
        while true do
            wait(0.35)
            pcall(function()
                if not player.Backpack:FindFirstChild("[Bat]") and player.Character:FindFirstChild("[Bat]") then
                    repeat
                        player.Character.HumanoidRootPart.CFrame = bat.Head.CFrame
                        fireclickdetector(bat:FindFirstChildWhichIsA("ClickDetector"))
                        wait()
                    until player.Backpack:FindFirstChild("[Bat]") or player.Character:FindFirstChild("[Bat]")
                end 
                if player.Backpack:FindFirstChild("[Bat]") then
                    player.Backpack:FindFirstChild("[Bat]").Parent = player.Character
                end
                    
                player.Character.HumanoidRootPart.CFrame = Part.CFrame + Vector3.new(0,1,0)
                player.Character:FindFirstChild("[Bat]"):Activate()
            end)
        end
    end)
else    
    game:GetService("RunService"):Set3dRenderingEnabled(false)
    UserSettings().GameSettings.MasterVolume = 0
    pcall(function() setfpscap(5) end)

    task.spawn(function()
        settings().Physics.PhysicsEnvironmentalThrottle = 1
        settings().Rendering.QualityLevel = 'Level01'
        UserSettings():GetService("UserGameSettings").MasterVolume = 0
        game:service"RunService":Set3dRenderingEnabled(false)
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("Part") then
                v.Material = Enum.Material.SmoothPlastic
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
    end)   

    task.spawn(function()
        while true do
            wait(0.33)
            pcall(function()
                local newPos = Part.CFrame + Vector3.new(math.random(-2,2),0.9,math.random(-2,2))
                player.Character.HumanoidRootPart.CFrame = newPos
            end)
        end
    end)
end
