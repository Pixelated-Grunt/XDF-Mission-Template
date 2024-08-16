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
private ["_content"];

_content = missionNamespace getVariable QGVARMAIN(arsenal_virtualItems);
if (isNil "_content") then {_content = execVM "..\scritps\initArsenal.inc.sqf"};

clearWeaponCargoGlobal _arsenal;
clearMagazineCargoGlobal _arsenal;
clearItemCargoGlobal _arsenal;
clearBackpackCargoGlobal _arsenal;
[_arsenal, _content] call ace_arsenal_fnc_initBox;

missionNamespace setVariable [QGVARMAIN(arsenal_virtualItems), _content]
