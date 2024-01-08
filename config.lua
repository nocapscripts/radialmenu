local isJudge = false
local isPolice = false
local isTow = false
local isTaxi = false
local isMedic = false
local isRealestate = false
local isDead = false
local myJob = "Unemployed"
local onDuty = false
local inGarage = false
local inDepots = false
local inBennys = false
local inBennys2 = false
local inTuner = false
local inTunerShop = false
local inHayesShop = false
local inSandyRepair = false
local inPaletoRepair = false
local inTowFianance = false
local inPdMech = false
local PlayerJob = {}

Config = Config or {}

Config.frame = "qb-core"

local Core = exports[Config.frame]:GetCoreObject()
local PlayerData = Core.Functions.GetPlayerData()

AddEventHandler('onResourceStart', function(resource)
    PlayerData = Core.Functions.GetPlayerData()
    PlayerJob = PlayerData.job
    onDuty = PlayerJob.onduty
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = Core.Functions.GetPlayerData()
    PlayerJob = PlayerData.job
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)


Config.Menu = {
    {
        Id = "walkstyles",
        DisplayName = "Walk Style",
        Icon = "#global-walk",
        EnableMenu = function()
            
            return not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"]
        end,
        SubMenus = {"walkstyle:brave", "walkstyle:hurry", "walkstyle:business", "walkstyle:tipsy", "walkstyle:injured","walkstyle:tough", "walkstyle:default", "walkstyle:hobo", "walkstyle:money", "walkstyle:swagger", "walkstyle:shady", "walkstyle:maneater", "walkstyle:chichi", "walkstyle:sassy", "walkstyle:sad", "walkstyle:posh", "walkstyle:alien", "walkstyle:dean", 'walkstyle:armored', 'walkstyle:gangster', 'walkstyle:quick', 'walkstyle:wide', 'walkstyle:fat' }
    },

    {
        Id = "expressions",
        DisplayName = "Expressions",
        Icon = "#expressions",
        EnableMenu = function()
            
            return not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"]
        end,
        SubMenus = {"expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },

    {
        Id = "police",
        DisplayName = "Politsei",
        Icon = '#police-action',
        EnableMenu = function()
            local pData = Core.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and isPolice and onDuty)
        end,
        SubMenus = {'police:mdw', 'police:remask', 'police:search', 'police:fingerprint', 'police:gsr', 'police:seize:items', 'police:check'}
    },
}

Config.SubMenus = {
    ['judge:license:give'] = {
        Title = 'Give License',
        Icon = '#judge-license',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:license',
        FunctionParameters = 'Give'
    },
    ['judge:license:remove'] = {
        Title = 'Revoke License',
        Icon = '#judge-license-revoke',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:license',
        FunctionParameters = 'Revoke'
    },
    ['judge:financial'] = {
        Title = 'Financial Activate/Deactivate',
        Icon = '#judge-financial',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:financial-state',
        FunctionParameters = ''
    },
    ['judge:financial:monitor'] = {
        Title = 'Financial Monitor',
        Icon = '#judge-financial-monitor',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:financial-monitor-state',
        FunctionParameters = ''
    },
    ['judge:house'] = {
        Title = 'House Activate/Deactivate',
        Icon = '#judge-house',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:house-state',
        FunctionParameters = ''
    },
    ['judge:business:create'] = {
        Title = 'Create Business',
        Icon = '#judge-business',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:create-business',
        FunctionParameters = ''
    },
    ['judge:account:create'] = {
        Title = 'Create Bank Account',
        Icon = '#judge-financial-account',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:create-account',
        FunctionParameters = ''
    },
    ['ems:revive'] = {
        Title = 'Revive',
        Icon = '#ems-revive',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:revive-player',
        FunctionParameters = ''
    },
    ['ems:heal'] = {
        Title = 'Heal',
        Icon = '#ems-heal',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:heal-player',
        FunctionParameters = ''
    },
    ['ems:blood'] = {
        Title = 'Take Blood',
        Icon = '#ems-syringe',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:take-blood',
        FunctionParameters = ''
    },
    ['ems:stomachpump'] = {
        Title = 'Stomach pump',
        Icon = '#ems-stomach',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:stomach-pump',
        FunctionParameters = ''
    },
    ['radio:one'] = {
        Title = '#1',
        Icon = '#police-channel',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:radio-set-channel',
        FunctionParameters = 1.0
    },
    ['radio:two'] = {
        Title = '#2',
        Icon = '#police-channel',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:radio-set-channel',
        FunctionParameters = 2.0
    },
    ['radio:three'] = {
        Title = '#3',
        Icon = '#police-channel',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:radio-set-channel',
        FunctionParameters = 3.0
    },
    ['radio:four'] = {
        Title = '#4',
        Icon = '#police-channel',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:radio-set-channel',
        FunctionParameters = 4.0
    },
    ['radio:five'] = {
        Title = '#5',
        Icon = '#police-channel',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:radio-set-channel',
        FunctionParameters = 5.0
    },
    ['police:mdw'] = {
        Title = 'MDW',
        Icon = '#police-tablet',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:open-MDW',
        FunctionParameters = {Type = 'Police'}
    },
    ['police:remask'] = {
        Title = 'Remove Mask Hat',
        Icon = '#police-remask',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:remove-face-wear',
        FunctionParameters = ''
    },
    ['police:fingerprint'] = {
        Title = 'Check Fingerprint',
        Icon = '#police-finger',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:try-finger-test',
        FunctionParameters = ''
    },
    ['police:gsr'] = {
        Title = 'Check GSR',
        Icon = '#police-gsr',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:try-gsr-test',
        FunctionParameters = ''
    },
    ['police:seize:items'] = {
        Title = 'Seize Possessions',
        Icon = '#police-seize-items',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:try-seize',
        FunctionParameters = ''
    },
    ['police:search'] = {
        Title = 'Search',
        Icon = '#global-steal',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:search-closest',
        FunctionParameters = true
    },
    ['police:checkself'] = {
        Title = 'Check Status Self',
        Icon = '#police-status',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:try-status-self',
        FunctionParameters = ''
    },
    ['police:check'] = {
        Title = 'Check Status',
        Icon = '#police-status',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:try-status',
        FunctionParameters = ''
    },
    ['civ:escort'] = {
        Title = 'Escort',
        Icon = '#general-escort',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:toggle-escort',
        FunctionParameters = ''
    },
    ['civ:seat'] = {
        Title = 'Seat',
        Icon = '#general-seat',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:try-seat',
        FunctionParameters = ''
    },
    ['civ:unseat'] = {
        Title = 'Unseat',
        Icon = '#general-unseat',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:try-unseat',
        FunctionParameters = ''
    },
    ['civ:steal'] = {
        Title = 'Steal',
        Icon = '#global-steal',
        Close = true,
        FunctionType = 'Client',
        FunctionName = 'client:search-closest',
        FunctionParameters = false
    },
    -- Anims and walk styles
    ['walkstyle:brave'] = {
        Title = "Brave",
        Icon = "#animation-brave",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@brave",
    },
    ['walkstyle:hurry'] = {
        Title = "Hurry",
        Icon = "#animation-hurry",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@hurry@a",
    },
    ['walkstyle:business'] = {
        Title = "Business",
        Icon = "#animation-business",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@business@a",
    },
    ['walkstyle:tipsy'] = {
        Title = "Tipsy",
        Icon = "#animation-tipsy",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@drunk@slightlydrunk",
    },
    ['walkstyle:injured'] = {
        Title = "Injured",
        Icon = "#animation-injured",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@injured",
    },
    ['walkstyle:tough'] = {
        Title = "Tough",
        Icon = "#animation-tough",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@tough_guy@",
    },
    ['walkstyle:sassy'] = {
        Title = "Sassy",
        Icon = "#animation-sassy",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@sassy",
    },
    ['walkstyle:sad'] = {
        Title = "Sad",
        Icon = "#animation-sad",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@sad@a",
    },
    ['walkstyle:posh'] = {
        Title = "Posh",
        Icon = "#animation-posh",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@posh@",
    },
    ['walkstyle:alien'] = {
        Title = "Alien",
        Icon = "#animation-alien",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@alien",
    },
    ['walkstyle:nonchalant'] = {
        Title = "Nonchalant",
        Icon = "#animation-nonchalant",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@non_chalant",
    },
    ['walkstyle:hobo'] = {
        Title = "Hobo",
        Icon = "#animation-hobo",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@hobo@a",
    },
    ['walkstyle:money'] = {
        Title = "Money",
        Icon = "#animation-money",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@money",
    },
    ['walkstyle:swagger'] = {
        Title = "Swagger",
        Icon = "#animation-swagger",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@swagger",
    },
    ['walkstyle:shady'] = {
        Title = "Shady",
        Icon = "#animation-shady",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@shadyped@a",
    },
    ['walkstyle:maneater'] = {
        Title = "Man Eater",
        Icon = "#animation-maneater",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_f@maneater", 
    },
    ['walkstyle:chichi'] = {
        Title = "ChiChi",
        Icon = "#animation-chichi",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_f@chichi",
    },
    ['walkstyle:dean'] = {
        Title = "Dean",
        Icon = "#animation-dean",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_chubby",
    },
    ['walkstyle:default'] = {
        Title = "Default",
        Icon = "#animation-default",
        Close = true,
        FunctionName = "client:walkstyle-clear",
        FunctionType = "Client",
    },
    ['walkstyle:armored'] = {
        Title = "Armored",
        Icon = "#animation-armor",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "anim_group_move_ballistic",
    },
    ['walkstyle:gangster'] = {
        Title = "Gangster",
        Icon = "#animation-gangster",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@gangster@var_e",
    },
    ['walkstyle:quick'] = {
        Title = "Quick",
        Icon = "#animation-quick",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@quick",
    },
    ['walkstyle:wide'] = {
        Title = "Wide",
        Icon = "#animation-wide",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@bag",
    },
    ['walkstyle:fat'] = {
        Title = "Fat",
        Icon = "#animation-fat",
        Close = true,
        FunctionName = "client:walkstyle",
        FunctionType = "Client",
        FunctionParameters = "move_m@fat@a",
    },




    
    ["expressions:angry"] = {
        Title = "Angry",
        Icon = "#expressions-angry",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_angry_1",
        FunctionType = "Client",
    },
    ["expressions:drunk"] = {
        Title = "Drunk",
        Icon = "#expressions-drunk",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_drunk_1" ,
        FunctionType = "Client",
    },
    ["expressions:dumb"] = {
        Title = "Dumb",
        Icon = "#expressions-dumb",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "pose_injured_1",
        FunctionType = "Client",
    },
    ["expressions:electrocuted"] = {
        Title = "Electrocuted",
        Icon = "#expressions-electrocuted",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "electrocuted_1",
        FunctionType = "Client",
    },
    ["expressions:grumpy"] = {
        Title = "Grumpy",
        Icon = "#expressions-grumpy",
        Close = true,
        FunctionName = "client:expression", 
        FunctionParameters = "mood_drivefast_1",
        FunctionType = "Client",
    },
    ["expressions:happy"] = {
        Title = "Happy",
        Icon = "#expressions-happy",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_happy_1",
        FunctionType = "Client",
    },
    ["expressions:injured"] = {
        Title = "Injured",
        Icon = "#expressions-injured",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_injured_1",
        FunctionType = "Client",
    },
    ["expressions:joyful"] = {
        Title = "Joyful",
        Icon = "#expressions-joyful",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_dancing_low_1",
        FunctionType = "Client",
    },
    ["expressions:mouthbreather"] = {
        Title = "Mouthbreather",
        Icon = "#expressions-mouthbreather",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "smoking_hold_1",
        FunctionType = "Client",
    },
    ["expressions:normal"]  = {
        Title = "Normal",
        Icon = "#expressions-normal",
        Close = true,
        FunctionName = "client:expression-clear",
        FunctionType = "Client",
    },
    ["expressions:oneeye"]  = {
        Title = "One Eye",
        Icon = "#expressions-oneeye",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "pose_aiming_1",
        FunctionType = "Client",
    },
    ["expressions:shocked"]  = {
        Title = "Shocked",
        Icon = "#expressions-shocked",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "shocked_1",
        FunctionType = "Client",
    },
    ["expressions:sleeping"]  = {
        Title = "Sleeping",
        Icon = "#expressions-sleeping",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "dead_1",
        FunctionType = "Client",
    },
    ["expressions:smug"]  = {
        Title = "Smug",
        Icon = "#expressions-smug",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_smug_1",
        FunctionType = "Client",
    },
    ["expressions:speculative"]  = {
        Title = "Speculative",
        Icon = "#expressions-speculative",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_aiming_1",
        FunctionType = "Client",
    },
    ["expressions:stressed"]  = {
        Title = "Stressed",
        Icon = "#expressions-stressed",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_stressed_1",
        FunctionType = "Client",
    },
    ["expressions:sulking"]  = {
        Title = "Sulking",
        Icon = "#expressions-sulking",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "mood_sulk_1",
        FunctionType = "Client",
    },
    ["expressions:weird"]  = {
        Title = "Weird",
        Icon = "#expressions-weird",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "effort_2",
        FunctionType = "Client",
    },
    ["expressions:weird2"]  = {
        Title = "Weird 2",
        Icon = "#expressions-weird2",
        Close = true,
        FunctionName = "client:expression",
        FunctionParameters = "effort_3",
        FunctionType = "Client",
    }
}














RegisterNetEvent("isJudge") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff") -- opposite of the above
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("isTow") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTow", function()
    isTow = true
end)

