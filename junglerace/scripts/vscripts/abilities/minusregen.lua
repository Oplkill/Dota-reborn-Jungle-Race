function MinusRegen( keys )
	local caster = keys.caster
	local ability = keys.ability

	if ability == nil then
		return
	end

	local aura_damage = ability:GetLevelSpecialValueFor("aura_damage", (ability:GetLevel() - 1))
	local aura_damage_interval = ability:GetLevelSpecialValueFor("aura_damage_interval", (ability:GetLevel() - 1))

	local damage_table = {}

	damage_table.attacker = caster
	damage_table.victim = caster
	damage_table.damage_type = DAMAGE_TYPE_PURE
	damage_table.ability = ability
	damage_table.damage = -aura_damage * aura_damage_interval
	damage_table.damage_flags = DOTA_DAMAGE_FLAG_HPLOSS -- Doesnt trigger abilities and items that get disabled by damage

	ApplyDamage(damage_table)
end