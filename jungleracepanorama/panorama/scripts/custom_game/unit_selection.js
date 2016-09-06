
var units = new Array();

function AddToSelection ( args ) {
	var entIndex = args.ent_index;
	var plId = args.playerId;

	//$.Msg("Add "+entIndex+" to Selection")

	units[plId] = entIndex;
	GameUI.SelectUnit(entIndex, false);
	//OnUpdateSelectedUnit( args )
}

function UpdateInventory()
{
	var id = Players.GetLocalPlayer();
	var queryUnit = Players.GetLocalPlayerPortraitUnit();
	if (Entities.IsRealHero(queryUnit))
	{
		//$.Msg("Its hero! Now selecting - "+units[id])
		GameUI.SelectUnit(units[id], false);
		Game.ServerCmd("PlayerSelectedHero");
	}
	//var queryUnit = Players.GetQueryUnit(id);
	//var heroId = Players.GetPlayerHeroEntityIndex(id);
	//var unitId = Players.GetSelectedEntities(id);
	//$.Msg("Selected unit - "+"Player("+id+") hero - "+heroId+"    unit - "+unitId);
}

function Init()
{
	for ( var i = 0; i < 11; i++ )
	{
		units[i] = {
				unitId: 0
			}
	}
}

(function () {
	GameEvents.Subscribe( "add_to_selection", AddToSelection );
	GameEvents.Subscribe( "dota_player_update_selected_unit", UpdateInventory );
	Init();
})();