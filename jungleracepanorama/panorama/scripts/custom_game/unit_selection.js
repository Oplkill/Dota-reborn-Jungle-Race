
function AddToSelection ( args ) {
	var entIndex = args.ent_index

	//$.Msg("Add "+entIndex+" to Selection")

	GameUI.SelectUnit(entIndex, false)
	//OnUpdateSelectedUnit( args )
}

(function () {
	GameEvents.Subscribe( "add_to_selection", AddToSelection );
})();