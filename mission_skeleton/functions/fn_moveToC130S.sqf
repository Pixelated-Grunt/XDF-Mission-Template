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


private _c130sHashMap = createHashMap;
private _c130sPos = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

{
    if ("xdf_c130s_" in _x) then {
        private _obj = missionNamespace getVariable _x;
        _c130sHashMap set [_x, [getPosASL _obj, _obj getVariable ["troopsPosASL", []]]]
    }
} forEach allVariables missionNamespace;
