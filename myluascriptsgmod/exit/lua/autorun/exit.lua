hook.Add("PlayerDisconnected", "AnnouncePlayerLeft", function(ply)
    local name = ply:GetName() -- Получаем имя игрока
    PrintMessage(HUD_PRINTTALK,"Игрок ".. name .. " вышел с сервера") -- Отправляем сообщение в чат
end)
