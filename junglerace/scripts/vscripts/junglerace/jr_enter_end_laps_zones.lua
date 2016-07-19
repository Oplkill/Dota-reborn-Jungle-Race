require('junglerace/jr_globals')
require('junglerace/jr_create_units')
require('junglerace/jr_debug')


-- Unit enter EndLap1
function UnitEnterFirstLapZone(event)
	local unit = event.activator

	UnitEnterZone(unit, false)
end

-- Unit enter EndLap2
function UnitEnterSecondLapZone(event)
	local unit = event.activator
	
	UnitEnterZone(unit, true)
end

function UnitEnterZone( unit, giveLap )
	local plId = PlayerIdByTeam[unit:GetTeamNumber()]

	if unit:GetUnitName() == PlayerCurrHeroes[plId] and unit:IsAlive() then
		Player_Half_Lap[plId] = not giveLap
		if giveLap then
			Player_Laps[plId] = Player_Laps[plId] + 1

			local data = {}
			data.id = plId
			data.laps = Player_Laps[plId]
			data.teamid = PlayerResource:GetTeam(plId)
			data.laps_remaining = Maximum_Laps - Player_Laps[plId]
			CustomGameEventManager:Send_ServerToAllClients( "jr_player_reach_end", data )
			
			if Player_Laps[plId] >= Maximum_Laps then
				GameOverWinnersToPedestals(plId)
				return
			end
		end

		--CreateNewHero(PlayerResource:GetPlayer(plId))
	end

	if unit:HasAbility("phoenix_supernova") then
		unit:RemoveAbility("phoenix_supernova")
	end
	unit:AddNoDraw()
	unit:ForceKill(true)
end

function GameOverWinnersToPedestals(winnerId)
	GameRules:SetSafeToLeave( true )
	GameRules:SetGameWinner( PlayerResource:GetTeam(winnerId) )
end