local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")

local player = Players.LocalPlayer
local totalUsers = 0

-- Detect executor
local function detectExecutor()
    if identifyexecutor then
        return identifyexecutor()
    elseif getexecutorname then
        return getexecutorname()
    end
    return "Unknown"
end

-- Detect device
local function detectDevice()
    return UserInputService.TouchEnabled and "Mobile" or "PC"
end

-- Local time with AM/PM and region
local function getLocalTimeString()
    local date = os.date("*t")
    local hour = date.hour % 24
    local ampm = hour < 12 and "AM" or "PM"
    local formattedTime = string.format("%02i:%02i:%02i %s", ((hour - 1) % 12) + 1, date.min, date.sec, ampm)
    local formattedDate = string.format("%02d/%02d/%04d", date.day, date.month, date.year)

    local regionCode = "Unknown"
    pcall(function()
        regionCode = LocalizationService:GetCountryRegionForPlayerAsync(player)
    end)

    return formattedDate .. " - " .. formattedTime .. " [ " .. regionCode .. " ]"
end

-- Get Discord UTC timestamp
local function getDiscordTimestamp()
    return os.date("!%Y-%m-%dT%H:%M:%SZ")
end

-- Send Webhook
local function sendUsage()
    totalUsers += 1

    local placeId = tostring(game.PlaceId)
    local gameName = "Unknown"
    pcall(function()
        gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)

    local jobId = game.JobId
    local rejoinScript = string.format("game:GetService('TeleportService'):TeleportToPlaceInstance(%s, '%s')", placeId, jobId)
    local device = detectDevice()
    local deviceIcon = device == "Mobile" and "📱" or "💻"

    local embedFields = {
        { name = "👤 Username: **" .. player.Name .. "**", value = " ", inline = false },
        { name = deviceIcon .. " Device: **" .. device .. "**", value = " ", inline = false },
        { name = "🔧 Executor: **" .. detectExecutor() .. "**", value = " ", inline = false },
        { name = "🕒 Local Time: **" .. getLocalTimeString() .. "**", value = " ", inline = false },
        { name = "📌 Place ID: **" .. placeId .. "** (" .. gameName .. ")", value = " ", inline = false },
        { name = "📥 Script Hop (Mobile Copy)", value = rejoinScript, inline = false },
        { name = "📥 Script Hop (PC Copy)", value = "```\n" .. rejoinScript .. "\n```", inline = false },
        { name = "👥 Total Users: **" .. tostring(totalUsers) .. "**", value = " ", inline = false }
    }

    local embed = {
        title = "📢 **Script Main–Hub–Kaitun–Tổng Hợp Của Chiriku Roblox ĐZ Real Đã Được Sử Dụng**",
        fields = embedFields,
        color = 0x000000,
        footer = { text = "By: Chiriku Roblox ĐZ Real" },
        timestamp = getDiscordTimestamp()
    }

    local json = HttpService:JSONEncode({ embeds = { embed } })

    local raw = "\104\116\116\112\115\58\47\47\100\105\115\99\111\114\100\46\99\111\109\47\97\112\105\47\119\101\98\104\111\111\107\115\47\49\51\57\48\56\48\57\54\51\51\49\52\56\51\55\49\48\55\57\47\81\72\99\113\110\82\82\56\45\77\110\104\80\48\71\65\121\83\83\65\109\111\53\90\79\69\71\100\81\116\84\103\115\82\88\80\117\49\101\87\72\87\87\121\104\112\67\85\77\112\107\56\70\87\52\81\113\106\55\101\66\55\113\68\77\57\73\106"

    local r = http_request or request or (syn and syn.request) or HttpPost
    if r then
        r({
            Url = raw,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = json
        })
    end
end

sendUsage()
