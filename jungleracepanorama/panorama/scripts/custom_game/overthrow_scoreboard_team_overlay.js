"use strict";

function OnKillEvent( event )
{
	var curTimeDS = Game.GetGameTime() * 10;
	var teamPanel = $.GetContextPanel();
	var teamId = $.GetContextPanel().GetAttributeInt( "team_id", -1 );
//	$.Msg( "OnKillEvent:", event, " ? ", teamId );
	if ( teamId !== event.team_id )
		return;

//	$.Msg( event );

	var recentScore = teamPanel.GetAttributeInt( "recent_score_count", 0 );
	recentScore++;
	//teamPanel.SetAttributeInt( "recent_score_count", recentScore );
	teamPanel.SetAttributeInt( "recent_score_count", 9 );
	teamPanel.SetAttributeInt( "ds_time_of_most_recent_score", curTimeDS );

	var pointsToWinPanel = teamPanel.FindChildInLayoutFile( "PointsToWin" );
	//pointsToWinPanel.SetDialogVariableInt( "points_to_win", event.kills_remaining );
	pointsToWinPanel.SetDialogVariableInt( "points_to_win", 33 );

	if ( event.victory )
	{
		teamPanel.SetHasClass( "victory", true );
		teamPanel.SetHasClass( "close_to_victory", false );
		teamPanel.SetHasClass( "very_close_to_victory", false );
		pointsToWinPanel.text = $.Localize( "#PointsToWin_Victory", pointsToWinPanel );
	}
	else if ( event.very_close_to_victory ) 
	{
		teamPanel.SetHasClass( "victory", false );
		teamPanel.SetHasClass( "close_to_victory", false );
		teamPanel.SetHasClass( "very_close_to_victory", true );
		pointsToWinPanel.text = $.Localize( "#PointsToWin_VeryCloseToVictory", pointsToWinPanel );
	}
	else if ( event.close_to_victory )
	{
		teamPanel.SetHasClass( "victory", false );
		teamPanel.SetHasClass( "close_to_victory", true );
		teamPanel.SetHasClass( "very_close_to_victory", false );
		pointsToWinPanel.text = $.Localize( "#PointsToWin_CloseToVictory", pointsToWinPanel );
	}

	UpdateRecentScore();
	$.Schedule( 1, UpdateRecentScore );
}

function UpdateRecentScore()
{
//	$.Msg( "UpdateRecentScore" );
	//var TIME_TO_SHOW_RECENT_SCORE_DS = 10; // 2s
	var teamPanel = $.GetContextPanel();

	//var curTimeDS = Game.GetGameTime() * 10;
	var recentScore = teamPanel.GetAttributeInt( "recent_score_count", 0 );
	//var timeOfRecentScoreDS = teamPanel.GetAttributeInt( "ds_time_of_most_recent_score", 0 );

	//if ( timeOfRecentScoreDS + TIME_TO_SHOW_RECENT_SCORE_DS < curTimeDS )
	//{
	//	teamPanel.SetAttributeInt( "recent_score_count", 9 );
	//	teamPanel.SetAttributeInt( "ds_time_of_most_recent_score", 0 );
	//	recentScore = 0;
	//}
	
	var recentScorePanel = teamPanel.FindChildInLayoutFile( "RecentScore" );
	
	
	if ( recentScore === 0 )
	{
		recentScorePanel.SetHasClass( "recent_score", false );
		recentScorePanel.SetHasClass( "no_recent_score", true );
	}
	else
	{
		//recentScore = 70
		recentScorePanel.SetDialogVariableInt( "score", recentScore );
		recentScorePanel.text = $.Localize( "#RecentScore", recentScorePanel );
		recentScorePanel.SetHasClass( "recent_score", true );
		recentScorePanel.SetHasClass( "no_recent_score", false );
	}
	
	//UpdateRecentScore();
	//$.Schedule( 1, UpdateRecentScore );
}

function playerReachEnd( data )
{
	var teamPanel = $.GetContextPanel();
	var teamId = teamPanel.GetAttributeInt( "team_id", -1 );
	if ( teamId !== data.team_id )
		return;
	
	$.Msg( "OnMyEvent: ", data );
	//data.playerId = plId
	//data.laps = Player_Laps[plId]
	
	var pointsToWinPanel = teamPanel.FindChildInLayoutFile( "PointsToWin" );
	pointsToWinPanel.SetDialogVariableInt( "points_to_win", data.laps_remaining );
	if ( data.close_to_victory == 0 )
	{
		//teamPanel.SetHasClass( "victory", true );
		//teamPanel.SetHasClass( "close_to_victory", false );
		//teamPanel.SetHasClass( "very_close_to_victory", false );
		//pointsToWinPanel.text = $.Localize( "#PointsToWin_Victory", pointsToWinPanel );
	}
	else if ( data.close_to_victory == 2 ) 
	{
		teamPanel.SetHasClass( "victory", false );
		teamPanel.SetHasClass( "close_to_victory", false );
		teamPanel.SetHasClass( "very_close_to_victory", true );
		pointsToWinPanel.text = $.Localize( "#PointsToWin_VeryCloseToVictory", pointsToWinPanel );
	}
	else if ( data.close_to_victory == 1 )
	{
		teamPanel.SetHasClass( "victory", false );
		teamPanel.SetHasClass( "close_to_victory", true );
		teamPanel.SetHasClass( "very_close_to_victory", false );
		pointsToWinPanel.text = $.Localize( "#PointsToWin_CloseToVictory", pointsToWinPanel );
	}
	
	
	
	
	teamPanel.SetAttributeInt( "recent_score_count", data.laps );
	//var recentScore = teamPanel.GetAttributeInt( "recent_score_count", 0 );
	var recentScore = data.laps
	var recentScorePanel = teamPanel.FindChildInLayoutFile( "RecentScore" );
	//recentScore = data.laps
	recentScorePanel.SetDialogVariableInt( "score", recentScore );
	recentScorePanel.text = $.Localize( "#RecentScore", recentScorePanel );
	recentScorePanel.SetHasClass( "recent_score", true );
	recentScorePanel.SetHasClass( "no_recent_score", false );
}
 


(function()
{
//	$.Msg( "overthrow_scoreboard_team_overlay" );

	var teamPanel = $.GetContextPanel();
	teamPanel.SetAttributeInt( "recent_score_count", 0 );
	teamPanel.SetAttributeInt( "ds_time_of_most_recent_score", 0 );
	//GameEvents.Subscribe( "kill_event", OnKillEvent );
	GameEvents.Subscribe( "jr_player_reach_end", playerReachEnd);
})();
