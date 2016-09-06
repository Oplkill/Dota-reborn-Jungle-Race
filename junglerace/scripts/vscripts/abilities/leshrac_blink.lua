
function HideCaster( event )
    event.caster:AddNoDraw()
    event.caster:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
    local position = event.caster:GetAbsOrigin()
    local caster = event.caster
    local fv = event.caster:GetForwardVector()
    local ability = event.ability
    local duration = event.duration
    event.caster.newPosition =  position
    -- local pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_undying/undying_loadout.vpcf", PATTACH_ABSORIGIN, event.caster )
    --     ParticleManager:SetParticleControl( pfx, 0, position )
    --local newPosition = WallPhysics:WallSearch(position, event.caster.newPosition)
    --[[local newPosition = nil
    local plId = PlayerIdByTeam[caster:GetTeamNumber()]
    if Player_Half_Lap[plId] then
		event.caster.newPosition = SpawnPoints[2]
	else
		event.caster.newPosition = SpawnPoints[1]
	end]]
	local newPosition = event.caster.newPosition
    --AddFOWViewer(caster:GetTeamNumber(), newPosition, 250, 1.8, false)
    --Filters:CastSkillArguments(3, event.caster)
	local particle = "particles/econ/items/sven/sven_cyclopean_marauder/leshrac_grow_effect.vpcf"
	local pfx = ParticleManager:CreateParticle( particle, PATTACH_CUSTOMORIGIN, caster )
	caster:SetAbsOrigin(caster:GetAbsOrigin() -Vector(0,0,140) )
	ParticleManager:SetParticleControlEnt( pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
	end)

	local dummy = CreateUnitByName("npc_dummy_unit", newPosition, false, nil, nil, DOTA_TEAM_NEUTRALS)
	dummy:AddAbility("dummy_unit"):SetLevel(1)
	dummy:NoHealthBar()
	dummy:SetForwardVector(fv)
	local particle = "particles/econ/items/sven/sven_cyclopean_marauder/leshrac_shrink_effect.vpcf"
	Timers:CreateTimer(duration-1.5, function()
		local pfx2 = ParticleManager:CreateParticle( particle, PATTACH_CUSTOMORIGIN, dummy )
		ParticleManager:SetParticleControlEnt( pfx2, 0, dummy, PATTACH_POINT_FOLLOW, "attach_hitloc", newPosition, true )
		Timers:CreateTimer(1.5, function()
			ParticleManager:DestroyParticle(pfx2, false)
			UTIL_Remove(dummy)
		end)	
	end)	
	
	EmitSoundOn("leshrac_lesh_pain_05", caster)

	Timers:CreateTimer(duration-0.1, function()
		FindClearSpaceForUnit(event.caster, newPosition, false)
		--caster:SetOrigin(newPosition)
	end)
	Timers:CreateTimer(0.25, function()
		EmitSoundOn("Hero_Terrorblade.Reflection", caster)
	end)
	-- StartAnimation(caster, {duration=2, activity=ACT_DOTA_CAST_ABILITY_1, rate=0.9})
	caster:RemoveModifierByName("modifier_pulse_slow")
	caster:RemoveModifierByName("modifier_bahamut_pulse_on")
	local bufs = caster:FindAllModifiers()
	if bufs then
		for k,buf in pairs(bufs) do
			if buf:IsDebuff() then
				caster:RemoveModifierByName(buf:GetEffectName())
			end
		end
	end
end

function ShowCaster( event )
	local caster = event.caster
	local position = caster:GetAbsOrigin()
	local duration = event.duration
	EmitSoundOn("leshrac_lesh_anger_05", event.caster)
	EmitSoundOn("Hero_Terrorblade.Reflection", caster)
    event.caster:RemoveNoDraw()
    event.caster:SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
    StartAnimation(event.caster, {duration=0.2, activity=ACT_DOTA_TELEPORT_END, rate=3})

   	local particle = "particles/units/heroes/hero_chen/chen_teleport_flash.vpcf"
	local pfx2 = ParticleManager:CreateParticle( particle, PATTACH_CUSTOMORIGIN, caster )
	FindClearSpaceForUnit(caster, position, false)
	ParticleManager:SetParticleControl( pfx2, 0, position )
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx2, false)
	end)
	caster:SetMana(caster:GetMaxMana())
	caster:SetHealth(caster:GetMaxHealth())
end