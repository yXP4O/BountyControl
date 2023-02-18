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

return functions
