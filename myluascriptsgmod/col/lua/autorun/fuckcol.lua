hook.Add('PlayerSpawnedProp', 'CustomCollisionForDuplicator', function (ply, model, ent)
    if ply:GetActiveWeapon():GetClass() == "gmod_tool" and ply:GetTool():GetMode() == "duplicator" then
        ent:SetCustomCollisionCheck(true)
    end
end)

local nocollide = {
    ['prop_physics'] = true,
}

hook.Add('ShouldCollide', 'NoCollideWithSelf', function (ent1, ent2)
    local collide = nocollide[ent1:GetClass()] and nocollide[ent2:GetClass()]
    return not collide
end)
