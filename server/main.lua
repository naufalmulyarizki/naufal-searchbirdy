local QBCore = exports['qb-core']:GetCoreObject()

-- Callback
lib.callback.register('naufal-searchbirdy:server:callbackcheckusernamebirdy', function(source, username)
	local result = MySQL.query.await('SELECT phone_number FROM phone_twitter_accounts WHERE username = ?', {
		username
	})

    if result[1] then
        local result2 = MySQL.query.await('SELECT owner_id FROM phone_phones WHERE phone_number = ?', {
            result[1].phone_number
        })

        if result2[1] then
            local result3 = QBCore.Functions.GetPlayerByCitizenId(result2[1].owner_id) or QBCore.Functions.GetOfflinePlayerByCitizenId(result2[1].owner_id)
            if not result3 then return false end

            local namadepan = result3.PlayerData.charinfo.firstname
            local namabelakang = result3.PlayerData.charinfo.lastname
            local tanggallahir = result3.PlayerData.charinfo.birthdate
            local nomorhp = result[1].phone_number
            return true, namadepan, namabelakang, tanggallahir, nomorhp
        else
            return false
        end
    else
        return false
    end
end)