

MusicPlayer = {}

function MusicPlayer:Init(musicKV)
	self.DEBUG = true

	self:ChangePlaylist(musicKV)

	Convars:RegisterCommand( "MusicPlayerButtonClicked", function(name, btnName)
		local cmdPlayer = Convars:GetCommandClient()
		if cmdPlayer and cmdPlayer.musicPlayer ~= nil then
			if MusicPlayer.DEBUG then
				print("[MusicPlayer]btnName: " .. btnName)
			end
			if btnName == "loop" then
				cmdPlayer:LoopSong()
			elseif btnName == "play" then
				cmdPlayer:PlayMusic()
			elseif btnName == "stop" then
				cmdPlayer:StopMusic()
			elseif btnName == "next" then
				cmdPlayer:NextMusic()
			elseif btnName == "prev" then
				cmdPlayer:PrevMusic()
			end
			
		end
	end, "", 0 )
end

function MusicPlayer:ChangePlaylist( musicKV )
	if MusicPlayer.DEBUG then
		print("[MusicPlayer]Changing Playlist")
	end

	self.musicKV = LoadKeyValues(musicKV)
	local index = 1
	self.songs = {}
	for k,v in pairs(self.musicKV) do
		-- define an index for the song
		v.index = index
		-- map index to song name
		self.songs[index] = k
		index = index + 1
	end
	self.totalSongs = index
end

function MusicPlayer:AttachMusicPlayer( hPlayer )
	if MusicPlayer.DEBUG then
		print("[MusicPlayer]Attaching to player")
	end
	local songs = MusicPlayer.songs
	local musicKV = MusicPlayer.musicKV
	hPlayer.musicPlayer = {}
	local mp = hPlayer.musicPlayer

	local updateMusicList = function()
		mp.musicListIndexes = {}
		for i = 1, #songs do
        	mp.musicListIndexes[i] = i
    	end
		mp.musicListIndexes = shuffle(mp.musicListIndexes)
		mp.currentSongIdInList = 1
		mp.playing = false
		mp.loop = false
	end

	updateMusicList()

	function hPlayer:UpdateMusicPlaylist(  )
		
	end

	function hPlayer:PlayMusic(  )
		if MusicPlayer.DEBUG then
			print("[MusicPlayer]playing music")
		end
		EmitSoundOnClient(songs[mp.musicListIndexes[mp.currentSongIdInList]], hPlayer)
		mp.playing = true
		hPlayer:stopTimer()
		mp.musicTimer = Timers:CreateTimer(musicKV[songs[mp.musicListIndexes[mp.currentSongIdInList]]]["Seconds"], 
			function()
				if mp.loop then
					hPlayer:PlayMusic()
				else
					hPlayer:NextMusic()
				end
			end)
		--CustomGameEventManager:Send_ServerToPlayer(self,"playing_music", {song=songs[mp.musicListIndexes[mp.currentSongIdInList]]} )
		CustomGameEventManager:Send_ServerToPlayer(self,"playing_music", 
			{
				song=musicKV[songs[mp.musicListIndexes[mp.currentSongIdInList]]]["LessName"],
				fullName=musicKV[songs[mp.musicListIndexes[mp.currentSongIdInList]]]["Alias"]..musicKV[songs[mp.musicListIndexes[mp.currentSongIdInList]]]["Artist"]
			} )
	end

	function hPlayer:StopMusic(  )
		if MusicPlayer.DEBUG then
			print("[MusicPlayer]stopping music")
		end
		StopSoundEvent(songs[mp.musicListIndexes[mp.currentSongIdInList]], hPlayer)
		mp.playing = false
		hPlayer:stopTimer()
	end

	function hPlayer:NextMusic(  )
		hPlayer:StopMusic()
		mp.currentSongIdInList = mp.currentSongIdInList + 1
		if mp.currentSongIdInList > #mp.musicListIndexes then
			mp.currentSongIdInList = 1
		end
		hPlayer:PlayMusic()
	end

	function hPlayer:PrevMusic(  )
		hPlayer:StopMusic()
		mp.currentSongIdInList = mp.currentSongIdInList - 1
		if mp.currentSongIdInList == 0 then
			mp.currentSongIdInList = #mp.musicListIndexes
		end
		hPlayer:PlayMusic()
	end

	function hPlayer:LoopSong(  )
		mp.loop = not mp.loop
	end

	function hPlayer:stopTimer(  )
		if mp.musicTimer ~= nil then
			Timers:RemoveTimer(mp.musicTimer)
		end
	end


end



-- ******************* UTILITY FUNCTIONS *******************

-- Returns a shallow copy of the passed table.
function shallowcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in pairs(orig) do
			copy[orig_key] = orig_value
		end
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

-- shuffle function from: https://github.com/xfbs/PiL3/blob/master/18MathLibrary/shuffle.lua
-- doesn't use a while loop
function shuffle(list)
    -- make and fill array of indices
    local indices = {}
    for i = 1, #list do
        indices[#indices+1] = i
    end

    -- create shuffled list
    local shuffled = {}
    for i = 1, #list do
        -- get a random index
        local index = math.random(#indices)

        -- get the value
        local value = list[indices[index]]

        -- remove it from the list so it won't be used again
        table.remove(indices, index)

        -- insert into shuffled array
        shuffled[#shuffled+1] = value
    end

    return shuffled
end