#include "script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Setup teleport actions to move players to C-130 static
 *
 * Arguments:
 * 0: Object to create user action <OBJECT>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [obj] call XDF_MF_fnc_boardC130S
 *
 * Public: No
**/


if !isServer exitWith {};
params ["_item"];

private _c130sHashMap = createHashMap;
private _c130sPos = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

// Get all static c130 info
{
    if ("xdf_c130s_" in _x) then {
        private _obj = missionNamespace getVariable _x;
        _obj setVariable ["spotsLeft", _c130sPos];
        _c130sHashMap set [_x, [getPosASL _obj, _obj getVariable ["troopsPosASL", []]]]
    }
} forEach allVariables missionNamespace;
if (count _c130sHashMap == 0) exitWith {WARNING("No C-130 static found in mission.")};

{
    private _obj = missionNamespace getVariable _x;

    _item addAction [format["Reset %1 seats", _x], {
        params ["", "", "", "_args"];
        _args params ["_c130sObj", "_c130sPos"];

        _c130sObj setVariable ["spotsLeft", _c130sPos]
    },
    [_obj, _c130sPos],
    2,
    false,
    false,
    "",
    "(_obj getVariable ['spotsLeft', []]) isEqualTypeArray []"];

    _item addAction [format["Board %1", _x], {
        params ["", "_caller", "", "_args"];
        _args params ["_c130sData", "_c130sObj"];
        private ["_spotsLeft", "_idx"];

        if (isObjectHidden _c130sObj) then {_c130sObj hideObjectGlobal false};
        _spotsLeft = _c130sObj getVariable ["spotsLeft", []];
        _idx = _spotsLeft select 0;

        _caller setPosASL [_c130sData#0 vectorAdd _c130sData#1#_idx];
        if ((_caller distance _c130sObj) < 10) then {
            _spotsLeft deleteAt 0;
            _c130sObj setVariable ["spotsLeft", _spotsLeft]
        } else {TRACE_2("Failed boarding C-130 static.", _caller, _c130sObj)}
    },
    [_y, _obj],
    1.5,
    false,
    true,
    "",
    "count (_obj getVariable ['spotsLeft', []) > 0"]
} forEach _c130sHashMap
