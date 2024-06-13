if CLIENT then
    net.Receive("BuildModeChat", function(len)
        local message = net.ReadString()
        chat.AddText(Color(255, 255, 255), '[', Color(131, 249, 255), 'Build', Color(255, 255, 255), '|', Color(255, 120, 120), 'PvP', Color(255, 255, 255), ']: ', message)
    end)
end
