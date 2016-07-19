--require('junglerace/jr_death')


function jr_player_disconected( plId )
	local data = {}
	data.id = plId
	CustomGameEventManager:Send_ServerToAllClients( "jr_player_disconnected", data )
	print("[JUNGLERACE] Player "..plId.." leaved")
end

function jr_player_reconnected( plId )
	local data = {}
	data.id = plId
	CustomGameEventManager:Send_ServerToAllClients( "jr_player_reconnected", data )
	local data2 = {}
	data2.laps = Maximum_Laps
	CustomGameEventManager:Send_ServerToAllClients( "update_max_laps", data2 )
	SomeUnitDied(PlayerCurrHeroes[plId])
	print("[JUNGLERACE] Player "..plId.." reconnected")
end

--[[
function jr_start_recreation_timer()
	Timers:CreateTimer(30, jr_recreation_timer)
end

-- Таймер переодически создающий героев заново для тех, кто ливнул и зареконектился
function jr_recreation_timer(  )


	return 30
end
]]

function jr_some_player_leaved(  )
	for i = 0, MAXIMUM_PLAYERS do
		if not PlayerResource:IsValidPlayer(i) and Players_state[i] == 1 then
			Players_state[i] = 2
			jr_player_disconected(i)
		end
	end
end