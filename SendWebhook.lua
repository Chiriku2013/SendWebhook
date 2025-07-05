-- Gửi Webhook an toàn
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local totalUsers = 0

local function detectExecutor()
    local ex = "Không xác định"
    if fluxus or isfluxus then ex = "Fluxus (Mobile)"
    elseif syn then ex = "Synapse X (Mobile)"
    elseif KRNL_LOADED then ex = "KRNL (Mobile)"
    elseif getgenv and type(getgenv().isdelta) == "function" and getgenv().isdelta() then ex = "Delta X (Mobile)"
    elseif getgenv and getgenv().CodeXExecutor then ex = "Code X (Mobile)"
    elseif is_arceus_closure or (getrenv and getrenv().isexecutorclosure) then ex = "Arceus X (Mobile)"
    elseif getgenv and getgenv().VolcanicExecutor then ex = "Volcanic (PC)"
    elseif getgenv and getgenv().SolaraExecutor then ex = "Solara (PC)"
    elseif getgenv and getgenv().PotassiumExecutor then ex = "Potassium (PC)"
    elseif getgenv and getgenv().AWPExecutor then ex = "AWP (PC)"
    elseif getgenv and getgenv().FrostWareExecutor then ex = "FrostWare (PC)"
    elseif getgenv and getgenv().VisualExecutor then ex = "Visual (PC)"
    elseif identifyexecutor and pcall(identifyexecutor) then
        local ok, result = pcall(identifyexecutor)
        if ok and result then ex = result end
    elseif getexecutorname and pcall(getexecutorname) then
        local ok, result = pcall(getexecutorname)
        if ok and result then ex = result end
    end
    return ex
end

local function getVietnamTime()
    local t = os.date("*t")
    return string.format("%d/%d/%d %02d:%02d:%02d", t.day, t.month, t.year, t.hour, t.min, t.sec)
end

local function getDiscordTimestamp()
    return os.date("!%Y-%m-%dT%H:%M:%SZ")
end

-- Đã bảo vệ
local function sendUsage()
    totalUsers += 1

    local info = {
        title = "📢 **Script Main-Hub-Tổng Hợp Của Chiriku Roblox ĐZ Real Đã Được Sử Dụng**",
        description = table.concat({
            "👤 Tên người dùng: **" .. player.Name .. "**",
            "🔧 Client Hack: **" .. detectExecutor() .. "**",
            "🕒 Thời gian: **" .. getVietnamTime() .. "**",
            "👥 Tổng người dùng: **" .. tostring(totalUsers) .. "**"
        }, "\n"),
        color = 0x000000,
        footer = { text = "By: Chiriku Roblox ĐZ Real" },
        timestamp = getDiscordTimestamp()
    }

    local j = HttpService:JSONEncode({ embeds = { info } })

    -- 🔐 Mã hóa URL webhook
    local encoded = "aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTM5MDgwOTYzMzE0ODM3MTA3OS9RSGNxbnJSUjgtTW5oUDBHQXlTU0FtbzVaT0VHZFF0VGdzUlhQdTFlV0hXV3loeENVTXBrOEZXNFFxajdlQjdxRE05SWo="
    local url = HttpService:Base64Decode(encoded)

    -- 🛡️ Tránh biến tên dễ bị phát hiện
    local r = http_request or request or syn and syn.request or HttpPost
    if r then
        r({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = j
        })
    end
end

-- 🚀 Gọi hàm
sendUsage()
