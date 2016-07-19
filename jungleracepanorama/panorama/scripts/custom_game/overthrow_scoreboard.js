"use strict";

function UpdateTimer( data )
{
	//$.Msg( "UpdateTimer: ", data );
	//var timerValue = Game.GetDOTATime( false, false );

	//var sec = Math.floor( timerValue % 60 );
	//var min = Math.floor( timerValue / 60 );

	//var timerText = "";
	//timerText += min;
	//timerText += ":";

	//if ( sec < 10 )
	//{
	//	timerText += "0";
	//}
	//timerText += sec;

	var timerText = "";
	timerText += data.timer_minute_10;
	timerText += data.timer_minute_01;
	timerText += ":";
	timerText += data.timer_second_10;
	timerText += data.timer_second_01;

	$( "#Timer" ).text = timerText;

	//$.Schedule( 0.1, UpdateTimer );
}

function ShowTimer( data )
{
	$( "#Timer" ).AddClass( "timer_visible" );
}

function AlertTimer( data )
{
	$( "#Timer" ).AddClass( "timer_alert" );
}

function HideTimer( data )
{
	$( "#Timer" ).AddClass( "timer_hidden" );
}

function UpdateLapsToWin(data)
{
	//var victory_condition = CustomNetTables.GetTableValue( "game_state", "victory_condition" );
	//if ( victory_condition )
	//{
		//$("#VictoryPoints").text = victory_condition.kills_to_win;
	//}
	//$("#VictoryPoints").text = Player_Laps[0];
	$("#VictoryPoints").text = data.laps;
}

(function()
{
	// We use a nettable to communicate victory conditions to make sure we get the value regardless of timing.
	//UpdateKillsToWin();

    GameEvents.Subscribe( "countdown", UpdateTimer );
    GameEvents.Subscribe( "show_timer", ShowTimer );
    GameEvents.Subscribe( "timer_alert", AlertTimer );
    GameEvents.Subscribe( "overtime_alert", HideTimer );
	GameEvents.Subscribe( "update_max_laps", UpdateLapsToWin ); 
	//UpdateTimer();
})();

