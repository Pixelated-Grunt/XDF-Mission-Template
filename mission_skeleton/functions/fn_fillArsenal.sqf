#include "script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Populate a given object with ACE arsenal content
 *
 * Arguments:
 * 0: Object to turn into ACE arsenal <OBJECT>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_ammoBox] call XDF_MF_fnc_fillArsenal
 *
 * Public: No
**/


if !(isServer) exitWith {};

params ["_arsenal"];

if (isNil {missionNamespace getVariable QGVARMAIN(virtualItems)}) then {execVM "scripts\initArsenal.inc.sqf"};

[
    {!(isNil {missionNamespace getVariable QGVARMAIN(virtualItems)})},
    {
        params ["_arsenal"];
        private _content = missionNamespace getVariable QGVARMAIN(virtualItems);
        clearWeaponCargoGlobal _arsenal;
        clearMagazineCargoGlobal _arsenal;
        clearItemCargoGlobal _arsenal;
        clearBackpackCargoGlobal _arsenal;
        [_arsenal, _content] call ace_arsenal_fnc_initBox
    },
    [_arsenal],
    5,
    {WARNING_1("Arsenal: (%1) failed to populate.", (_this#0))}
] call CBA_fnc_waitUntilAndExecute
