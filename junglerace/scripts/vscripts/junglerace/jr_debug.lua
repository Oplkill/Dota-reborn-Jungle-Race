


function deb_create_enemies(  )
	local point = Entities:FindByName( nil, "SpawnLap1"):GetAbsOrigin()
	local point2 = Entities:FindByName( nil, "SpawnLap2"):GetAbsOrigin()

	--local unit1 = CreateUnitByName( "unit_skeleton", point + RandomVector( RandomFloat( 100, 200 ) ), true, nil, nil, DOTA_TEAM_BADGUYS )
	local unit1 = CreateUnitByName( "unit_alchemist", point + RandomVector( RandomFloat( 100, 200 ) ), true, nil, nil, DOTA_TEAM_BADGUYS )
	local unit2 = CreateUnitByName( "unit_centaur", point + RandomVector( RandomFloat( 100, 200 ) ), true, nil, nil, DOTA_TEAM_BADGUYS )
	local abil = nil
	abil = unit1:AddAbility("tiredness_aura")
	abil:SetLevel(1)
	--abil = unit2:AddAbility("jakiro_ice_path")
	--abil:SetLevel(1)
	--abil = unit2:AddAbility("jakiro_fire_path")
	--abil:SetLevel(1)
	--abil = unit1:AddAbility("super_mana_all_aura")
	--abil:SetLevel(1)
	

	Timers:CreateTimer(9, function()
		unit2:MoveToPosition(point2)
		--unit1:MoveToPosition(point2)
		--unit1:CastAbilityNoTarget(abil, DOTA_TEAM_BADGUYS)
		--local unit3 = CreateUnitByName( "npc_dota_hero_razor", point + RandomVector( RandomFloat( 100, 200 ) ), true, nil, nil, DOTA_TEAM_CUSTOM_1  )
		--abil = unit3:AddAbility("Unstable_Current")
		--abil:SetLevel(1)
		--unit1:SetControllableByPlayer(plId, true)
	end)
end