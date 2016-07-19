require('junglerace/jr_globals')
require('music_player_new')
require('junglerace/jr_debug')

RoundStarted = false

PlayerAlreadySpawnedOnce = {}

function HeroesSpawnedOnce(hero, player)
	local plId = player:GetPlayerID()

	if PlayerAlreadySpawnedOnce[plId] == true then
		return
	end
	
	GameRules:SetHideKillMessageHeaders( true )
	
	PlayerAlreadySpawnedOnce[plId] = true
	hero:AddNoDraw()
	hero:AddNewModifier(nil, nil, "modifier_invulnerable", nil)
	PlayerCurrHeroes[plId] = hero:GetUnitName()
	Players_state[plId] = 1
	--print("[JUNGLERACE] Player("..plId..") ONCE spawned")
	--MusicPlayer:AttachMusicPlayer( player )
	--player:PlayMusic()
	
	WaitRoundStarted()
end


function WaitRoundStarted()
	if RoundStarted then
		return
	end
	RoundStarted = true
	
	CountingPlayersVotes()
	
	rightTeamIds = {}
	rightTeamIds[DOTA_TEAM_GOODGUYS] 	= 1
	rightTeamIds[DOTA_TEAM_BADGUYS] 	= 2
	rightTeamIds[DOTA_TEAM_CUSTOM_1] 	= 3
	rightTeamIds[DOTA_TEAM_CUSTOM_2] 	= 4
	rightTeamIds[DOTA_TEAM_CUSTOM_3] 	= 5
	rightTeamIds[DOTA_TEAM_CUSTOM_4] 	= 6
	rightTeamIds[DOTA_TEAM_CUSTOM_5] 	= 7
	rightTeamIds[DOTA_TEAM_CUSTOM_6] 	= 8
	rightTeamIds[DOTA_TEAM_CUSTOM_7] 	= 9
	rightTeamIds[DOTA_TEAM_CUSTOM_8] 	= 10
	
	for i = 0, MAXIMUM_PLAYERS do
		local teamid = PlayerResource:GetTeam(i)

		PlayerIdByTeam[teamid] = i

		data = {}
		data.id = i
		data.teamid = rightTeamIds[teamid]
		data.playing = PlayerResource:IsValidPlayer(i)
		CustomGameEventManager:Send_ServerToAllClients( "jr_init_player", data )
	end
	
	print("[JUNGLERACE] Wait round started")
	ChatKillMessage("Wait 10 secs to start game...")
	Timers:CreateTimer(7, function()
		ChatKillMessage("3...")
		Timers:CreateTimer(1, function()
			ChatKillMessage("2...")
			Timers:CreateTimer(1, function()
				ChatKillMessage("1...")

				if DEBUG then
					deb_create_enemies()
				end
			end)
		end)
    end)
	Timers:CreateTimer(10, GameRoundStarted)
end


function GameRoundStarted()
	print("[JUNGLERACE] Game started")
	ChatKillMessage("Game started!")
	
	for i = 0, MAXIMUM_PLAYERS do
		if PlayerCurrHeroes[i] ~= nil then --todo заменить на проверку онлайна
			CreateNewHero(PlayerResource:GetPlayer(i))
			XP_PER_LEVEL_TABLE = {}
			for i=1,100, 1 do
			  if i <= 5 then
			  	XP_PER_LEVEL_TABLE[i] = ((i-1)*(120+(i-1)*(120))/2)
			  elseif i <= 15 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(i-5)*500
			  elseif i <= 25 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(500*10)+(i-15)*2000
			  elseif i <= 35 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(500*10)+(2000*10)+(i-25)*3000
			  elseif i <= 50 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(500*10)+(2000*10)+(3000*15)+(i-35)*10000
			  elseif i <= 60 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(500*10)+(2000*10)+(3000*15)+(10000*10)+(i-50)*15000
			  elseif i <= 70 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(500*10)+(2000*10)+(3000*15)+(10000*10)+(15000*10)+(i-60)*25000
			  elseif i <= 80 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(500*10)+(2000*10)+(3000*15)+(10000*10)+(15000*10)+(25000*10)+(i-70)*35000
			  elseif i <= 90 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(500*10)+(2000*10)+(3000*15)+(10000*10)+(15000*10)+(25000*10)+(35000*10)+(i-80)*50000
			  	print(i.."====="..XP_PER_LEVEL_TABLE[i])
			  elseif i <= 100 then
			  	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+(120*5)+(500*10)+(2000*10)+(3000*15)+(10000*10)+(15000*10)+(25000*10)+(35000*10)+(50000*10)+(i-90)*100000
			  end
			  --CustomNetTables:SetTableValue("xp_table", tostring(i), {xpNeeded = XP_PER_LEVEL_TABLE[i]} )
			end
		end
    end
end


function ChatKillMessage(message)
	GameRules:SendCustomMessage(message, 0, 0)
	--GameRules:SendCustomMessage("<font color='#58ACFA'>This is some Blue Text</font> This is white", 0, 0)
end

function CountingPlayersVotes()
	local i = 0
	local summ = 0
	local laps = 0
	for key, val in next, Player_Lap_Votes do
		if val ~= nil then
			summ = summ + val
			i = i + 1
		end
	end
	
	if summ > 0 then
		laps = summ / i
	else
		laps = 5
	end
	
	Maximum_Laps = math.floor(laps)
	ChatKillMessage("Need laps to finish is - "..Maximum_Laps)
	local data = {}
	data.laps = Maximum_Laps
	CustomGameEventManager:Send_ServerToAllClients( "update_max_laps", data )
	
	--print('[DEBUG] i='..i..'   summ='..summ..'     laps='..Maximum_Laps)
	
end








