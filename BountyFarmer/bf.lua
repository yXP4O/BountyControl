-- // made by Arrayed#7445

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat wait(0.01) until workspace.Players:FindFirstChild(game:service"Players".LocalPlayer.Name)

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

local player = game:service"Players".LocalPlayer
local baseCFrame = CFrame.new(207, 38.25, 200014)

task.spawn(function()
    local Part = Instance.new("Part", workspace)
    Part.Name = "Roof"
    Part.Size = Vector3.new(50,0.7,50)
    Part.Transparency = 1
    Part.CFrame = baseCFrame + Vector3.new(0,10,0)
    Part.Anchored = true
end)

local function lowGFX(fpsAmt, gfxMode)
    fpsAmt = fpsAmt or 3
    gfxMode = gfxMode or false
    local fpsFunc = setfpscap or set_fps_cap
    pcall(function() fpsFunc(fpsAmt) end)
    settings().Physics.PhysicsEnvironmentalThrottle = 1
    settings().Rendering.QualityLevel = 'Level01'
    UserSettings():GetService("UserGameSettings").MasterVolume = 0
    if gfxMode == true then
        game:service"RunService":Set3dRenderingEnabled(false)
    end
    for i,v in pairs(game:GetDescendants()) do
        if v:IsA("Part") then
            v.Material = Enum.Material.SmoothPlastic
            if gfxMode == true then
                v.Transparency = 1
            end
        elseif v:IsA("Decal") then
            v:Destroy()
        elseif v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("MeshPart") then
            v.TextureID = 0
            if gfxMode == true then
                v.Transparency = 1
            end
        elseif v.Name == "Terrian" then
            v.WaterReflectace = 1
            v.WaterTransparency = 1
        elseif v:IsA("SpotLight") then
            v.Range = 0
            v.Enabled = false
        elseif v:IsA("WedgePart") then
            if gfxMode == true then
                v.Transparency = 1
            end
        elseif v:IsA("UnionOperation") then
            if gfxMode == true then
                v.Transparency = 1
            end
        end
    end
end

if table.find(getgenv().NewSeperators["stompers"], player.UserId) then
    task.spawn(function()
        lowGFX(1000, false)
    end)

    task.spawn(function()
        while true do
            wait(0.5)
            pcall(function()
                for i,v in pairs(game:service"Players":GetChildren()) do
                    if v.Name ~= game:service"Players".LocalPlayer.Name and v.Character and v.Character.BodyEffects["K.O"].Value == true and v.Character.BodyEffects["Dead"].Value == false then
                        repeat
                            game:service"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.UpperTorso.Position.X,v.Character.UpperTorso.Position.Y+1.1,v.Character.UpperTorso.Position.Z)
                            game:service"ReplicatedStorage".MainEvent:FireServer("Stomp")
                            wait(0.01)
                        until v.Character.BodyEffects["Dead"].Value == true
                    end
                end
            end)

            if game:service"Players".LocalPlayer.leaderstats.Wanted.Value >= getgenv().NewSeperators["bountyGoal"] then
                game:service"Players".LocalPlayer:Kick('goal reached', getgenv().NewSeperators["bountyGoal"])
            end
        end
    end)
elseif table.find(getgenv().NewSeperators["killers"], player.UserId) then
    task.spawn(function()
        lowGFX(getgenv().NewSeperators["fps"], true)
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
    
    task.spawn(function()
        while true do
            wait(0.35)
            pcall(function()
                if not player.Backpack:FindFirstChild("[Bat]") and not player.Character:FindFirstChild("[Bat]") then
                    repeat
                        player.Character.HumanoidRootPart.CFrame = bat.Head.CFrame
                        fireclickdetector(bat:FindFirstChildWhichIsA("ClickDetector"))
                        wait()
                    until player.Backpack:FindFirstChild("[Bat]") or player.Character:FindFirstChild("[Bat]")
                end 
                if player.Backpack:FindFirstChild("[Bat]") then
                    player.Backpack:FindFirstChild("[Bat]").Parent = player.Character
                end
                
                player.Character.HumanoidRootPart.CFrame = baseCFrame
                player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
                player.Character:FindFirstChild("[Bat]"):Activate()
            end)
        end
    end)
else
    task.spawn(function()
        lowGFX(getgenv().NewSeperators["fps"], true)
    end)

    task.spawn(function()
        while true do
            wait(0.35)
            pcall(function()
                if player.Character.BodyEffects:FindFirstChild("K.O").Value == true then
                    pcall(function() player.Character:BreakJoints() end)
                end
                local newPos = baseCFrame + Vector3.new(math.random(-2,2),0,math.random(-2,2))
                player.Character.HumanoidRootPart.CFrame = newPos
            end)
        end
    end)
end
