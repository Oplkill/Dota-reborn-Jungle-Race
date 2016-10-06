require('junglerace/jr_utils')


NotRecurringRandomGlobal = false	-- false - local for each player. true - global
PlayersNotRecurringRandom = {}	-- each player random Array
PlayersNotRecurringI = {}		-- Current I in players array
NotRecurringGlobalRandom = {}	-- global random Array
NotRecurringGlobalI = 1			-- Current I in global array



function gmNotRecurringRandomInit(  )
	GM["NotRecurringRandom"] = false
end

function gmNotRecurringRandomSet( modeId )
	if modeId == 2 then
		NotRecurringRandomGlobal = true
	end

	print("[JUNGLE RACE] Gamemode NotRecurringRandom setted to "..modeId)
end

function gmNotRecurringRandomInGameInit(  )
	if not GM["NotRecurringRandom"] then
		return
	end

	for i = 0, MAXIMUM_PLAYERS do
		PlayersNotRecurringRandom[i] = {}
		PlayersNotRecurringI[i] = 1
		for j = 1, MAXIMUM_RANDOM_HEROES do
			PlayersNotRecurringRandom[i][j] = j
		end
		PlayersNotRecurringRandom[i] = ScrambleArray(PlayersNotRecurringRandom[i], MAXIMUM_RANDOM_HEROES)
    end

    for i = 1, MAXIMUM_RANDOM_HEROES do
		NotRecurringGlobalRandom[i] = i
    end
    NotRecurringGlobalRandom = ScrambleArray(NotRecurringGlobalRandom, MAXIMUM_RANDOM_HEROES)

    print("[JUNGLE RACE] Gamemode NotRecurringRandom inited")
end

function gmGetRandomUnitId( plId )
	local id = 1

	if NotRecurringRandomGlobal then
		id = NotRecurringGlobalRandom[NotRecurringGlobalI]
		
		if NotRecurringGlobalI == MAXIMUM_RANDOM_HEROES then
			NotRecurringGlobalI = 1
			NotRecurringGlobalRandom = ScrambleArray(NotRecurringGlobalRandom, MAXIMUM_RANDOM_HEROES)
		else
			NotRecurringGlobalI = NotRecurringGlobalI + 1
		end
	else
		id = PlayersNotRecurringRandom[plId][PlayersNotRecurringI[plId]]

		if PlayersNotRecurringI[plId] == MAXIMUM_RANDOM_HEROES then
			PlayersNotRecurringI[plId] = 1
			PlayersNotRecurringRandom[plId] = ScrambleArray(PlayersNotRecurringRandom[plId], MAXIMUM_RANDOM_HEROES)
		else
			PlayersNotRecurringI[plId] = PlayersNotRecurringI[plId] + 1
		end
	end



	return id
end