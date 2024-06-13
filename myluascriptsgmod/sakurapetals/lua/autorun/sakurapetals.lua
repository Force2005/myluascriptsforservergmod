local Target = LocalPlayer()
local maxRadius = 300
local forMax = 5
local spawnDelay = 0.1
local startZ = 2
local velocity = 10
local wind_strength = 50
local enableSound = false
local volume = 5
local dieTime = 7


local function getWindDirection(t)
  local amplitude = 1
  local frequency = 1
  local phase = 0.5

  local x = amplitude * math.sin(frequency * t + phase)
  local y = amplitude * math.sin(frequency * t + phase * 2)
  local z = 1

  return Vector(x, y, z)
end


local soundUrl = "https://cdn.discordapp.com/attachments/974678227362660395/974678348343148584/f969747680e8276.mp3"

-- Создание эмиттера частиц и звука
local emitter = ParticleEmitter(Target:GetPos())
local sound = nil
if enableSound then
    sound = CreateSound(Target, soundUrl)
    sound:SetSoundLevel(volume)
    sound:Play()
end


local function rain(radius, degree)
    local x = radius * math.cos(degree)
    local y = -radius * math.sin(degree)
    local pos = Target:GetPos() + Vector(x, y, startZ)
    
    local flake_size = math.Rand(0.4, 1)
    local part = emitter:Add("particles/balloon_bit", pos)
    if part then
        part:SetDieTime(dieTime)
        part:SetStartAlpha(255)
        part:SetEndAlpha(255)
        part:SetStartSize(flake_size)
        part:SetEndSize(flake_size)
        part:SetColor(255, 192, 203)
        part:SetGravity(Vector(0, 0, -0.1))
        
        local wind_direction = getWindDirection(CurTime())
        part:SetVelocity(Vector(0, 0, -velocity) + wind_direction * wind_strength)
        
        part:SetRollDelta(math.Rand(0.7, 1.6))
    end
end



local function startRain()
    emitter:Finish()
    emitter = ParticleEmitter(Target:GetPos())
    
    for i = 0, forMax do
        local radius, degree = math.Rand(0, maxRadius), math.Rand(0, math.pi * 2)
        rain(radius, degree)
    end
end


timer.Create("rain", spawnDelay, 0, startRain)
