-- Функция для создания префикса
local function createPrefix(ply)
    local name = ply:Nick() -- Имя игрока
    local rank = ply:GetUserGroup() -- Ранг игрока
    local teamIndex = ply:Team() -- Индекс команды игрока
    local teamName = team.GetName(teamIndex) -- Название команды игрока
    local alpha = 255 -- Прозрачность цвета
    local namecolor = Color(255, 255, 255, alpha) -- Цвет имени

    -- Вы можете изменить цвета в зависимости от ранга или команды
    if rank == "admin" then
        namecolor = Color(161, 255, 0, alpha) -- Красный для администраторов
    elseif rank == "moderator" then
    	namecolor = Color(131, 249, 255, alpha)
    elseif rank == "superadmin" then
        namecolor = Color(144, 255, 164, alpha) -- Синий для полиции
     elseif rank == "user" then
        namecolor = Color(89, 255, 205, alpha) -- Синий для полиции
    elseif rank == "user1" then
        namecolor = Color(84, 255, 104, alpha) -- Синий для полиции
    elseif rank == "user2" then
        namecolor = Color(104, 177, 255, alpha) -- Синий для полиции
    elseif rank == "user3" then
        namecolor = Color(223, 130, 255, alpha) -- Синий для полиции
    elseif rank == "user4" then
        namecolor = Color(225, 127, 255, alpha) -- Синий для полиции
    elseif rank == "user5" then
        namecolor = Color(255, 144, 76, alpha) -- Синий для полиции
    end

    -- Создание и возврат строки префикса
    return  "[" .. teamName .. "] " , namecolor
end

-- Пример использования функции
hook.Add("OnPlayerChat", "AddPrefix", function(ply, text, teamChat, isDead)
    local prefix, color = createPrefix(ply)
    chat.AddText(color, prefix, Color(255, 255, 255), ply:Nick(), ": " .. text)
    return true
end)
