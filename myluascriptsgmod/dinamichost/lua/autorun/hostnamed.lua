local name = "🏝️ Пиратская бухта 🏴‍☠️// "
local prefixes = {"Wire, SF", "Build|PvP"} -- Здесь добавьте ваши префиксы
local currentPrefixIndex = 1

local function change( pref )
    local n = ( name .. pref )

    if n == GetHostName() then return end

    RunConsoleCommand( "hostname", n )    
end

timer.Create( "dynamichostname", 60, 0, function()
    change( prefixes[currentPrefixIndex] )
    currentPrefixIndex = currentPrefixIndex % #prefixes + 1
end )