RegisterNetEvent("isTowOff") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTowOff", function()
    isTow = false
end)

RegisterNetEvent("isTaxi") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTaxi", function()
    isTaxi = true
end)

RegisterNetEvent("isTaxiOff") -- opposite of the above
AddEventHandler("isTaxiOff", function()
    isTaxi = false
end)

RegisterNetEvent("isRealestate") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isRealestate", function()
    isRealestate = true
end)

RegisterNetEvent("isRealestateOff") -- opposite of the above
AddEventHandler("isRealestateOff", function()
    isRealestate = false
end)

RegisterNetEvent("isTuner") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTuner", function()
    isTuner = true
end)

RegisterNetEvent("isTunerOff") -- opposite of the above
AddEventHandler("isTunerOff", function()
    isTuner = false
end)

RegisterNetEvent("isHayes") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isHayes", function()
    isHayes = true
end)

RegisterNetEvent("isHayesOff") -- opposite of the above
AddEventHandler("isHayesOff", function()
    isHayes = false
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate") -- dont edit this unless you don't use rs_base
AddEventHandler("QBCore:Client:OnJobUpdate", function(jobInfo)
    myJob = jobInfo.name
    if isMedic and myJob ~= "ambulance" then isMedic = false end
    if isRealestate and myJob ~= "realestate" then isRealestate = false end
    if isPolice and myJob ~= "police" then isPolice = false end
    if isTow and myJob ~= "tow" then isTow = false end
    if isTaxi and myJob ~= "taxi" then isTaxi = false end
    if isTuner and myJob ~= "tuner" then isTuner = false end
    if isHayes and myJob ~= "tuner" then isHayes = false end
    if myJob == "police" then isPolice = true end
    if myJob == "tow" then isTow = true end
    if myJob == "taxi" then isTaxi = true end
    if myJob == "tuner" then isTuner = true end
    if myJob == "hayesauto" then isHayes = true end
    if myJob == "ambulance" then isMedic = true end
    if myJob == "realestate" then isRealestate = true end
end)

RegisterNetEvent('QBCore:Client:SetDuty') -- dont edit this unless you don't use rs_base
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    myJob = Core.Functions.GetPlayerData().job.name
    if isMedic and myJob ~= "ambulance" then isMedic = false end
    if isRealestate and myJob ~= "realestate" then isRealestate = false end
    if isPolice and myJob ~= "police" then isPolice = false end
    if isTow and myJob ~= "tow" then isTow = false end
    if isTuner and myJob ~= "tuner" then isTuner = false end
    if isHayes and myJob ~= "hayesauto" then isHayes = false end
    if myJob == "police" then isPolice = true onDuty = duty end
    if myJob == "tow" then isTow = true onDuty = duty end
    if myJob == "ambulance" then isMedic = true onDuty = duty end
    if myJob == "realestate" then isRealestate = true onDuty = duty end
    if myJob == "tuner" then isTuner = true onDuty = duty end
    if myJob == "hayesauto" then isHayes = true onDuty = duty end
end)




