--Global variables

require('junglerace/jr_init')

--Constants--------------------

_G.MAXIMUM_PLAYERS = 10
_G.MAXIMUM_RANDOM_HEROES = 31
_G.DEBUG = false
-------------------------------

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
_G.TESTCHOOSEHERO = -1			-- Force choose hero always. if -1 it will dont work
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--Variables--------------------

_G.Maximum_Laps = 2				-- Maximum laps (int)
_G.Player_Laps = {}				-- Current players laps (ints)
_G.Random_Heroes = {}			-- Random heroes (strings)
_G.Player_Half_Lap = {}			-- Players half map (bools)
_G.PlayerCurrHeroes = {}		-- Players current heroes
_G.UnitAbils = {}				-- Double Array of Units
_G.Players_state = {}			-- Players state of playing: 0 - None, 1 - Playing, 2 - Leaved
_G.PlayerIdByTeam = {}			-- Get player ID by his team ID
_G.RealHeroNames = {}			-- Real hero names for table

_G.CurrentPlayerUnit = {}		-- Current alive unit. If not alife will be null

-------------------------------

_G.Player_Lap_Votes = {}		-- Players votes in start game

-------------------------------

_G.SpawnPoints = {}				-- Spawn points
_G.FinishPoints = {}			-- Finish points

-------------------------------

_G.GameStarted = false

-------------------------------

_G.GM = {}						-- GameModes bool array. ["GameModeName"] = false/true

-------------------------------



-------------------------------

InitJungleRaceGame()