require('junglerace/jr_globals')
require('junglerace/jr_player_dis_connect')
require('junglerace/jr_add_abils')


function CreateNewHero(player)
	
	if player==nil then
		--jr_some_player_leaved()
		return
	end
	
	local pl_id = player:GetPlayerID()
	local point = nil
	--print("[DEBUG] plId = "..pl_id)

	if PlayerResource:GetConnectionState(player:GetPlayerID()) == 3 then
		
	end
	
	if Player_Half_Lap[pl_id] then
		point = Entities:FindByName( nil, "SpawnLap2"):GetAbsOrigin()
	else
		point = Entities:FindByName( nil, "SpawnLap1"):GetAbsOrigin()
	end
	
	local randomUnitId = TESTCHOOSEHERO
	if TESTCHOOSEHERO == -1 then
		randomUnitId = math.random(MAXIMUM_RANDOM_HEROES)
	end
	local newUnitClass = Random_Heroes[randomUnitId]
	
	local unitnew = CreateUnitByName( newUnitClass, point, true, nil, nil, PlayerResource:GetTeam(pl_id) )
	unitnew:SetControllableByPlayer(pl_id, true)
	FindClearSpaceForUnit(unitnew, point, false)
	AddAbilities(unitnew, randomUnitId)
	PlayerResource:SetCameraTarget(pl_id, unitnew)
	Timers:CreateTimer(0.1, function()
			PlayerResource:SetCameraTarget(pl_id, nil)
		end)

    CustomGameEventManager:Send_ServerToPlayer(player, "add_to_selection", { ent_index = unitnew:GetEntityIndex() })

	--print('[JungleRace] Created new hero ----------------------------'..newUnitClass)
	PlayerCurrHeroes[pl_id] = unitnew:GetUnitName()
	
	if randomUnitId == 15 then -- cheater mana 0
		unitnew:SetMana(0.0)
	end
	
	data = {}
	data.id = pl_id
	data.heroname = RealHeroNames[randomUnitId]
	data.heroentid = unitnew:GetEntityIndex()
	CustomGameEventManager:Send_ServerToAllClients( "jr_update_hero", data )
	
	--oldHero:ForceKill(true)
end
