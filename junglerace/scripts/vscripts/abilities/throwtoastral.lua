function ThrowToAstral( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel() - 1))
	
	target:AddNoDraw()
	target:AddNewModifier(nil, nil, "modifier_stunned", nil)
	target:AddNewModifier(nil, nil, "modifier_invulnerable", nil)
	
	Timers:CreateTimer(duration, function()
		target:RemoveNoDraw()
		target:RemoveModifierByName("modifier_stunned")
		target:RemoveModifierByName("modifier_invulnerable")
    end)
	
	print("[DEBUG] Spell start")
end