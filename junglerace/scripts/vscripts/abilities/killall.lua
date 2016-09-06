function KillAllEndChannel( keys )
	local caster = keys.caster
	local abil = keys.ability

	--print("[DEBUG KILL all] caster is - "..caster:GetUnitName().."   and his team is - "..caster:GetTeamNumber())

	local direUnits = FindUnitsInRadius(caster:GetTeamNumber(),
                              Vector(0, 0, 0),
                              nil,
                              FIND_UNITS_EVERYWHERE,
                              DOTA_UNIT_TARGET_TEAM_ENEMY,
                              DOTA_UNIT_TARGET_ALL,
                              DOTA_UNIT_TARGET_FLAG_NONE,
                              FIND_ANY_ORDER,
                              false)
 
	for _,unit in pairs(direUnits) do
		--print("[DEBUG KILL all] catched unit - "..unit:GetUnitName())

	    local damage_table = {}

		damage_table.attacker = caster
		damage_table.victim = unit
		damage_table.damage_type = DAMAGE_TYPE_PURE
		damage_table.ability = abil
		damage_table.damage = 999999
		damage_table.damage_flags = DOTA_DAMAGE_FLAG_HPLOSS -- Doesnt trigger abilities and items that get disabled by damage

		ApplyDamage(damage_table)
	end
end
