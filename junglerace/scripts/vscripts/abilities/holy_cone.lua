function fireCone(args)

	local caster = args.caster
	local ability = args.ability
	local fv = caster:GetForwardVector()
	local origin = caster:GetAbsOrigin()
	local spellOrigin = origin+fv*80
	--A Liner Projectile must have a table with projectile info
	caster.holy_cone_direction = fv
	local info = 
	{
		Ability = args.ability,
        	EffectName = "particles/units/heroes/hero_queenofpain/holy_cone.vpcf",
        	vSpawnOrigin = spellOrigin,
        	fDistance = 1400,
        	fStartRadius = 100,
        	fEndRadius = 400,
        	Source = caster,
        	StartPosition = "attach_attack2",
        	bHasFrontalCone = true,
        	bReplaceExisting = false,
        	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        	fExpireTime = GameRules:GetGameTime() + 10.0,
		bDeleteOnHit = false,
		vVelocity = fv * 1000,
		bProvidesVision = false,
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)

	local modifierKnockback =
	{
		center_x = spellOrigin.x,
		center_y = spellOrigin.y,
		center_z = spellOrigin.z,
		duration = 0.5,
		knockback_duration = 0.5,
		knockback_distance = 200,
		knockback_height = 100,
		should_stun = 0
	}
	caster.cone_velocity = 50
	--caster:RemoveModifierByName("modifier_knockback")
    --caster:AddNewModifier( caster, nil, "modifier_knockback", modifierKnockback );
    --Filters:CastSkillArguments(2, caster)
end

function knockback_interval(keys)
	
	local caster = keys.caster
	local modifier = caster:FindModifierByName("modifier_holy_cone")
	local origin = caster:GetAbsOrigin()
	local fv = caster.holy_cone_direction
	
	if not caster.cone_velocity then
		caster.cone_velocity = 50
	end
	local obstruction = WallPhysics:FindNearestObstruction(origin*Vector(1,1,0))
    local blockUnit = WallPhysics:ShouldBlockUnit(obstruction, origin*Vector(1,1,0))
    -- if blockUnit then
    -- 	caster.cone_velocity = -1
    -- end
	local newPosition = origin-(fv*caster.cone_velocity)
	caster.cone_velocity = math.max(caster.cone_velocity - 4, 0)
	local groundPosition = GetGroundPosition( newPosition, caster )
	if origin.z - groundPosition.z > -200 then
		if not blockUnit then
			if caster.cone_velocity < 2 then
				FindClearSpaceForUnit(caster, groundPosition, false)
			else
				caster:SetAbsOrigin(groundPosition)
			end
		end
	end
end

function modifier_on_destroy(keys)
	local caster = keys.caster
	local origin = caster:GetAbsOrigin()
	FindClearSpaceForUnit(caster, origin, true)
	caster.cone_velocity = nil	
end