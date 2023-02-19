local functions = {}

functions.findTool = function(baseName)
    baseName = tostring(baseName):lower()
    for i,v in pairs(workspace.Ignored.Shop:GetChildren()) do
        if v.Name:lower():sub(1,baseName:len()) == baseName:sub(1,baseName:len()) then
            return v
        end
    end
    return nil
end

functions.fetchJob = function()
    local url = "https://games.roblox.com/v1/games/2788229376/servers/Public?sortOrder=Asc&limit=100"
    local http = game:service"HttpService"
    local req = game:HttpGet(url)

    local job = ""
    local lowest = 41
    local lowestPing = 100000
    for i,v in pairs(http:JSONDecode(req)) do
        if type(v) == "table" then
            for c,n in pairs(v) do
                if lowest > n["playing"] and lowestPing > n["ping"] then
                    lowest = n["playing"]
                    job = n["id"]
                    lowestPing = n["ping"]
                end
            end
        end
    end
    return job
end

functions.getRawServerData = function()
    local url = "https://games.roblox.com/v1/games/2788229376/servers/Public?sortOrder=Asc&limit=100"
    local http = game:service"HttpService"
    local req = game:HttpGet(url)

    local result = {}
    for i,v in pairs(http:JSONDecode(req)) do
        if type(v) == "table" then
            for c,n in pairs(v) do
                table.insert(result, n["id"])
            end
        end
    end
    return result
end

functions.sendMsg = function(msg)
    msg = msg or "hi"
    game:service"ReplicatedStorage".DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, 'All')
end

functions.makeNewPos = function(mainPos)
    return mainPos + Vector3.new(math.random(-2,2),0,math.random(-2,2))
end

functions.gfx = function(fpsAmt, gfxMode)
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
            v.Material = Enum.Material.Pavement
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

return functions