RegisterNetEvent('qb-polyzone:enter')
AddEventHandler('qb-polyzone:enter', function(name)
    local InVehicle = IsPedInAnyVehicle(PlayerPedId())
    if name == "garages" then
        inGarage = true
        exports[Config.frame]:DrawText("GARAAZ", 'left')
    elseif name == "ganggarages" then
        inGarage = true
        exports[Config.frame]:DrawText("GARAAZ", 'left')
    elseif name == "jobgarages" then
        inGarage = true
        exports[Config.frame]:DrawText("GARAAZ", 'left')
    elseif name == "depots" then
        inDepots = true
        exports[Config.frame]:DrawText("DEPOO", 'left')
    elseif name == "Bennys" then
        if InVehicle then
            inBennys = true
            exports[Config.frame]:DrawText("BENNY", 'left')
        end
    elseif name == "Bennys2" then
        if InVehicle then
            inBennys2 = true
            exports[Config.frame]:DrawText("BENNY", 'left')
        end
    elseif name == "TunerRepair" then
        if InVehicle then
            inTuner = true
            if PlayerJob.name == "tuner" and onDuty then
                exports[Config.frame]:DrawText("PARANDUS", 'left')
            end
        end
    elseif name == "TunerShop" then
        if InVehicle then
            inTunerShop = true
            if PlayerJob.name == "tuner" and onDuty then
                exports[Config.frame]:DrawText("CUSTOMS", 'left')
            end
        end
    elseif name == "HayesAutos" then
        if InVehicle then
            inHayesShop = true
            if PlayerJob.name == "hayesauto" and onDuty then
                exports[Config.frame]:DrawText("CUSTOMS", 'left')
            end
        end
    elseif name == "pdmech" then
        if InVehicle then
            inPdMech = true
            exports[Config.frame]:DrawText("AUTOD", 'left')
        end
    elseif name == "SandyRepair" then
        if InVehicle then
            inSandyRepair = true
            exports[Config.frame]:DrawText("BENNY", 'left')
      
        end
    elseif name == "PaletoRepair" then
        if InVehicle then
            inPaletoRepair = true
            exports[Config.frame]:DrawText("BENNY", 'left')
            
        end
    elseif name == "towFinance" then
        if InVehicle then
            inTowFianance = true
            exports[Config.frame]:DrawText("FINANTS", 'left')
            
        end
    elseif name == "Ottos" then
        if InVehicle then
            inTunerShop = true
            if PlayerJob.name == "ottos" and onDuty then
                exports[Config.frame]:DrawText("OTTOS", 'left')
                
            end
        end
    end
end)







