function mage_mana_leak_think(event)
	local target = event.target
	local ability = event.ability
	local caster = event.caster
	if not target.manaLeakPos then
		target.manaLeakPos = target:GetAbsOrigin()
	end
	if not target.manaLeakdistanceMoved then
		target.manaLeakdistanceMoved = 0
	end
	target.newManaLeakPos = target:GetAbsOrigin()
	local distance = WallPhysics:GetDistance(target.newManaLeakPos,target.manaLeakPos)
	target.manaLeakdistanceMoved = target.manaLeakdistanceMoved + distance
	if target.manaLeakdistanceMoved > event.leak_distantion then
		for i = 1, target.manaLeakdistanceMoved/event.leak_distantion, 1 do 
			target:ReduceMana(target:GetMaxMana()*0.03)
			local particleName = "particles/units/heroes/hero_keeper_of_the_light/keeper_mana_leak_impact_bits.vpcf"
			local pfx = ParticleManager:CreateParticle( particleName, PATTACH_CUSTOMORIGIN, target )
			ParticleManager:SetParticleControlEnt(pfx, 0, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(pfx, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
			Timers:CreateTimer(0.5, function() 
			  ParticleManager:DestroyParticle( pfx, false )
			end) 	
			if target:GetMana() <= 0 then
				target:AddNewModifier(caster, nil, "modifier_stunned", {duration = event.stun_duration})
				EmitSoundOn("Hero_KeeperOfTheLight.ManaLeak.Stun", target)
			end
			if i > 2 then
				break
			end
		end
		target.manaLeakdistanceMoved =target.manaLeakdistanceMoved%event.leak_distantion
	end
	target.manaLeakPos = target:GetAbsOrigin()
end