require('junglerace/jr_globals')
require('music_player_new')
require('junglerace/jr_debug')
require('junglerace/GameModes/miranapudge')
require('junglerace/GameModes/notrecurringrandom')

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

	print("[JUNGLERACE] Player "..plId.." spawned hero")
	--MusicPlayer:AttachMusicPlayer( player )
	--player:PlayMusic()
	
	WaitRoundStarted()
end


function WaitRoundStarted()
	if RoundStarted then
		return
	end
	RoundStarted = true

	--Init points
	SpawnPoints[1] = Entities:FindByName( nil, "SpawnLap1" ):GetAbsOrigin()
	SpawnPoints[2] = Entities:FindByName( nil, "SpawnLap2" ):GetAbsOrigin()

	FinishPoints[1] = Entities:FindByName( nil, "FirstPlace" ):GetAbsOrigin()
	FinishPoints[2] = Entities:FindByName( nil, "SecondPlace" ):GetAbsOrigin()
	FinishPoints[3] = Entities:FindByName( nil, "ThirdPlace" ):GetAbsOrigin()
	----------------------------------

	gmMiranaPudgeInGameInit()
	gmNotRecurringRandomInGameInit()
	
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
			end)
		end)
    end)
	Timers:CreateTimer(10, GameRoundStarted)
	
	
	Convars:RegisterCommand( "PlayerSelectedHero", function(name)
		local cmdPlayer = Convars:GetCommandClient()
		--print("11111111111Player id = "..cmdPlayer:GetPlayerID())
		if GameStarted and CurrentPlayerUnit[cmdPlayer:GetPlayerID()] == nil then
			CreateNewHero(cmdPlayer)
		end
	end, "", 0 )
end


function GameRoundStarted()
	print("[JUNGLERACE] Game started")
	ChatKillMessage("Game started!")
	
	GameStarted = true

	for i = 0, MAXIMUM_PLAYERS do
		if PlayerCurrHeroes[i] ~= nil then --todo заменить на проверку онлайна
			CreateNewHero(PlayerResource:GetPlayer(i))
		end
    end

    --------------------
    gmMiranaPudgeGameStarted()
    --------------------

    if DEBUG then
		deb_create_enemies()
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








