/*
 * Author: Pixelated_Grunt
 * Description: Settings triggered on players respawn
 *
 */


params ["_newUnit", "_oldUnit"];

/*********************************************************
 * MISSION SPECIFIC - Put scripts for current mission only
 *********************************************************/



/********************************************
 * COMMON SECTION - Settings for all missions
 ********************************************/
// Preserve player's gears and attributes
// This will handle primary weapon, launcher, loadout, attritubtes properly during respawn
// Code doesn't handle players died inside a vehicle
private _name = name _oldUnit;
private _nameSound = nameSound _oldUnit;
private _face = face _oldUnit;
private _speaker = speaker _oldUnit;
private _loadout = getUnitLoadout _oldUnit;
private _wpnObjs = nearestObjects [_oldUnit, ["weaponHolderSimulated"], 5];

deleteVehicle _oldUnit;

_newUnit setUnitLoadout _loadout;
//{ _newUnit removeMagazineGlobal _x } forEach magazines _newUnit;
{
    private ["_wpnItems", "_weapon", "_magName"];
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
