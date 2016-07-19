--[[ Author: Pizzalol
	 Date: 21.12.2014.
	 Checks if there are enemy heroes nearby to determine if it needs to apply Blur]]

function Blur( keys )
	local caster = keys.caster
	local ability = keys.ability

	if ability == nil then
		return
	end

	local casterLocation = caster:GetAbsOrigin()
	local radius = ability:GetLevelSpecialValueFor("radius", (ability:GetLevel() - 1))

	local enemyHeroes = FindUnitsInRadius(caster:GetTeam(), casterLocation, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_CREEP, 0, 0, false)

	if #enemyHeroes>0 then
		if caster:HasModifier("modifier_innocent_blur_enemy_datadriven") then
			caster:RemoveModifierByName("modifier_innocent_blur_enemy_datadriven")
		end
	else
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_innocent_blur_enemy_datadriven", {})
	end
end