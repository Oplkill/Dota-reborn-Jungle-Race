

function AddAbilities(unit, randomUnitId)
	if UnitAbils[randomUnitId] == nil then
		return
	end
	
	if randomUnitId == 8 then
		AddAbils_MagistrYoba(unit, randomUnitId)
	elseif randomUnitId == 12 then
		AddAbils_Jakiro(unit, randomUnitId)
	else
		AddAllAbils(unit, randomUnitId)
	end
end

function AddAllAbils(hero, randomUnitId)
	for i = 1, #UnitAbils[randomUnitId] do
		local abil = hero:AddAbility(UnitAbils[randomUnitId][i])
		abil:SetLevel(1)
	end
end

------------------Jakiro
function AddAbils_Jakiro(unit, randomUnitId)
	local IceOrFire = math.random(3)
	
	local abil = nil
	
	if IceOrFire == 1 then
		abil = unit:AddAbility(UnitAbils[randomUnitId][1])
		abil:SetLevel(1)
		abil = unit:AddAbility(UnitAbils[randomUnitId][2])
		abil:SetLevel(1)
	else
		abil = unit:AddAbility(UnitAbils[randomUnitId][3])
		abil:SetLevel(1)
		abil = unit:AddAbility(UnitAbils[randomUnitId][4])
		abil:SetLevel(1)
	end
end

------------------Magistr YOBA
function AddAbils_MagistrYoba(hero, randomUnitId)
	local number_abils = math.random(5)
	
	if number_abils == 0 then
		return
	end
	
	for i = 1, number_abils do
		local abilId = math.random(#UnitAbils[randomUnitId])
		local abilName = UnitAbils[randomUnitId][abilId]
		
		if hero:HasAbility(abilName) then
			i = i - 1
		else
			local abil = hero:AddAbility(abilName)
			abil:SetLevel(1)
		end
	end
end

