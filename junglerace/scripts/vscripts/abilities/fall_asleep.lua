
if fall_asleep == nil then
	fall_asleep = class({})
end

function fall_asleep:OnChannelFinish(failed)
	if failed then
		return
	end

	local caster = self:GetCaster()
	local fDuration = self:GetLevelSpecialValueFor("Duration", self:GetLevel() - 1)
	caster:AddNewModifier(caster, nil, "modifier_stunned", 		{duration = fDuration})
	caster:AddNewModifier(caster, nil, "modifier_invulnerable", 	{duration = fDuration})
end