RegisterNetEvent('qb-polyzone:exit')
AddEventHandler('qb-polyzone:exit', function(name)
    if name == "garages" then
        inGarage = false
        exports[Config.frame]:HideText()
    elseif name == "ganggarages" then
        inGarage = false
        exports[Config.frame]:HideText()
    elseif name == "jobgarages" then
        inGarage = false
        exports[Config.frame]:HideText()
    elseif name == "depots" then
        inDepots = false
        exports[Config.frame]:HideText()
    elseif name == "Bennys" then
        inBennys = false
        exports[Config.frame]:HideText()
    elseif name == "Bennys2" then
        inBennys2 = false
        exports[Config.frame]:HideText()
    elseif name == "TunerRepair" then
        inTuner = false
        if PlayerJob.name == "tuner" and onDuty then
            exports[Config.frame]:HideText()
        end
    elseif name == "TunerShop" then
        inTunerShop = false
        if PlayerJob.name == "tuner" and onDuty then
            exports[Config.frame]:HideText()
        end
    elseif name == "HayesAutos" then
        inTunerShop = false
        if PlayerJob.name == "tuner" and onDuty then
            exports[Config.frame]:HideText()
        end
    elseif name == "pdmech" then
        inPdMech = false
        exports[Config.frame]:HideText()
    elseif name == "SandyRepair" then
        inSandyRepair = false
        exports[Config.frame]:HideText()
    elseif name == "PaletoRepair" then
        inPaletoRepair = false
        exports[Config.frame]:HideText()
    elseif name == "towFinance" then
        inTowFianance = false
        exports[Config.frame]:HideText()
    elseif name == "Ottos" then
        inTunerShop = false
        if PlayerJob.name == "ottos" and onDuty then
            exports[Config.frame]:HideText()
        end
    end
end)
