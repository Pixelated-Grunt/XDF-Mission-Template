#include "script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Get allowed action for unit depending on items they carry
 *
 * Arguments:
 * 0: Unit to set actions on <OBJECT>
 *
 * Return Value:
 * List of allowed actions <ARRAY> (default: [])
 *
 * Example:
 * [_player] call XDF_MF_fnc_getUnitAllowedActions
 *
 * Public: No
**/


params ["_player"];

private ["_actionsItemsHash", "_actions", "_unitUniqueItemsHash"];

_actionsItemsHash = missionNamespace getVariable [QGVAR(accessItems), createHashMap];
// NOTE: Only check uniform, vest and backpack items
_unitUniqueItemsHash = uniqueUnitItems [_player, 0, 2, 2, 2, false];
_actions = [];

{
    private _action = _x;
    private _item = toLower(_y);

    {
        if (_item in toLower(_x)) then {
            _actions pushBack _action
        };
    } forEach _unitUniqueItemsHash
} forEach _actionsItemsHash;

if (_player getVariable ["ACE_hasEarPlugsIn", false]) then {
    _actions pushBackUnique "EARPLUGS"
};

_player setVariable ["UnitAllowedActions", _actions];

_actions
