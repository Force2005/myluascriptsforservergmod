-- EYEVIEW Addon Initialization
if CLIENT then
    -- Creation of ConVars
    local eyeviewEnabled = CreateClientConVar("eyeview_enabled", "0", true, false)
    local eyeviewFull = CreateClientConVar("eyeview_full", "0", true, false)
    local eyeviewAimHelper = CreateClientConVar("eyeview_aimhelper", "1", true, false)
    local eyeviewAttachment = CreateClientConVar("eyeview_attachment", "eyes", false, false)
    local eyeviewHeadResize = CreateClientConVar("eyeview_headresize", "0", true, false)
    local eyeviewCrouchDisable = CreateClientConVar("eyeview_crouchdisable", "0", true, false)
    local eyeviewBlacklist = {
        ["weapon_physgun"] = true,
        ["gmod_camera"] = true,
        ["gmod_tool"] = true
    }

    -- Function to check if the current weapon is blacklisted
    local function IsWeaponBlacklisted(ply)
        local weapon = ply:GetActiveWeapon()
        if IsValid(weapon) and eyeviewBlacklist[weapon:GetClass()] then
            return true
        end
        return false
    end

    -- Think Hook
    hook.Add("Think", "EYEVIEW_Think", function()
        if eyeviewHeadResize:GetBool() and IsValid(LocalPlayer()) and LocalPlayer():Alive() then
            local headBone = LocalPlayer():LookupBone("ValveBiped.Bip01_Head1")
            if headBone then
                if eyeviewEnabled:GetBool() and not IsWeaponBlacklisted(LocalPlayer()) then
                    LocalPlayer():ManipulateBoneScale(headBone, Vector(0, 0, 0))
                else
                    LocalPlayer():ManipulateBoneScale(headBone, Vector(1, 1, 1))
                end
            end
        end
    end)

    -- CalcView Hook
    hook.Add("CalcView", "EYEVIEW_CalcView", function(ply, origin, angles, fov)
        if eyeviewEnabled:GetBool() and IsValid(ply) and ply:Alive() and not IsWeaponBlacklisted(ply) and (not eyeviewCrouchDisable:GetBool() or not ply:Crouching()) then
            local eyeview = {}
            local attachmentID = ply:LookupAttachment(eyeviewAttachment:GetString())
            if attachmentID then
                local attachment = ply:GetAttachment(attachmentID)
                eyeview.origin = attachment.Pos
                eyeview.angles = eyeviewFull:GetBool() and attachment.Ang or angles
            else
                eyeview.origin = origin
                eyeview.angles = angles
            end
            eyeview.fov = fov
            return eyeview
        end
    end)

    -- HUDPaint Hook
    hook.Add("HUDPaint", "EYEVIEW_HUDPaint", function()
        if eyeviewEnabled:GetBool() and eyeviewAimHelper:GetBool() and IsValid(LocalPlayer()) and LocalPlayer():Alive() and not IsWeaponBlacklisted(LocalPlayer()) and (not eyeviewCrouchDisable:GetBool() or not LocalPlayer():Crouching()) then
            local hitPos = LocalPlayer():GetEyeTrace().HitPos:ToScreen()
            surface.SetDrawColor(Color(0, 0, 0, 255))
            surface.DrawRect(hitPos.x - 2, hitPos.y - 2, 6, 6)
            surface.SetDrawColor(Color(255, 255, 255, 204))
            surface.DrawRect(hitPos.x - 1, hitPos.y - 1, 4, 4)
        end
    end)

    -- ShouldDrawLocalPlayer Hook
    hook.Add("ShouldDrawLocalPlayer", "EYEVIEW_ShouldDrawLocalPlayer", function(ply)
        if eyeviewEnabled:GetBool() and IsValid(ply) and ply:Alive() and not IsWeaponBlacklisted(ply) and (not eyeviewCrouchDisable:GetBool() or not ply:Crouching()) then
            return true
        end
    end)

    -- Q Menu Panel

    function CreateMenuOption()
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Настройки иммерсивного вида от первого лица")
    frame:SetSize(350, 200)
    frame:Center()
    frame:MakePopup()

    local enabledCheckbox = frame:Add("DCheckBoxLabel")
    enabledCheckbox:SetPos(10, 30)
    enabledCheckbox:SetText("Включить")
    enabledCheckbox:SetConVar("eyeview_enabled")
    enabledCheckbox:SizeToContents()

    local fullViewCheckbox = frame:Add("DCheckBoxLabel")
    fullViewCheckbox:SetPos(10, 60)
    fullViewCheckbox:SetText("Включить полную иммерсивность")
    fullViewCheckbox:SetConVar("eyeview_full")
    fullViewCheckbox:SizeToContents()

    local aimHelperCheckbox = frame:Add("DCheckBoxLabel")
    aimHelperCheckbox:SetPos(10, 90)
    aimHelperCheckbox:SetText("Включить Aim Helper")
    aimHelperCheckbox:SetConVar("eyeview_aimhelper")
    aimHelperCheckbox:SizeToContents()

    local headResizeCheckbox = frame:Add("DCheckBoxLabel")
    headResizeCheckbox:SetPos(10, 120)
    headResizeCheckbox:SetText("Убрать голову твоей модельке")
    headResizeCheckbox:SetConVar("eyeview_headresize")
    headResizeCheckbox:SizeToContents()

    local crouchDisableCheckbox = frame:Add("DCheckBoxLabel")
    crouchDisableCheckbox:SetPos(10, 150)
    crouchDisableCheckbox:SetText("Отключить пока кардешься")
    crouchDisableCheckbox:SetConVar("eyeview_crouchdisable")
    crouchDisableCheckbox:SizeToContents()
    -- Здесь вы можете добавить дополнительные элементы управления, если это необходимо
    end

    local isMenuOpen = false

    hook.Add("Think", "CheckF4Press", function()
        if input.IsKeyDown(KEY_F4) and not isMenuOpen then
            CreateMenuOption()
            isMenuOpen = true
        elseif not input.IsKeyDown(KEY_F4) then
            isMenuOpen = false
        end
    end)

-- Используйте HUD_PRINTCENTER для отображения уведомления в центре экрана
-- Этот код должен быть на стороне клиента
hook.Add("InitPostEntity", "ShowNotification", function()
    notification.AddLegacy("Нажмите F4 для включения иммерсивного вида от первого лица.", NOTIFY_GENERIC, 16)
    surface.PlaySound("buttons/button15.wav") -- Звуковой сигнал при уведомлении
end)

hook.Add("InitPostEntity", "ShowNotificationDonate", function()
    notification.AddLegacy("Поддержите создателя сервера, купите ему кофе на F3! ^_^", NOTIFY_GENERIC, 17)
end)
end
