-- // made by Arrayed#7445

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 2788229376 then return end

repeat wait(0.01) until workspace.Players:FindFirstChild(game:service"Players".LocalPlayer.Name)

local player = game:service"Players".LocalPlayer
local isKiller = player.UserId == getgenv().MajorSettings["killer"]
local isStomper = player.UserId == getgenv().MajorSettings["stomper"]
local isBot = table.find(getgenv().MajorSettings["alts"], player.UserId) 

local functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/yXP4O/BountyControl/main/Others/publicVerModule.lua"))()

game:service"Players".LocalPlayer.Idled:connect(function()
	game:service"VirtualUser":Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:service"VirtualUser":Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

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

game:service"ReplicatedStorage".DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(messageData) 
    local user = game:service"Players":GetPlayerByUserId(game.Players:GetUserIdFromNameAsync(messageData.FromSpeaker))
    local msg = messageData.Message
    if user.UserId == getgenv().MajorSettings["stomper"] and user.UserId ~= player.UserId then
        msg = msg:split(" ")
        if msg[1]:lower() == ".j" then
            local trailServer = msg[2]
            local rawServer = functions.getRawServerData()
            for i,v in pairs(rawServer) do
                if tostring(v):find(tostring(trailServer)) then 
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v, player)
                end
            end
        end
    end
end)

if isKiller then
    local pos = CFrame.new(-771, 44, -862)
    local tool = "[Bat]"
    local batTool = functions.findTool(tool)
    task.spawn(function()
        functions.gfx(getgenv().MajorSettings["fps"], true)
        while true do
            wait(1)
            pcall(function()
                local bat = player.Character:FindFirstChild(tool) or player.Backpack:FindFirstChild(tool)
                if not bat and player.DataFolder.Currency.Value >= 300 then
                    if batTool then
                        repeat
                            player.Character.HumanoidRootPart.CFrame = batTool.Head.CFrame * CFrame.new(0,1.2,0)
                            fireclickdetector(batTool:FindFirstChildWhichIsA("ClickDetector"))
                            wait()
                        until player.Character:FindFirstChild(tool) or player.Backpack:FindFirstChild(tool)
                    end
                end

                if player.Backpack:FindFirstChild(tool) then
                    player.Backpack:FindFirstChild(tool).Parent = player.Character
                end
                player.Character.HumanoidRootPart.CFrame = pos
                player.Character:FindFirstChild(tool):Activate()
            end)
        end
    end)
elseif isStomper then
    -- security
    local hasSentReport = false
    local firstWanted = player.leaderstats.Wanted.Value
    local startWanted = player.leaderstats.Wanted.Value
    local stompingEnable = true
    local secureEnable = false
    local flagged = {}
    local firstTick = tick() + getgenv().MajorSettings["configs"]["autoServerHopTime"]
    task.spawn(function() -- calculates rate
        local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/theracisthub/libs/main/ocinhot"))()
        local main = lib:Create("AutoStomper")
        main:NewToggle("Enable Autostomp","eat",true,function(bool)
            stompingEnable = bool
        end)
        local targetStomp = main:NewLabel("Stomping: not working.")
        local rater = main:NewLabel("Rate: ?")
        while true do
            wait(15)
            pcall(function()
                local newAmt = math.floor((player.leaderstats.Wanted.Value - startWanted) * 4)
                startWanted = player.leaderstats.Wanted.Value
                rater:Update("Rate: "..tostring(functions.formatNum(newAmt)).." / minute")
            end)
        end
    end)

    game:service"RunService".Stepped:Connect(function()
        if stompingEnable then
            pcall(function()
                for i,v in pairs(game:service"Players":GetChildren()) do
                    if v.Character:FindFirstChild("BodyEffects"):FindFirstChild("K.O").Value == true and v.Character:FindFirstChild("BodyEffects"):FindFirstChild("Dead").Value == false and v.Name ~= player.Name and table.find(getgenv().MajorSettings["alts"], v.UserId) then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.UpperTorso.Position) + Vector3.new(0,1.9,0)
                        game:service"ReplicatedStorage".MainEvent:FireServer("Stomp")
                    end
                end
            end)
        end
    end)
    task.spawn(function()
        functions.gfx(60, false)
        while true do
            wait(0.01)
            print(math.floor(firstTick - tick()), secureEnable, stompingEnable)
            pcall(function()
                if firstTick < tick() then
                    firstTick = tick() + getgenv().MajorSettings["configs"]["autoServerHopTime"]
                    stompingEnable = false
                    local newServer = functions.fetchJob()
                    if not hasSentReport then
                        hasSentReport = true
                        pcall(function()
                            local newPayload = game:service"HttpService"JSONEncode({
                                content = "",
                                embeds = {
                                    {
                                        title = "bounty farmer report",
                                        description = "**Hopped: Yes**\n**Bounty gain:** "..tostring(functions.formatNum(math.floor(player.leaderstats.Wanted.Value - firstWanted))),
                                        type = "rich",
                                        color = tonumber(0x09CF6A),
                                        timestamp = DateTime.now():ToIsoDate()
                                    }
                                }
                            })
                            functions.sendWebhook(getgenv().MajorSettings["config"]["webhookUrl"]. newPayload)
                        end)
                    end
                    local determineServerHopper = MajorSettings["config"]["inbuiltServerHopper"] or true
                    if determineServerHopper == true then
                        print("server", newServer)
                        if newServer then
                            functions.sendMsg(".j "..tostring(newServer:split("-")[2]))
                            stompingEnable = false
                            secureEnable = false
                            wait(0.3)
                            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, newServer, player)
                        end
                    end
                end
                if secureEnable and stompingEnable == false then
                    local PartName = "SAFESPOT_HIDEOUT"
                    if workspace:FindFirstChild(PartName) then
                        workspace:FindFirstChild(PartName):Destroy()
                    end
                    local Part = Instance.new("Part", workspace)
                    Part.Name = PartName
                    Part.Size = Vector3.new(100,2,100)
                    Part.Transparency = 1
                    Part.CFrame = CFrame.new(math.random(-10000,10000), math.random(5000,9000), math.random(-10000,10000))
                    Part.Anchored = true
                    player.Character.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0,1.2,0)
                end
                if not secureEnable then
                    for i,v in pairs(game:service"Players":GetChildren()) do
                        if v.Character and v.Character:FindFirstChild("Humanoid") and player.Name ~= v.Name then
                            if not table.find(getgenv().MajorSettings["alts"], v.UserId) and (v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                                if not flagged[v.UserId] then
                                    flagged[v.UserId] = true
                                    stompingEnable = false
                                    secureEnable = true
                                    task.delay(getgenv().MajorSettings["configs"]["securityTimeOut"], function()
                                        secureEnable = false
                                        stompingEnable = true
                                        flagged[v.UserId] = nil
                                    end)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
elseif isBot then
    task.spawn(function()
        functions.gfx(getgenv().MajorSettings["fps"], true)
        while true do
            wait(0.01)
            pcall(function()
                for i,v in pairs(workspace.Players:GetChildren()) do
                    if v.Name ~= player.Name and game:service"Players":FindFirstChild(v.Name).UserId ~= getgenv().MajorSettings["killer"] then
                        v:Destroy()
                    end
                end
                local newPos = functions.makeNewPos(CFrame.new(-771, 44, -862))
                player.Character.HumanoidRootPart.CFrame = newPos
            end)
        end
    end)
end
