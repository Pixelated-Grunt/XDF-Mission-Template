#include "script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Clear vegetation around player in set radius
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Optional radius to clear <NUMBER> (default: 20)
 * 2: Optional minimum time in second <NUMBER> (default: 5)
 * 3: Optional time coefficient multipler <NUMBER> (default: 1.2)
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [] call XDF_MF_fnc_clearVegetation
 *
 * Public: No
**/


#define MAP_TYPES_VEGETATION    ["TREE","SMALL TREE","BUSH"]

params [
    ["_player", objNull, [objNull]],
    ["_radius", 20, [0]],
    ["_minTime", 5, [5]],
    ["_timeCoef", 1.2, [0]]
];

private ["_totalTime", "_vegObjs", "_perframeCheck", "_onFinish"];
_vegObjs = nearestTerrainObjects [_player, MAP_TYPES_VEGETATION, _radius, false, true];
_totalTime = _minTime + _timeCoef * count _vegObjs;

_onFinish = {
    params ["_args"];
    _args params ["_unit", "_vegObjs"];

    {
        [_x, true] remoteExec ["hideObjectGlobal", 2]
    } forEach _vegObjs;

    _unit playMoveNow "amovPknlMstpSrasWrflDnon"
};

_perframeCheck = {
    params ["_args", "", "_totalTime", ""];
    _args params ["_unit"];

    if (_totalTime > 3 && { animationState _unit != "AinvPknlMstpSnonWnonDnon_medic4" }) then {
        [_unit, "AinvPknlMstpSnonWnonDnon_medic4"] call ace_common_fnc_doAnimation;
    };
    true
};

[
    _totalTime,
    [_player, _vegObjs],
    _onFinish,
    { _this # 0 # 0 playMoveNow "amovPknlMstpSrasWrflDnon" },
    "Clearing Area",
    _perframeCheck
] call ace_common_fnc_progressBar
