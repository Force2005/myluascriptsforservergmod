-- Таблица с рангами и необходимым временем в часах
local ranks = {
    { hours = 1, rank = "user1" },
    { hours = 15, rank = "user2" },
    { hours = 25, rank = "user3" },
    { hours = 100, rank = "user4" },
    { hours = 300, rank = "user5" }
}

-- Функция для проверки, не является ли игрок superadmin, admin или moderator
local function isEligibleForRank(ply)
    local userGroup = ply:GetUserGroup()
    return not (userGroup == "superadmin" or userGroup == "admin" or userGroup == "moderator")
end

-- Функция для обновления ранга игрока
local function updatePlayerRank(ply)
    if not isEligibleForRank(ply) then return end -- Проверяем, имеет ли игрок право на получение ранга

    local playtime = ply:GetUTimeTotalTime() / 3600 -- Получаем время в часах
    local newRank = nil
    for _, rankInfo in ipairs(ranks) do
        if playtime >= rankInfo.hours then
            newRank = rankInfo.rank
        end
    end

    if newRank and ply:GetUserGroup() ~= newRank then
        ply:SetUserGroup(newRank)
        ply:ChatPrint("Поздравляем! Ваш новый ранг: " .. newRank)
        -- Проигрываем звук при получении нового ранга
        if CLIENT then
            surface.PlaySound("garrysmod/save_load3.wav")
        end
    end
end

-- Периодическое обновление рангов при входе игрока на сервер
hook.Add("PlayerInitialSpawn", "CheckRankOnSpawn", function(ply)
    timer.Create(ply:SteamID().."RankTimer", 1, 0, function()
        if IsValid(ply) then
            updatePlayerRank(ply)
        end
    end)
end)

-- Удаление таймера при выходе игрока
hook.Add("PlayerDisconnected", "RemoveRankTimer", function(ply)
    timer.Remove(ply:SteamID().."RankTimer")
end)
