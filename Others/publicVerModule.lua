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

return functions
