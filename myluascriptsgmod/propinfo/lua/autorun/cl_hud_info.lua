surface.CreateFont("HudInfoFont", {
    font = "ChatFont",
    size = 18,
    weight = 10,
    outline = true
})

CreateClientConVar("hudinfo_enable", "1", true, false, "Enables/Disables hud info.", 0, 1)

local y = ScrH()
local convar = GetConVar("hudinfo_enable")

hook.Add("HUDPaint", "HudInfoAddon", function()
    local ply = LocalPlayer()
    if convar:GetInt() == 0 then return end
    if not IsValid(ply:GetActiveWeapon()) then return end

    local activeWeapon = ply:GetActiveWeapon():GetClass()
    if activeWeapon ~= "gmod_tool" and activeWeapon ~= "weapon_physgun" then return end

    local eyeTrace = ply:GetEyeTrace()
    if not eyeTrace.Entity or not IsValid(eyeTrace.Entity) then return end
    if eyeTrace.HitWorld then return end
    --if eyeTrace.HitWorld then return end

    local owner
    local ownerColor = Color(255, 255, 255)
    local ent = eyeTrace.Entity
    local ownerEnt
    if CPPI then
        ownerEnt = ent:CPPIGetOwner()
    else
        ownerEnt = ent:GetOwner()
    end

    if ownerEnt and ownerEnt:IsPlayer() then
        owner = ownerEnt:GetName()
        ownerColor = team.GetColor(ownerEnt:Team())
    else
        owner = "World"
    end

    surface.SetFont("HudInfoFont")

    local angles = ent:GetAngles()
    local angleText = "Angle: " .. math.Round(angles.p, 2) .. ", " .. math.Round(angles.y, 2) .. ", " .. math.Round(angles.r, 2)
    local modelText = "Model: " .. ent:GetModel()
    local classText = "Class: " .. ent:GetClass()
    local ownerText = "Owner: " .. owner
    local size = math.max(surface.GetTextSize(angleText), surface.GetTextSize(modelText), surface.GetTextSize(classText), surface.GetTextSize(ownerText))

    -- Адаптивные координаты для HUD
    local hudX = ScrW() - size - 20 -- Отступ справа
    local hudY = ScrH() / 2 - 125 / 2 -- Чуть выше середины экрана

    -- Закругленный прямоугольник для HUD
    draw.RoundedBox(10, hudX - 4, hudY, size + 20, 130, Color(52, 52, 52, 180))

    local textY = hudY + 5
    surface.SetTextPos(hudX + 5, textY)
    surface.SetTextColor(ownerColor)
    surface.DrawText(ownerText)
    textY = textY + 20
    surface.SetTextColor(255, 255, 255)
    surface.SetTextPos(hudX + 5, textY)
    surface.DrawText(classText)
    textY = textY + 20
    surface.SetTextColor(ent:GetColor())
    surface.SetTextPos(hudX + 5, textY)
    surface.DrawText("Color: " .. string.FromColor(ent:GetColor()))
    textY = textY + 20
    surface.SetTextColor(255, 255, 255)
    surface.SetTextPos(hudX + 5, textY)
    surface.DrawText("Material: " .. (ent:GetMaterial() or "default"))
    textY = textY + 20
    surface.SetTextPos(hudX + 5, textY)
    surface.DrawText(modelText)
    textY = textY + 20
    surface.SetTextPos(hudX + 5, textY)
    surface.DrawText(angleText)

    -- Линии направления
    if activeWeapon == "weapon_physgun" or activeWeapon == "gmod_tool" then
        local centerVec = eyeTrace.Entity:WorldSpaceCenter():ToScreen()
        surface.SetDrawColor(255, 0, 0)
        local forwardVec = (eyeTrace.Entity:WorldSpaceCenter() + 10 * eyeTrace.Entity:GetForward()):ToScreen()
        surface.DrawLine(centerVec.x, centerVec.y, forwardVec.x, forwardVec.y)

        surface.SetDrawColor(0, 0, 255)
        local rightVec = (eyeTrace.Entity:WorldSpaceCenter() + 10 * eyeTrace.Entity:GetRight()):ToScreen()
        surface.DrawLine(centerVec.x, centerVec.y, rightVec.x, rightVec.y)

        surface.SetDrawColor(0, 255, 0)
        local upVec = (eyeTrace.Entity:WorldSpaceCenter() + 10 * eyeTrace.Entity:GetUp()):ToScreen()
        surface.DrawLine(centerVec.x, centerVec.y, upVec.x, upVec.y)
    end
end)
