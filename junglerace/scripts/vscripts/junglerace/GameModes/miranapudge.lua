require('junglerace/jr_utils')


MiranaPudgePoints = {}		-- spawn points [1] - Mirana, [2] - pudge
MiranaPudgeUnits = {}		-- [1] - Mirana, [2] - Pudge
MiranaAttackCooldown = 20
PudgeAttackCooldown = 25



function gmMiranaPudgeInit(  )
	GM["MiranaPudge"] = false

	print("[JUNGLE RACE] Gamemode MiranaPudge inited")
end


function gmMiranaPudgeInGameInit(  )
	MiranaPudgePoints[1] = Entities:FindByName( nil, "MiranaSpawn" ):GetAbsOrigin()
	MiranaPudgePoints[2] = Entities:FindByName( nil, "PudgeSpawn" ):GetAbsOrigin()
end

function gmMiranaPudgeGameStarted(  )
	if not GM["MiranaPudge"] then
		return
	end

	MiranaPudgeUnits[1] = CreateUnitByName( "unit_gm_mirana", MiranaPudgePoints[1], true, nil, nil, DOTA_TEAM_BADGUYS )
	FindClearSpaceForUnit(MiranaPudgeUnits[1], MiranaPudgePoints[1], false)
	MiranaPudgeUnits[1]:AddNewModifier(MiranaPudgeUnits[1], nil, "modifier_invulnerable", {})
	Timers:CreateTimer(MiranaAttackCooldown, gmMP_MiranaAttack)

	MiranaPudgeUnits[2] = CreateUnitByName( "unit_gm_pudge", MiranaPudgePoints[2], true, nil, nil, DOTA_TEAM_BADGUYS )
	FindClearSpaceForUnit(MiranaPudgeUnits[2], MiranaPudgePoints[2], false)
	MiranaPudgeUnits[2]:AddNewModifier(MiranaPudgeUnits[2], nil, "modifier_invulnerable", {})
	Timers:CreateTimer(PudgeAttackCooldown, gmMP_PudgeAttack)
end

function gmMP_MiranaAttack(  )
	local point = GetPointRandomUnit(MiranaPudgeUnits[1])

	if point == nil then
		return 4
	end

	MiranaPudgeUnits[1]:CastAbilityOnPosition(point, MiranaPudgeUnits[1]:FindAbilityByName("gm_mirana_arrow"), 0)
	--print("[JUNGLE RACE] Mirana attack now")
	return MiranaAttackCooldown
end

function gmMP_PudgeAttack(  )
	local point = GetPointRandomUnit(MiranaPudgeUnits[2])

	if point == nil then
		return 4
	end

	MiranaPudgeUnits[2]:CastAbilityOnPosition(point, MiranaPudgeUnits[2]:FindAbilityByName("gm_pudge_hook"), 0)
	--print("[JUNGLE RACE] Pudge attack now")
	return PudgeAttackCooldown
end