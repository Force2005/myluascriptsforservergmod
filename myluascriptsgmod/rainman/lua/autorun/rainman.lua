local rnd = math.random(1, 5)


if game.GetMap() == "gm_construct" and rnd == 1 then
    if IsValid( GMANDEBIL ) then
        GMANDEBIL:Remove()
    end

    GMANDEBIL = ClientsideModel("models/gman_high.mdl")
    local model = GMANDEBIL
    local poses = {
        [1] = { ['pos'] = Vector( 722.430542, -1042.296265, 369.208038 ),
                ['ang'] = Angle( 0, 132.694778, 0 ) },
        [2] = { ['pos'] = Vector( 724.031250, -2155.968750, 240.031250 ),
                ['ang'] = Angle( 0, 139.180, 0 ) },
        [3] = { ['pos'] = Vector( -3940.031250, 4909.870117, 288.031250 ),
                ['ang'] = Angle( 0, -17.025, 0 ) },
        [4] = { ['pos'] = Vector( -2690.427734, -2260.031250, 640.031250 ),
                ['ang'] = Angle( 0, 88.462, 0 ) },
        [5] = { ['pos'] = Vector(  -2027.968750 ,-2260.031250, 790.031250 ),
                ['ang'] = Angle( 0, 88.462, 0 ) },
        [6] = { ['pos'] = Vector( -3956.407959 ,4636.509277 ,2460.031250 ),
                ['ang'] = Angle( 0, 88.462, 0 ) },
        [7] = { ['pos'] = Vector( -2659.322754 ,-1472.647461 ,-150.953125 ),
                ['ang'] = Angle( 0,0, 0 ) },
        [8] = { ['pos'] = Vector( -4076.036621, -1714.617188, -142.265640 ),
                ['ang'] = Angle( 0, 0, 0 ) },
    }

    local function ChooseRandPos()
        local data = poses[math.random( 1, table.Count(poses) )]
        model:SetPos( data.pos )
        model:SetAngles( data.ang )
        surface.PlaySound("ambient/levels/canals/windchime4.wav") -- Звук при появлении
    end

    model:SetModelScale( 1.1, 0 )
    model:SetMaterial("models/debug/debugwhite")
    model:SetColor( Color(0,0,0) )
	    -- Функция для создания случайного таймера
    local function CreateRandomTimer()
        timer.Create("RandomPosTimer", math.random(100, 900), 1, function()
            ChooseRandPos()
            CreateRandomTimer() -- Создаем новый таймер после выполнения функции
        end)
    end

    CreateRandomTimer()
    hook.Add( 'Think', 'disappearancedebilens', function()
        if model:GetPos() == Vector( 0, 0, 0 ) then
            ChooseRandPos()
        end

        local lp = LocalPlayer()
        local ishide = model:GetPos():Distance( lp:GetPos() ) <= 600
        local aw = lp:GetActiveWeapon()
		
        if IsValid( aw ) then
            ishide = ishide or aw:GetClass() == 'gmod_camera'
        end

        if ishide then
        	surface.PlaySound("ambient/levels/canals/windchime2.wav") -- Звук при исчезновении
            ChooseRandPos()
        end
        
    end )
end
