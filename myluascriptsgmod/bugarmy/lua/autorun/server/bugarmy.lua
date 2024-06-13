AddCSLuaFile()

-- Создание консольных переменных
CreateConVar("fp_enabled", 1, FCVAR_ARCHIVE, "Enables the use of Bugbait to control antlions' behavior.")
CreateConVar("fp_playerenemy", 1, FCVAR_ARCHIVE, "If enabled, other players on the server will automatically be treated by antlions as enemies of whoever holds Bugbait instead of as their friends.")
CreateConVar("fp_guards", 0, FCVAR_ARCHIVE, "If enabled, Antlion Guards and Guardians can be controlled with Bugbait.")

-- Функция для вызова муравьиных львов к игроку при использовании альтернативной атаки weapon_bugbait
local function CallAntlionsToPlayer(player, radius)
    local antlions = ents.FindByClass("npc_antlion")
    table.Add(antlions, ents.FindByClass("npc_antlion_worker"))
    if GetConVar("fp_guards"):GetBool() then
        table.Add(antlions, ents.FindByClass("npc_antlionguard"))
    end

    for _, antlion in ipairs(antlions) do
        if antlion:GetPos():Distance(player:GetPos()) <= radius then
            antlion:SetTarget(player)
            antlion:SetSchedule(SCHED_TARGET_CHASE)
        end
    end
end

-- Функция для воспроизведения звука альтернативной атаки
local function PlayAltAttackSound(player)
    player:EmitSound("sound/bugbait/bugbait_squeeze1.wav") -- Путь к звуковому файлу
end

-- Функция для обновления отношений муравьиных львов
local function UpdateAntlionRelationships()
    local t = ents.FindByClass("npc_antlion")
    table.Add(t, ents.FindByClass("npc_antlion_worker"))
    if GetConVar("fp_guards"):GetBool() then
        table.Add(t, ents.FindByClass("npc_antlionguard"))
    end

    for _, a in ipairs(t) do
        for _, p in ipairs(player.GetAll()) do
            if p.BugBaited and IsValid(p:GetWeapon("weapon_bugbait")) then
                a:AddEntityRelationship(p, D_HT, 99)
            elseif not IsValid(p:GetWeapon("weapon_bugbait")) then
                a:AddEntityRelationship(p, D_HT, 99) -- Враждебное отношение к игрокам без weapon_bugbait
            else
                a:AddEntityRelationship(p, D_LI, 99)
            end
        end
    end
end

-- Перехватчик события создания сущности
hook.Add("OnEntityCreated", "fp_create", function(e)
    if not GetConVar("fp_enabled"):GetBool() then return end
    local name = e:GetClass()

    if name == "env_sporeexplosion" then
        for _, v in ipairs(ents.FindByClass("npc_antlion*")) do
            if (v:GetClass() ~= "npc_antlionguard" or GetConVar("fp_guards"):GetBool()) and v:GetClass() ~= "npc_antlion_grub" and v:GetPos():Distance(e:GetPos()) < 2000 then
                v:SetEnemy(e, true)
                v:SetTarget(e)
                v:SetSchedule(SCHED_TARGET_CHASE)
            end
        end
    end
end)

-- Перехватчик события Think для проверки альтернативной атаки и обновления отношений
hook.Add("Think", "fp", function()
    if not GetConVar("fp_enabled"):GetBool() then return end

    for _, p in ipairs(player.GetAll()) do
        if p:KeyDown(IN_ATTACK2) and IsValid(p:GetActiveWeapon()) and p:GetActiveWeapon():GetClass() == "weapon_bugbait" then
            CallAntlionsToPlayer(p, 500) -- 500 это радиус, в пределах которого муравьиные львы будут реагировать
            PlayAltAttackSound(p) -- Воспроизведение звука
        end
    end

    UpdateAntlionRelationships()
end)

-- Обратный вызов при изменении консольной переменной 'fp_guards'
cvars.AddChangeCallback("fp_guards", function(_, _, newVal)
    if not GetConVar("fp_enabled"):GetBool() then return end
    UpdateAntlionRelationships()
end)
