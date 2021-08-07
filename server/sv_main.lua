ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

exports["callback"]:Register("sp-blackmarket:canbuy", function(source, pData)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getAccount('money').money >= pData.price then
		local stock = getStocks(pData.weapon, false)
		if stock >= 1 then
			xPlayer.removeAccountMoney('money', pData.price)
			xPlayer.addInventoryItem(string.upper(pData.weapon), 1)
			removeStock(pData.weapon, false)
			exports['sp-lib']:addDiscordLog('https://discord.com/api/webhooks/855603516580298762/-skYVSBKNVbRleh2qArAGStt27g7-jZYJU9hgG11f3yL5R4e0pJttE6RvdZz23d5prQh', 16753920, "BlackMarket - Silah", string.format("%s isimli oyuncu %s silahi aldi($%d).",xPlayer.getName(),pData.weapon,pData.price), "Spontane Roleplay")
			TriggerClientEvent('esx:showAdvancedNotification', src, "Satıcı", "", "İstediğini verdim, şimdi toz ol." , "CHAR_MP_MERRYWEATHER", 1)
			TriggerClientEvent('sp-blackmarket:closeui', src)
			return true
		else
			TriggerClientEvent('esx:showAdvancedNotification', src, "Satıcı", "", "Üzgünüm dostum, yeterli stoğum yok." , "CHAR_MP_MERRYWEATHER", 1)
			
			return false
		end
	else
		TriggerClientEvent('esx:showAdvancedNotification', src, "Satıcı", "", "Taşak mı geçiyorsun? Paran bile yok." , "CHAR_MP_MERRYWEATHER", 1)
		return false
	end
end)

exports["callback"]:Register("sp-blackmarket:canbuy:item", function(source, pData)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.getAccount('money').money >= pData.price then
		local stock = getStocks(pData.weapon, true)
		if stock >= 1 then
			xPlayer.removeAccountMoney('money', pData.price)
			xPlayer.addInventoryItem(pData.weapon, 1)
			removeStock(pData.weapon, true)
			exports['sp-lib']:addDiscordLog('https://discord.com/api/webhooks/855603516580298762/-skYVSBKNVbRleh2qArAGStt27g7-jZYJU9hgG11f3yL5R4e0pJttE6RvdZz23d5prQh', 16753920, "BlackMarket - Item", string.format("%s isimli oyuncu %s aldi($%d).",xPlayer.getName(),pData.weapon,pData.price), "Spontane Roleplay")
			TriggerClientEvent('esx:showAdvancedNotification', src, "Satıcı", "", "İstediğini verdim, şimdi toz ol." , "CHAR_MP_MERRYWEATHER", 1)
			TriggerClientEvent('sp-blackmarket:closeui', src)
			return true
		else
			TriggerClientEvent('esx:showAdvancedNotification', src, "Satıcı", "", "Üzgünüm dostum, yeterli stoğum yok." , "CHAR_MP_MERRYWEATHER", 1)
			return false
		end
	else
		TriggerClientEvent('esx:showAdvancedNotification', src, "Satıcı", "", "Taşak mı geçiyorsun? Paran bile yok." , "CHAR_MP_MERRYWEATHER", 1)
		return false
	end
end)

exports["callback"]:Register("sp-blackmarket:getItems", function(source, bool)
	return getItems(bool)
end)

exports["callback"]:Register("sp-blackmarket:canAccess", function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	return canAccess(xPlayer.identifier)
end)
