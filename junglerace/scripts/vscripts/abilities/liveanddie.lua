function LiveAndDie( keys )
	local caster = keys.caster
	local ability = keys.ability
	local radius = ability:GetLevelSpecialValueFor("radius", 0)
	local Duration = ability:GetLevelSpecialValueFor("duration", 0)
	
	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, FIND_ANY_ORDER, false )
    if #enemies > 0 then
        for _,enemy in pairs(enemies) do
            --Filters:TakeArgumentsAndApplyDamage(enemy, caster, aoe_damage, DAMAGE_TYPE_MAGICAL, 1)
            enemy:AddNewModifier(caster, nil, "modifier_stunned", {duration = Duration})
            --ability:ApplyDataDrivenModifier(caster, targetUnit, "modifier_stun_explosion", {})
        end
    end 
	
	caster:ForceKill(false)
end