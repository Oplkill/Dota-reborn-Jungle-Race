require('junglerace/jr_create_units')
require('junglerace/jr_debug')


function SomeUnitDied(unit)
	--local pl = unit:GetPlayerOwner()
	--local plId = pl:GetPlayerID()
	local plId = PlayerIdByTeam[unit:GetTeamNumber()]

	--print("--------------------------------Some unit died plId="..plId)
	
	--if unit:GetUnitName() == "unit_phoenix" then
	if unit:HasAbility("phoenix_supernova") then
		Phoenix_died(unit, plId)
	else
		ContinueCreateUnit(unit, plId)
	end

	if DEBUG then
		deb_create_enemies()
	end
end

function ContinueCreateUnit( unit, plId )
	--print("Name="..unit:GetUnitName().." == "..PlayerCurrHeroes[plId])

	if unit:GetUnitName() == PlayerCurrHeroes[plId] then
		CreateNewHero(PlayerResource:GetPlayer(plId))
	end
end



function Phoenix_died( unit, plId )
	local abil = unit:FindAbilityByName("phoenix_supernova")

	if abil:GetLevel() < 4 then
		local point = unit:GetAbsOrigin()
		
		abil:SetLevel(abil:GetLevel() + 1)
		unit:RespawnUnit()
		unit:SetAbsOrigin( point )
		
		Timers:CreateTimer(0.3, function()
			unit:CastAbilityNoTarget(abil, plId)
		end)
	else
		ContinueCreateUnit(unit, plId)
	end
end
