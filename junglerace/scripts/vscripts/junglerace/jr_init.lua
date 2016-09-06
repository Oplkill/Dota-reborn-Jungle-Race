require('junglerace/GameModes/miranapudge')


function InitJungleRaceGame()
	
	GameRules:SetHideKillMessageHeaders( true )
	
	for i = 0, MAXIMUM_PLAYERS do
	
		Player_Laps[i] = 0
		Player_Half_Lap[i] = false
		Players_state[i] = 0
		CurrentPlayerUnit[i] = nil
    end
	
	--Init heroes
	Random_Heroes[1] = "unit_sniper"	-- Sniper
	RealHeroNames[1] = "sniper"
	
	Random_Heroes[2] = "unit_druidka"	-- Druidka
	RealHeroNames[2] = "viper"
	
	Random_Heroes[3] = "unit_centaur"	-- A mne na vse poh
	RealHeroNames[3] = "centaur"
	
	Random_Heroes[4] = "unit_arhimond"	-- Arhimond
	RealHeroNames[4] = "ember_spirit"
	
	Random_Heroes[5] = "unit_astralizator"	-- astralizator
	RealHeroNames[5] = "spirit_breaker"
	
	Random_Heroes[6] = "unit_doom"	-- Doom
	RealHeroNames[6] = "doom_bringer"
	
	Random_Heroes[7] = "unit_alchemist"	-- Alchemist
	RealHeroNames[7] = "alchemist"
	
	Random_Heroes[8] = "unit_yoba"	-- Magistr YoBa
	RealHeroNames[8] = "keeper_of_the_light"
	UnitAbils[8] = { "super_mana_all_aura", "doom_bringer_doom_datadriven", "Snipe", "chilli_willi_all_aura", "Swap", "Vanish", "Sleep", "Banish", "Cyclone", "Freeze", "Venom_Strike", "Polymorph", "Unstable_Current", "kunkka_torrent_datadriven", "pudge_hook", "furion_sprout", "creature_chronosphere", "innocent_blur", "jakiro_ice_path", "jakiro_fire_path", "rubick_spell_steal_datadriven", "phoenix_supernova", "puck_dream_coil_datadriven", "leshrac_wall" }

	Random_Heroes[9] = "unit_gyrocopter"	-- Vertolet
	RealHeroNames[9] = "gyrocopter"
	
	Random_Heroes[10] = "unit_chilli_willi"	-- Chili-Villi
	RealHeroNames[10] = "chilli_willy"
	
	Random_Heroes[11] = "unit_zum_zum"	-- Zum-Zum-Zum
	RealHeroNames[11] = "batrider"
	
	Random_Heroes[12] = "unit_jakiro"	-- Drakon4ik
	RealHeroNames[12] = "jakiro"
	UnitAbils[12] = { "dragon_cold_breathe", "jakiro_ice_path", "dragon_fire_breathe", "jakiro_fire_path" }
	
	Random_Heroes[13] = "unit_skeleton"	-- Skeleton
	RealHeroNames[13] = "undying"
	
	Random_Heroes[14] = "unit_sheep"	-- Typaya Ovca
	RealHeroNames[14] = "stuped_sheep"
	
	Random_Heroes[15] = "unit_cheater"	-- Cheater
	RealHeroNames[15] = "antimage"
	
	Random_Heroes[16] = "unit_shaman"	-- Pastuvka
	RealHeroNames[16] = "shadow_shaman"
	
	Random_Heroes[17] = "unit_vengefulspirit"	-- Pantovui
	RealHeroNames[17] = "vengefulspirit"
	
	Random_Heroes[18] = "unit_brewmaster"	-- Mag Vetra
	RealHeroNames[18] = "brewmaster"
	
	Random_Heroes[19] = "unit_necromant"	-- Necromant
	RealHeroNames[19] = "pugna"
	
	Random_Heroes[20] = "unit_innocent"	-- Monavka
	RealHeroNames[20] = "phantom_assassin"
	
	Random_Heroes[21] = "unit_sleep_daemon"	-- Daemon of sleep
	RealHeroNames[21] = "bane"
	
	Random_Heroes[22] = "unit_pudge"	-- pudge
	RealHeroNames[22] = "pudge"
	
	Random_Heroes[23] = "unit_furion"	-- furion
	RealHeroNames[23] = "furion"
	
	Random_Heroes[24] = "unit_phoenix"	-- phoenix
	RealHeroNames[24] = "phoenix"
	
	Random_Heroes[25] = "unit_faceless"	-- faceless
	RealHeroNames[25] = "faceless_void"

	Random_Heroes[26] = "unit_999_slow_warden"	-- 999 slow ward
	RealHeroNames[26] = "ultslow"

	Random_Heroes[27] = "unit_mr_freeze"	-- Mr Freeze
	RealHeroNames[27] = "ancient_apparition"

	Random_Heroes[28] = "unit_rubick"	-- Rubick
	RealHeroNames[28] = "rubick"

	Random_Heroes[29] = "unit_leshrac"	-- Leshrac
	RealHeroNames[29] = "leshrac"
	
	-----------------------------------------------------------------------------------------------
	
	Random_Heroes[99] = "unit_yoba"	-- TEST
	RealHeroNames[99] = "npc_dota_hero_keeper_of_the_light"
	UnitAbils[99] = { "last_word" }
	
	--[[
	Random_Heroes[] = ""	-- 
	UnitAbils[] = { "" }
	]]
	
	
	--MusicPlayer:Init('scripts/music.kv') 
	
	----------------------------------

	
	gmMiranaPudgeInit()

	
	print('[JungleRace] Game inited ----------------------------')
end