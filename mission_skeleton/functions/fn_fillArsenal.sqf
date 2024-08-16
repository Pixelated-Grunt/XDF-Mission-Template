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

params ["_arsenal", "_content", "_fnc_statement"];

_fnc_statement = {
    params ["_arsenal"];
    clearWeaponCargoGlobal _arsenal;
    clearMagazineCargoGlobal _arsenal;
    clearItemCargoGlobal _arsenal;
    clearBackpackCargoGlobal _arsenal;
    [_arsenal, missionNamespace getVariable QGVARMAIN(virtualItems)] call ace_arsenal_fnc_initBox
};

_content = missionNamespace getVariable QGVARMAIN(virtualItems);
if !(isNil "_content") then {
    [_arsenal] call _fnc_statement
} else {
    execVM "scripts\initArsenal.inc.sqf";
    [
        {!(isNil {missionNamespace getVariable QGVARMAIN(virtualItems)})},
        _fnc_statement,
        [_arsenal],
        5,
        {WARNING_1("Arsenal: (%1) failed to populate.", (_this#0))}
    ] call CBA_fnc_waitUntilAndExecute
}
