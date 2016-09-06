
var maxlaps = 0;

function UpdateMaxLaps( table )
{
	if (table.laps != -1)
	{
		maxlaps = table.laps;
	}
	$('#Goal').text = maxlaps;
}

function UpdateGameTime( table )
{
	$('#Time').text = table.minutes + ":" + table.seconds;
}

(function () {
	GameEvents.Subscribe( "update_max_laps", UpdateMaxLaps );
	GameEvents.Subscribe( "update_game_time", UpdateGameTime );
})();