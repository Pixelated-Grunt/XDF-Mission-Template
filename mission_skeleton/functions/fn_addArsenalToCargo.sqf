#include "script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Add a crate with ACE arsenal into vehicle cargo
 *
 * Arguments:
 * 0: Vehicle to add crate to <OBJECT>
 * 1: Add cargo space if needed <BOOL> (default: true)
 * 2: Crate classname <STRING> (default: "Box_T_NATO_Wps_F")
 *
 * Return Value:
 * Cargo successfully added <BOOL>
 *
 * Example:
 * [] call XDF_MF_fnc_addArsenalToCargo
 *
 * Public: No
**/


params [
    ["_vehicle", objNull, [objNull]],
    ["_addCargoSpace", true, [true]],
    ["_crateClass", "Box_T_NATO_Wps_F", [""]]
];

private ["_cargoSpace", "_crate", "_result"];

_result = false;
_cargoSpace = _vehicle getVariable "ace_cargo_space";
if (_cargoSpace < 2) then {
    if !(_addCargoSpace) exitWith {
        DEBUG_1("Not enough cargo space in (%1) to load the crate in.", typeOf _vehicle);
        _result
    };
    [_vehicle, _cargoSpace + 2] call ace_cargo_fnc_setSpace
};

_crate = _crateClass createVehicle getPosASL _vehicle;
if !isNull(_crate) then {
    _crate hideObjectGlobal true;
    [_crate] call FUNC(fillArsenal);
    if ([_crate, _vehicle, true] call ace_cargo_fnc_loadItem) then {
        _crate hideObjectGlobal false;
        _result = true
    } else { DEBUG_1("Failed to load crate into %1.", typeOf _vehicle) }
} else {
    deleteVehicle _crate;
    DEBUG_1("Failed to create the crate to load into %1.", typeOf _vehicle)
};

_result
