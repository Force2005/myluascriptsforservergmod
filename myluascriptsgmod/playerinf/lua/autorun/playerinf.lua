-- Предварительное создание шрифтов
surface.CreateFont("HeadFont", {
    size = 180,
    weight = 1200,
    antialias = true,
    outline = true,
    font = "Bahnschrift"
})

surface.CreateFont("FontJob", {
    size = 110,
    weight = 1200,
    antialias = false,
    outline = true,
    font = "Comic Sans MS"
})

-- Таблица цветов для разных ролей (создается один раз)
local jobColors = {
    ["user"] = Color(89, 255, 205),
    ["user1"] = Color(84, 255, 104),
    ["user2"] = Color(104, 177, 255),
    ["user3"] = Color(223, 130, 255),
    ["user4"] = Color(225, 127, 255),
    ["user5"] = Color(255, 144, 76),
    ["admin"] = Color(161, 255, 0),
    ["superadmin"] = Color(152, 251, 152),
    ["moderator"] = Color(173, 216, 230) 
}

-- Материалы иконок (загружаются один раз)
local icon_user = Material("materials/icon16/user.png")
local icon_ryad = Material("materials/icon16/medal_bronze_1.png")
local icon_silver = Material("materials/icon16/medal_silver_1.png")
local icon_master = Material("materials/icon16/controller.png")
local icon_legend = Material("materials/icon16/fire.png")
local icon_stalker = Material("materials/icon16/sport_8ball.png")
local icon_user_adm = Material("materials/icon16/award_star_gold_1.png")
local icon_user_mod = Material("materials/icon16/award_star_gold_2.png")
local icon_user_gray = Material("materials/icon16/tux.png")

-- Кэш масштаба для известных расстояний
local scaleCache = {}

local function DynamicScale(distance)
    if not scaleCache[distance] then
        scaleCache[distance] = math.Clamp(1 - distance / 1000, 0.1, 1)
    end
    return scaleCache[distance]
end

-- Функция для отрисовки текста с обводкой
local function drawTextOutlined(text, font, x, y, color, outlineColor, alignX, alignY, outlineWidth)
    for offsetX=-outlineWidth, outlineWidth do
        for offsetY=-outlineWidth, outlineWidth do
            if offsetX ~= 0 or offsetY ~= 0 then
                draw.SimpleText(text, font, x + offsetX, y + offsetY, outlineColor, alignX, alignY)
            end
        end
    end
    draw.SimpleText(text, font, x, y, color, alignX, alignY)
end

-- Функция для отрисовки информации о игроке с учетом динамического масштабирования
local function DrawInfo(ply)
    if not IsValid(ply) or not ply:Alive() or ply == LocalPlayer() then return end
    local Distance = LocalPlayer():GetPos():Distance(ply:GetPos())
    if Distance > 700 then return end

    local alpha = math.Clamp(500 - Distance / 490 * 255, 0, 255)
    local scale = DynamicScale(Distance)
    local pos = ply:GetPos() + Vector(0, 0, 90)
    local name = ply:Nick()
    local rank = ply:GetUserGroup()
    local teamIndex = ply:Team()
    local teamName = team.GetName(teamIndex)
    local namecolor = Color(255, 255, 255, alpha)
    local outlineWidth = 4
    local jobColor = jobColors[rank] or Color(255, 255, 255, alpha)
    local icon = icon_user -- Иконка по умолчанию

    -- Выбор иконки в зависимости от ранга
    if rank == "admin" then
        icon = icon_user_adm
    elseif rank == "superadmin" then
        icon = icon_user_gray
    elseif rank == "moderator" then
        icon = icon_user_mod 
    elseif rank == "user1" then
        icon = icon_ryad
    elseif rank == "user2" then
        icon = icon_silver
    elseif rank == "user3" then
        icon = icon_master 
    elseif rank == "user4" then
        icon = icon_legend 
    elseif rank == "user5" then
        icon = icon_stalker
    end

    -- Начало 3D рендеринга с учетом масштаба
    cam.Start3D2D(pos, Angle(0, EyeAngles().y - 90, 90), 0.05 * scale)
        surface.SetMaterial(icon)
        surface.SetDrawColor(255, 255, 255, alpha)
        surface.DrawTexturedRect(-40 / scale, -180 / scale, 90 / scale, 90 / scale)
        drawTextOutlined(name, "HeadFont", 0, 0, namecolor, Color(0, 0, 0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, outlineWidth)
        drawTextOutlined(teamName, "FontJob", 0, 120 / scale, jobColor, Color(0, 0, 0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, outlineWidth)
    cam.End3D2D()
end

-- Хук для отрисовки информации о всех игроках
hook.Add("PostDrawOpaqueRenderables", "DrawPlayerInfo", function()
    for _, ply in ipairs(player.GetAll()) do
        DrawInfo(ply)
    end
end)

hook.Add("PreDrawHalos", "AddHealthBasedAuraOnSight", function()
    local target = LocalPlayer():GetEyeTrace().Entity
    if target:IsPlayer() then
        local health = target:Health()
        local green = math.Clamp(health * 2.55, 0, 255)
        local red = 255 - green
        halo.Add({target}, Color(red, green, 0), 1, 1, 5, true, true)
    end
end)
