local ptfxHandle
local animDict = "amb_camp@world_camp_fire_crouch_ground@male_a@base"
local animName = "base"
local ptfxDict = "core"
local ptfxName = "liquid_leak_water"

function loadAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Citizen.Wait(0)
  end
end

function startPtfx(dict, name)
  RequestNamedPtfxAsset(GetHashKey(dict))
  while not HasNamedPtfxAssetLoaded(GetHashKey(dict)) do
    Citizen.Wait(0)
  end

  UseParticleFxAsset(dict)

  local coords = GetEntityCoords(PlayerPedId())
  ptfxHandle = StartParticleFxLoopedAtCoord(name, coords.x, coords.y, coords.z - 0.3, 0.0, 0.0, 0.0, 2.0, false, false, false, true)
end

function stopPtfx()
    StopParticleFxLooped(ptfxHandle, false)
end

RegisterCommand("pee", function()
    loadAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 8.0, -1, 1, 0, false, false)
    Citizen.Wait(1500)
    startPtfx(ptfxDict, ptfxName)
end)

RegisterCommand("stop", function()
    stopPtfx()
    Citizen.Wait(1500)
    ClearPedTasks(PlayerPedId())
end)