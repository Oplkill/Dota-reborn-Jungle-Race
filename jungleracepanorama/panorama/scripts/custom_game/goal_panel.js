

function UpdateMaxLaps( table )
{
	$('#Goal').text = table.laps;
}

function UpdateGameTime( table )
{
	$('#Time').text = table.minutes + ":" + table.seconds;
}

(function () {
	GameEvents.Subscribe( "update_max_laps", UpdateMaxLaps );
	GameEvents.Subscribe( "update_game_time", UpdateGameTime );
})();