if SERVER then
    util.AddNetworkString("BuildModeStatus")
    util.AddNetworkString("BuildModeChat")

    local buildModePlayers = {}

    -- Функция для отправки цветного сообщения в чат
    local function SendMessage(player, message)
        net.Start("BuildModeChat")
        net.WriteString(message)
        net.Send(player)
    end

    -- Функция для установки режима строительства
    local function EnterBuildMode(player)
        if not IsValid(player) then return end
        if buildModePlayers[player:SteamID()] then
            SendMessage(player, "Вы уже в режиме строительства.")
            return
        end
        buildModePlayers[player:SteamID()] = true
        player:GodEnable()
        player:SetRenderMode(RENDERMODE_TRANSALPHA)
        player:SetColor(Color(255, 255, 255, 255)) -- делаем игрока более прозрачным
        net.Start("BuildModeStatus")
        net.WriteBool(true)
        net.Send(player)
        SendMessage(player, "Вы в режиме строительства. Вы бессмертны и не можете наносить урон.")
    end

    -- Функция для выхода из режима строительства
    local function EnterPvPMode(player)
        if not IsValid(player) then return end
        if not buildModePlayers[player:SteamID()] then
            SendMessage(player, "Вы не в режиме строительства, переход в режим PvP невозможен.")
            return
        end
        SendMessage(player, "Режим PvP будет активирован через 10 секунд...")
        timer.Simple(10, function()
            if not IsValid(player) then return end
            buildModePlayers[player:SteamID()] = nil
            player:GodDisable()
            player:SetRenderMode(RENDERMODE_NORMAL)
            player:SetColor(Color(255, 255, 255, 255)) -- возвращаем нормальный вид игрока
            net.Start("BuildModeStatus")
            net.WriteBool(false)
            net.Send(player)
            SendMessage(player, "Режим PvP активирован. Теперь вы можете наносить и получать урон.")
        end)
    end

    hook.Add("PlayerSay", "ToggleBuildPvPMode", function(player, text)
        if text == "!build" then
            EnterBuildMode(player)
            return ""
        elseif text == "!pvp" then
            EnterPvPMode(player)
            return ""
        end
    end)

    hook.Add("EntityTakeDamage", "BuildModeDamageControl", function(target, dmginfo)
        if target:IsPlayer() and buildModePlayers[target:SteamID()] then
            dmginfo:SetDamage(0)
            return true
        end

        if dmginfo:GetAttacker():IsPlayer() and buildModePlayers[dmginfo:GetAttacker():SteamID()] then
            dmginfo:SetDamage(0)
            return true
        end
    end)

    hook.Add("PlayerShouldTakeDamage", "PvP_PlayerShouldTakeDamage", function(target, attacker)
        if buildModePlayers[target:SteamID()] or (attacker:IsPlayer() and buildModePlayers[attacker:SteamID()]) then
            return false
        end

        return true
    end)
end
