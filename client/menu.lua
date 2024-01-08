local ShowMenu = false
local MaxMenuItems = 8
local Core = exports[Config.frame]:GetCoreObject()
local PlayerData = {}
local ClickedAction = false



RegisterNetEvent(Config.Load, function()
    Citizen.SetTimeout(1000, function()
        PlayerData = Core.Functions.GetPlayerData()
        ShowMenu = true
   end)
end)

RegisterNetEvent(Config.Unload, function()
    ShowMenu = false
    ClickedAction = false
    MaxMenuItems = {}
    PlayerData = {}
end)

RegisterNetEvent(Config.JobUpdate, function(JobData)
	PlayerData.job = JobData
end)

-- [ Code ] --

-- [ Events ] --

RegisterNetEvent('client:ui-reset', function()
    if ShowMenu then
        ShowMenu = false
        SetNuiFocus(false, false)
        PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
        SendNUIMessage({State = "Destroy"})
    end
end)

-- [ Functions ] --

RegisterCommand('radialmenu', function()


   InitMenu()



end)

RegisterKeyMapping('radialmenu', 'Kasutuse menüü', 'keyboard', 'F1')



function InitMenu()
  
    --ClickedAction = true
    if ClickedAction then return end
    SendNUIMessage({State = "Show", Data = GetMenuData()})
    SetCursorLocation(0.5, 0.5)
    SetNuiFocus(true, true)
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    
end

function GetMenuData()
    local Promise = promise:new()
    local EnabledMenus = {}
    for _, MenuConfig in pairs(Config.Menu) do
        if MenuConfig:EnableMenu() then
            local DataElements = {}
            local HasSubMenu = false
            if MenuConfig.SubMenus ~= nil and #MenuConfig.SubMenus > 0 then
                HasSubMenu = true
                local PreviousMenu = DataElements
                local CurrentElement = {}
                for i = 1, #MenuConfig.SubMenus do
                    CurrentElement[#CurrentElement+1] = Config.SubMenus[MenuConfig.SubMenus[i]]
                    CurrentElement[#CurrentElement].Id = MenuConfig.SubMenus[i]
                    CurrentElement[#CurrentElement].EnableMenu = nil
                    if i % MaxMenuItems == 0 and i < (#MenuConfig.SubMenus - 1) then
                        PreviousMenu[MaxMenuItems + 1] = {
                            Id = "_more",
                            Title = "More",
                            Icon = "#more",
                            Items = CurrentElement
                        }
                        PreviousMenu = CurrentElement
                        CurrentElement = {}
                    end
                end
                if #CurrentElement > 0 then
                    PreviousMenu[MaxMenuItems + 1] = {
                        Id = "_more",
                        Title = "More",
                        Icon = "#more",
                        Items = CurrentElement
                    }
                end
                DataElements = DataElements[MaxMenuItems + 1].Items
            end
            EnabledMenus[#EnabledMenus+1] = {
                Id = MenuConfig.Id,
                Title = MenuConfig.DisplayName,
                Close = MenuConfig.Close,
                FunctionType = MenuConfig.FunctionType,
                FunctionParameters = MenuConfig.FunctionParameters,
                FunctionName = MenuConfig.FunctionName,
                Icon = MenuConfig.Icon,
            }
            if HasSubMenu then
                EnabledMenus[#EnabledMenus].Items = DataElements
            end
        end
    end
    Promise:resolve(EnabledMenus)
    return Citizen.Await(Promise)
end

-- [ NUI Callbacks ] --

RegisterNUICallback('CloseMenu', function(Data, Cb)
    ShowMenu = false
    SetNuiFocus(false, false)
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    ClickedAction = true
    Citizen.SetTimeout(100, function()
        ClickedAction = false
    end)
    Cb('Ok')
end)

RegisterNUICallback('TriggerAction', function(Data, Cb)
    ClickedAction = true
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    if Data.Type == 'Client' then
        TriggerEvent(Data.Action, Data.Parameters)
    elseif Data.Type == 'Server' then 
        TriggerServerEvent(Data.Action, Data.Parameters)
    end

    Citizen.SetTimeout(300, function()
        ClickedAction = false
    end)
    Cb('Ok')
end)