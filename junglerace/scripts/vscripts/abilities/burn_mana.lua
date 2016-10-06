
if burn_mana == nil then
	burn_mana = class({})
end

function burn_mana:OnChannelFinish(failed)
	if failed then
		return
	end

	local caster = self:GetCaster()
	local fDuration = self:GetLevelSpecialValueFor("stun_duration", self:GetLevel() - 1)
	local fRadius = self:GetLevelSpecialValueFor("radius", self:GetLevel() - 1)
	
	local pickedUnits = FindUnitsInRadius(
					caster:GetTeamNumber(),
                              	caster:GetAbsOrigin(),
                              	nil,
                              	fRadius,
                              	DOTA_UNIT_TARGET_TEAM_ENEMY,
                              	DOTA_UNIT_TARGET_ALL,
                              	DOTA_UNIT_TARGET_FLAG_MANA_ONLY + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
                              	FIND_ANY_ORDER,
                              	false)
                              	
	local killCaster = false
                   
       --print("Picked units:")
                   
       for _,unit in pairs(pickedUnits) do
       	--print(unit:GetUnitName())
		if (unit:GetMana() > 0) then
			killCaster = true
		end
	end
	
	if killCaster then
		local damage_table = {}
		damage_table.attacker = caster
		damage_table.victim = caster
		damage_table.damage_type = DAMAGE_TYPE_PURE
		damage_table.ability = self
		damage_table.damage = 999999
		damage_table.damage_flags = DOTA_DAMAGE_FLAG_HPLOSS -- Doesnt trigger abilities and items that get disabled by damage

		ApplyDamage(damage_table)
		
		for _,unit in pairs(pickedUnits) do
			unit:SetMana(0.0)
		end
		
	else
		for _,unit in pairs(pickedUnits) do
			--print("stun "..unit:GetUnitName())
			unit:AddNewModifier(caster, nil, "modifier_stunned", 		{duration = fDuration})
		end
	end
end


