/*
 * Author: Pixelated_Grunt
 * Last modified: 20240324
 * Description: Settings triggered on players respawn
 *
 */


/*
 * COMMON SECTION - Settings for all missions
 *
 */

params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

// Preserve player's gears and attributes
// This will handle primary weapon, launcher, loadout, attritubtes properly during respawn, code doesn't handle players died inside a vehicle
_name = name _oldUnit;
_nameSound = nameSound _oldUnit;
_face = face _oldUnit;
_speaker = speaker _oldUnit;
_loadout = getUnitLoadout _oldUnit;
_wpnObjs = nearestObjects [_oldUnit, ["weaponHolderSimulated"], 5];

deleteVehicle _oldUnit;

_newUnit setUnitLoadout _loadout;
//{ _newUnit removeMagazineGlobal _x } forEach magazines _newUnit;
{
	private ["_i", "_wpnItems", "_weapon"];
	_wpnItems = (weaponsItemsCargo _x) select 0;
	_weapon = _wpnItems select 0;

	for "_i" from 0 to (count _wpnItems)-1 do {
		switch _i do {
			case 0: {_newUnit addWeapon _weapon};
			case 4: {
				//diag_log format["_wpnItems: %1", _wpnItems];
				if (count (_wpnItems select _i) > 0) then {
					_magName = _wpnItems select _i select 0;
					_newUnit addWeaponItem [_weapon, _wpnItems select _i];
					if ((_wpnItems select _i select 1) > 0) then {
						_newUnit addMagazineGlobal _magName;
					};
				};
			};
			default {_newUnit addWeaponItem [_weapon, _wpnItems select _i]};
		};
	}
} forEach _wpnObjs;
_newUnit setName _name;
_newUnit setNameSound _nameSound;
_newUnit setFace _face;
_newUnit setSpeaker _speaker;


/*
 * MISSION SPECIFIC - Put scripts for current mission only
 *
 */
