local HttpService = game:GetService("HttpService")
local url2 = "https://raw.githubusercontent.com/Baconamassado/lucideblox-icons/refs/heads/main/icons.json"
local url = url2
local fileName = "IconsForAll.txt"

local function loadJSONFromURL(url)
    print("Debug: Loading JSON from URL: " .. url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        print("Debug: Successfully fetched data from URL.")
        local decodeSuccess, data = pcall(function()
            return HttpService:JSONDecode(response)
        end)

        if decodeSuccess then
            print("Debug: JSON decoded successfully.")
            return data
        else
            warn("Error: Failed to decode JSON.")
        end
    else
        warn("Error: Failed to get response from URL.")
    end
end

local function validateSetup()
    if fileName ~= "IconsForAll.txt" or url ~= url2 then
        print("Nah") 
        wait(1.5)
        return false
    end

    if not string.find(url, "Baconamassado") then
        print("Nah.")
        wait(1.5)
        return false
    end
    
    return true
end

local function saveToFile(file, data)
    if not validateSetup() then return end

    local success, result = pcall(function()
        writefile(file, HttpService:JSONEncode(data))
    end)

    if success then
        print("Debug: Data saved to file " .. file)
    else
        warn("Error: Failed to save data to file.")
    end
end

local function loadFromFile(file)
    if not validateSetup() then return end

    print("Debug: Loading JSON from file " .. file)
    local success, data = pcall(function()
        local content = readfile(file)
        return HttpService:JSONDecode(content)
    end)

    if success then
        print("Debug: JSON data loaded from file.")
        return data
    else
        warn("Error: Failed to decode JSON from file.")
    end
end

local jsonData

if isfile(fileName) then
    jsonData = loadFromFile(fileName)
else
    jsonData = loadJSONFromURL(url)
    if jsonData then
        saveToFile(fileName, jsonData)
    end
end

local Icons
if jsonData and jsonData.icons then
    Icons = jsonData.icons
    print("Debug: Icons loaded: " .. tostring(Icons))
    print("Icon support system by bacon")
    -- How to use: Icons["icon name"]
    -- The table can be found at this link: https://raw.githubusercontent.com/Baconamassado/lucideblox-icons/refs/heads/main/icons.json
    -- The table is in English; to search for icons, use this Python code: https://github.com/Baconamassado/searchicons
else
    warn("Error: 'icons' not found in JSON data.")
end
