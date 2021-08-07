function getItems(bool)
    if bool == true then
        return MySQL.Sync.fetchAll("SELECT * FROM blackmarket_items", {})
    else
        return MySQL.Sync.fetchAll("SELECT * FROM blackmarket_weapons", {})
    end
end

function getStocks(name, bool)
    if bool == true then
        return MySQL.Sync.fetchScalar("SELECT stock FROM blackmarket_items WHERE `name` = @name", {
	    	['@name'] = name
	    })
    else
        return MySQL.Sync.fetchScalar("SELECT stock FROM blackmarket_weapons WHERE `name` = @name", {
	    	['@name'] = name
	    })
    end
end

function removeStock(pIsim, bool)
    if bool == true then
        MySQL.Async.execute("UPDATE blackmarket_items SET stock = stock - 1 WHERE name = @weaponKey;", {["@weaponKey"] = pIsim}, function(affectedRows)
        end)
    else
        MySQL.Async.execute("UPDATE blackmarket_weapons SET stock = stock - 1 WHERE name = @weaponKey;", {["@weaponKey"] = pIsim}, function(affectedRows)
        end)
    end
end

function canAccess(pHex)
	return MySQL.Sync.fetchScalar('SELECT COUNT(*) FROM blackmarket_allowedusers WHERE `identifier` = @identifier', {
		['@identifier'] = pHex
	})
end