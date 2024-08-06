/*
 * Author: Pixelated_Grunt
 * Description: Script that populates ACE arsenals placed in Eden that are prefixed with 'xdf_arsenal' and all menu actions
 *
 */

if (isServer) then {
	// Load up all arsenals placed in editor
	{
		private _arsenal = objNull;

		if ("xdf_arsenal" in _x) then {
			_arsenal = missionNamespace getVariable _x;

			// Populate ACE aresenal content
			clearWeaponCargoGlobal _arsenal;
			clearMagazineCargoGlobal _arsenal;
			clearItemCargoGlobal _arsenal;
			clearBackpackCargoGlobal _arsenal;
			[_arsenal, true] call ace_arsenal_fnc_initBox
		};
	} forEach allVariables missionNamespace;
};
