function castAnimation(event)
	local caster = event.caster
	StartAnimation(caster, {duration=0.5, activity=ACT_DOTA_CAST_ABILITY_2, rate=1})
end

function createWall(event)
	local caster = event.caster
	local ability = event.ability
	local soundTable = {"leshrac_lesh_deny_14", "leshrac_lesh_deny_15", "leshrac_lesh_deny_16", "leshrac_lesh_deny_12", "leshrac_lesh_deny_12", "leshrac_lesh_deny_10", "leshrac_lesh_deny_10", "leshrac_lesh_deny_06"}
	local point = event.target_points[1]
	EmitSoundOn(soundTable[RandomInt(1, #soundTable)], caster)
	local casterOrigin = caster:GetAbsOrigin()
	local fv = (point-casterOrigin):Normalized()
	local wallLength = event.wallLength
	local duration = event.duration
	local ninetyDegrees = WallPhysics:rotateVector(fv, math.pi/2)
	local wallPoint1 = point - ninetyDegrees*wallLength/2
	local wallPoint2 = point + ninetyDegrees*wallLength/2
	local particle = "particles/units/heroes/hero_dark_seer/leshrac_wallof_replica.vpcf"
	local pfx2 = ParticleManager:CreateParticle( particle, PATTACH_CUSTOMORIGIN, caster )

	ParticleManager:SetParticleControl( pfx2, 0, wallPoint1 )
	ParticleManager:SetParticleControl( pfx2, 1, wallPoint2 )

	local obstructionTable = {}
	local loopCount = WallPhysics:round(-wallLength/200, 0)
	local reduceLoop = 0

	if wallLength%50 == 0 then
		reduceLoop = 1
	end

	EmitSoundOnLocationWithCaster(point, "Hero_Luna.Eclipse.NoTarget", caster)
	EmitSoundOnLocationWithCaster(point, "Hero_Luna.Eclipse.NoTarget", caster)
	ability.wallCenter = point
	ability.ninetyDegrees = ninetyDegrees
	ability.wallLength = wallLength
	for i = loopCount, -loopCount-reduceLoop, 1 do
		local obstructionPoint = point+ninetyDegrees*i*100
		local obstruction = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = obstructionPoint, Name ="wallObstruction"})
		ability:ApplyDataDrivenThinker(caster, obstructionPoint, "modifier_leshrac_wall_thinker", {})
		ability:ApplyDataDrivenThinker(caster, obstructionPoint, "modifier_leshrac_self_finder", {})
		table.insert(obstructionTable, obstruction)
		--AddFOWViewer(caster:GetTeamNumber(), obstructionPoint, 250, 8, false)
	end
	
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx2, false)
		for k,obstruction in pairs(obstructionTable) do
			UTIL_Remove(obstruction)
		end
	end)	
	--Filters:CastSkillArguments(1, caster)
end