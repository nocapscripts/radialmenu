local CurrentExpression = nil

-- [ Code ] --

-- [ Events] --

RegisterNetEvent('client:walkstyle-clear', function()
    ResetPedMovementClipset(PlayerPedId(), 0.25)
    TriggerServerEvent('server:set-walkstyle', 'None')
end)

RegisterNetEvent('client:walkstyle', function(WalkStyle)
    RequestAnimSet(WalkStyle)
    while not HasAnimSetLoaded(WalkStyle) do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), WalkStyle, true)
    TriggerServerEvent('server:set-walkstyle', WalkStyle)
end)

RegisterNetEvent("client:expression", function(Expression)
    SetFacialIdleAnimOverride(PlayerPedId(), Expression, 0)
    CurrentExpression = Expression
end)

RegisterNetEvent("client:expression-clear", function()
    CurrentExpression = nil
    ClearFacialIdleAnimOverride(PlayerPedId())
end)

RegisterNetEvent('client:player-wink', function(IsPress)
    if IsPress then
        SetFacialIdleAnimOverride(PlayerPedId(), "pose_aiming_1", 0)
    else
        if CurrentExpression == nil then
            ClearFacialIdleAnimOverride(PlayerPedId())
        else
            SetFacialIdleAnimOverride(PlayerPedId(), CurrentExpression, 0)
        end
    end
end)

