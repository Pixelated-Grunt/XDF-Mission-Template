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


if hasInterface then {
    params ["_item"];

    private _c130sHashMap = createHashMap;
    private _c130sSpots = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

    // Get all static c130 info
    {
        if ("xdf_c130s_" in _x) then {
            private _obj = missionNamespace getVariable _x;
            private _vehsNearby = nearestObjects [_obj, ["Car", "Ship"], 10];
            _obj setVariable ["spotsLeft", _c130sSpots];
            _obj setVariable ["cargos", _vehsNearby];
            _c130sHashMap set [_x, [getPosASL _obj, _obj getVariable ["troopsPosASL", []]]]
        }
    } forEach allVariables missionNamespace;
    if (count _c130sHashMap == 0) exitWith {WARNING("No C-130 static found in mission.")};

    {
        private _obj = missionNamespace getVariable _x;

        _item addAction [format["Board C-130J for DZ #%1", _forEachIndex+1], {
            params ["", "_caller", "", "_args"];
            _args params ["_c130sData", "_c130sObj"];
            private ["_idx", "_spotsLeft"];

            // show C-130 static and vehicle inside if found
            if (isObjectHidden _c130sObj) then {
                private _cargos = _c130sObj getVariable ["cargos", []];

                [_c130sObj, false] remoteExec ["hideObjectGlobal", 2];
                if (count _cargos > 0) then {
                    private _cargo = _cargos#0;

                    if (_cargo isKindOf "LSV_01_base_F" || _cargo isKindOf "Rubber_duck_base_F") then {
                        if isObjectHidden _cargo then {[_cargo, false] remoteExec ["hideObjectGlobal", 2]}
                    }
                }
            };

            //NOTE: for now no code to handle if 16 slots are filled so default to the 1st pos for now
            _spotsLeft = _c130sObj getVariable ["spotsLeft", [0]];
            _idx = _spotsLeft select 0;

            //LOG_2("C-130 pos: %1 new pos: %2", (_c130sData#0), (_c130sData#0 vectorAdd _c130sData#1#_idx));
            _caller setPosASL ((_c130sData#0) vectorAdd (_c130sData#1#_idx));
            if ((_caller distance _c130sObj) < 10) then {
                _spotsLeft deleteAt 0;
                _c130sObj setVariable ["spotsLeft", _spotsLeft]
            } else {TRACE_2("Failed boarding C-130 static.", _caller, _c130sObj)}
        },
        [_y, _obj],
        1.5,
        false,
        true]
    } forEach _c130sHashMap
}
