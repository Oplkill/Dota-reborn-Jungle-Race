
var pl_UIs = new Array();

var players = new Array();

function OnButtonPressed( data ) {
	var btnId = parseInt(data, 10);
	//btnId = btnId - 1
/*
	var iPlayerID = Players.GetLocalPlayer();
	$.Msg( "Button pressed " + btnId + "    heroentindex = " + players[btnId].heroentindex );
	$.Msg("Heroname = " + players[btnId].heroname);

	if(players[btnId].heroentindex != 0)
	{
		GameUI.SelectUnit(players[btnId].heroentindex, false)
	}
	*/

	//Game.ServerCmd("PanelHeroClicked " + iPlayerID + " " + data);
}

function InitPlayer( table )
{
	var panId = players[table.id].panelid;

	players[table.id].playing = table.playing;
	players[table.id].teamid = table.teamid;
	pl_UIs[panId].pl_panels.visible = table.playing;
	if(table.playing)
	{
		pl_UIs[panId].teamicon.AddClass('TeamIconPlayer'+table.teamid);
		pl_UIs[panId].colorline.AddClass('ColorLinePlayer'+table.teamid);
	}
}

function UpdateAll(  )
{
	for ( var i = 0; i < 10; i++)
	{
		var table = {
			id: 			i,
			laps: 			players[i].laps,
			heroname:		players[i].heroname,
			heroentindex:	players[i].heroentindex
		}
		
		UpdateHero(table);
		UpdateLap(table);
	}
}

function UpdateLap( table )
{
	players[table.id].laps = table.laps;
	pl_UIs[players[table.id].panelid].laps.text = table.laps;
}

function UpdateHero( table )
{
	players[table.id].heroname = table.heroname;
	players[table.id].heroentindex = table.heroentindex;
	//pl_UIs[players[table.id].panelid].heroimage.heroname = table.heroname; 
	pl_UIs[players[table.id].panelid].heroimage.SetImage("file://{resources}/images/heroes/" + table.heroname + ".png");
	pl_UIs[players[table.id].panelid].heroimage.src = "file://{resources}/images/heroes/" + table.heroname + ".png";
	//$.Msg( "file://{resources}/images/heroes/" + table.heroname + ".png" );
}

function InitVariables( )
{
	for ( var i = 0; i < 11; i++ )
	{
		var b = i + 1;

		var basePanelText = "#BasePanel" + b;
		var lapsText = "#Laps" + b;
		var teamIconText = "#TeamIcon" + b;
		var colorLineText = "#ColorLine" + b;
		var heroImageText = "#HeroImage" + b;
		pl_UIs[i] = {
			pl_panels: 	$(basePanelText),
			laps: 		$(lapsText),
			teamicon: 	$(teamIconText),
			colorline: 	$(colorLineText),
			heroimage: 	$(heroImageText)
		}

		players[i] = {
			panelid: 		i,
			teamid: 		b,
			heroname: 		"",
			laps: 			0,
			playing: 		false,
			disconnected: 	false,
			heroentindex: 	0
		}
	}
}

function PlayerDisconnected( table )
{
	players[table.id].disconnected = true;
	var table2 = {
		id:				table.id,
		heroentindex: 	0,
		heroname:		"leavedgame"
	}
	UpdateHero(table2);
}

function PlayerReconnected( table )
{
	players[table.id].disconnected = false;
	UpdateAll()
}

(function () {
	GameEvents.Subscribe( "jr_player_reach_end", UpdateLap );
	GameEvents.Subscribe( "jr_init_player", InitPlayer );
	GameEvents.Subscribe( "jr_update_hero", UpdateHero );
	GameEvents.Subscribe( "jr_player_reconnected", PlayerReconnected );
	GameEvents.Subscribe( "jr_player_disconnected", PlayerDisconnected );
	InitVariables();
})();