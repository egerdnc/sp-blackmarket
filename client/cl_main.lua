ESX = nil

local Shop = {x = 2555.45,  y = 4663.12,  z = 33.07}
local NPC = {
    {seller = true, model = "ig_g", x = 2555.45,  y = 4663.12,  z = 33.07, h = 200.0, entity = nil},
    {seller = false, model = "csb_mweather", x = 2553.45,  y = 4665.32,  z = 33.08, h = 205.0, entity = nil},
    {seller = false, model = "csb_mweather", x = 2557.54,  y = 4665.99,  z = 32.97, h = 140.0, entity = nil},
    {seller = false, model = "a_m_o_tramp_01", x = -524.26,  y = -1677.23,  z = 18.27, h = 161.9, isHirdavatci = true, entity = nil},
}
local uiOpen = false

Citizen.CreateThread(function()
    while ESX == nil do
	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	    Citizen.Wait(0)
    end
    for _, v in pairs(NPC) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(1)
        end
        local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h, false, true)
        v.entity = npc
        SetPedFleeAttributes(npc, 0, 0)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedDiesWhenInjured(npc, false)
        SetEntityInvincible(npc , true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        if v.seller or v.isHirdavatci then 
            RequestAnimDict("missfbi_s4mop")
            while not HasAnimDictLoaded("missfbi_s4mop") do
                Wait(1)
            end
            TaskPlayAnim(npc, "missfbi_s4mop" ,"guard_idle_a" ,8.0, 1, -1, 49, 0, false, false, false)
        else
            GiveWeaponToPed(npc, GetHashKey("WEAPON_ADVANCEDRIFLE"), 2800, true, true)
        end
    end

    exports['sp-target']:AddTargetLocalEntity({
		name = "silah-saticisi",
        label = "Silah Satıcısı",
        icon = 'fas fa-dollar-sign',
        onInteract  = BlackMarketShow,
        interactDist = 2.0,
        entity = NPC[1].entity,
        options = {
            {
                name = 'buy',
	            label = 'Satın Al'
            },
        },
    })

    exports['sp-target']:AddTargetLocalEntity({
		name = "hirdavatci",
        label = "Hırdavatçı",
        icon = 'fas fa-tools',
        onInteract  = BlackMarketShow_Items,
        interactDist = 2.0,
        entity = NPC[4].entity,
        options = {
            {
                name = 'buy',
	            label = 'Satın Al'
            },
        },
    })
end)

function BlackMarketShow()
    local canAccess = exports["callback"]:Trigger("sp-blackmarket:canAccess")

    if canAccess == 1 then
        SendNUIMessage({display = true, call = true, name = "Silah Satıcısı", dealer = true})
		SetNuiFocus(true, true)
		uiOpen = true
    else
        TriggerEvent('esx:showAdvancedNotification', "Satıcı", "", "Seni tanımıyorum, kaybol ufaklık." , "CHAR_MP_MERRYWEATHER", 1)
    end
end

function BlackMarketShow_Items()
    SendNUIMessage({display = true, call = true, name = "Hırdavatçı", dealer = false})
	SetNuiFocus(true, true)
	uiOpen = true
end

RegisterNetEvent("sp-blackmarket:closeui", function()
	SendNUIMessage({display = true, call = false})
	SetNuiFocus(false, false)
	uiOpen = false
end)

RegisterNUICallback("rowItems", function(data, cb)
	local items = exports["callback"]:Trigger("sp-blackmarket:getItems", not data.dealer)

    for k,v in pairs(items) do
		SendNUIMessage({insert_item = true, Name = v.display_name, Ammo = v.stock, Image = v.name..".png", WeaponClass = v.name, Price = v.price})
    end
end)

RegisterNUICallback("fillTypes", function(data, cb)
    if data.dealer == false then
        SendNUIMessage({insert_types = true, buy = "Satın al", weapon = "Alet", ammo = "Stok", price = "Fiyat", currency = "$"})
    else
        SendNUIMessage({insert_types = true, buy = "Satın al", weapon = "Silah", ammo = "Stok", price = "Fiyat", currency = "$"})
    end
end)

RegisterNUICallback("satinalim", function(data, cb)
    if data.dealer == false then
        hasBought = exports["callback"]:Trigger("sp-blackmarket:canbuy:item", data)
        if hasBought == true then
            cb(true)
        else
            cb(false)
        end
    else
        hasBought = exports["callback"]:Trigger("sp-blackmarket:canbuy", data)
        if hasBought == true then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterNUICallback("closeui", function(data, cb)
    SendNUIMessage({display = true, call = false})
	SetNuiFocus(false, false)
	uiOpen = false
end)
