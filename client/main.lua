local QBCore = exports['qb-core']:GetCoreObject()

-- Threads
CreateThread(function()
    for k,v in ipairs(Config.Locations['cariusernamebirdy']) do
		exports.ox_target:addBoxZone({
			name = "carinomortelfon" .. k,
			radius = v.radius,
			coords = v.coords,
			size = v.size,
			debug = v.debug,
			rotation = v.rotation,
			options = {
				{
					icon = "fas fa-shield",
					groups = v.groups,
					label = "Cari Username Birdy",
					distance = 2.0,
					event = 'naufal-searchbirdy:client:CheckUsernameBirdy'
				},
			},
		})
	end
end)

-- Events
RegisterNetEvent('naufal-searchbirdy:client:CheckUsernameBirdy', function()
    local input = lib.inputDialog('Cari Username Birdy', {
		{type = 'input', label = 'Username', description = 'Masukkan Username Birdy', required = true, icon = 'clipboard'},
	})
	if not input or not input[1] then return end

	lib.callback('naufal-searchbirdy:server:callbackcheckusernamebirdy', false, function(data, namadepan, namabelakang, tanggallahir, nomor)
		if data then
			local datanya = {
				{
					title = namadepan .. ' ' .. namabelakang,
					description = 'Nama Pemilik',
					icon = 'person'
				},
				{
					title = tanggallahir,
					description = 'Tanggal Lahir',
					icon = 'person'
				},
				{
					title = tostring(nomor),
					description = 'Nomor Telfon',
					icon = 'person'
				}
			}

			lib.registerContext({
				id = 'ctx_searchusernamebirdy_menu',
				title = 'Data',
				options = datanya
			})
			
			lib.showContext('ctx_searchusernamebirdy_menu')
		else
			QBCore.Functions.Notify('Data tidak ditemukan', 'error')
		end

	end, input[1])
end)