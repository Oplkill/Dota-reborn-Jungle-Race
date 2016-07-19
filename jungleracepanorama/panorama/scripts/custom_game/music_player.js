var Loop = false;
var Play = false;

function OnButtonPressed( data ) {
	var iPlayerID = Players.GetLocalPlayer();
	var btnName = data;
	//$.Msg( data );
	Game.ServerCmd("MusicPlayerButtonClicked " + btnName.substring(0, btnName.length-3));
	if (btnName == "stopBtn" || btnName == "playBtn")
	{
		Play = !Play;
		SetButtonStopPlay();
	}
	else if (btnName == "nextBtn" || btnName == "prevBtn")
	{
		Play = true;
		SetButtonStopPlay();
	}
	else if (btnName == "loopBtn")
	{
		if (Loop == true)
		{
			$('#loopBtn').AddClass('loopBtnOff');
		}
		else
		{
			$('#loopBtn').RemoveClass('loopBtnOff');
		}
		Loop = !Loop;
	}
}

function SetButtonStopPlay()
{
	$('#stopBtn').visible = Play;
	$('#playBtn').visible = !Play;
}

function NowPlaying( table )
{
	Play = true;
	SetButtonStopPlay();
	$.Msg(table.fullName);
	$('#NowPlaying').text = table.fullName;
	$('#NowPlayingBox').AddClass('playing');
	$.Schedule(30, function()
	{
		$('#NowPlayingBox').RemoveClass('playing');
	});
}

(function () {
	GameEvents.Subscribe( "playing_music", NowPlaying );
	SetButtonStopPlay();
	$('#loopBtn').AddClass('loopBtnOff');
})();