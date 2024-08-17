/*
Modified by: Pixelated_Grunt
Author: Ampersand
Add actions to aircraft for set Ramp for Jump

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [_aircraft] call ffr_main_fnc_prepAircraft
*/


params ["_aircraft"];

// For easy testing on self host server
private _targets = [0, -2] select isDedicated;

[_aircraft,
    ["Prep Ramp for Free Fall", {
        params ["_aircraft"];
        ["ffr_main_prepRamp", [_aircraft]] call CBA_fnc_serverEvent;
    }, nil, 0, false, true, "", "isNull (_target getVariable ['ffr_dummy', objNull]) && {(getPos _target # 2) > 200 && {_this == driver _target || {!isNull driver _target && {!isPlayer driver _target} && {_this == leader _this}}}}"]
] remoteExec ["addAction", _targets, true];

[_aircraft,
    ["Stand Up", {
        call ffr_main_fnc_standUp;
    }, nil, 0, true, true, "", "!isNull (_target getVariable ['ffr_dummy', objNull]) && {_this in _target} && {_this != driver _target}"]
] remoteExec ["addAction", _targets, true];

[_aircraft,
    ["<t color='#FF0000'>Jumplight Red</t>", {
        params ["_aircraft"];
        ["ffr_main_setJumplight", [_aircraft, "red"]] call CBA_fnc_globalEvent;
    }, nil, 0, false, false, "", "!isNull (_target getVariable ['ffr_jumplight', objNull]) && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this || {_this in group driver _target}}}"]
] remoteExec ["addAction", _targets, true];

[_aircraft,
    ["<t color='#00FF00'>Jumplight Green</t>", {
        params ["_aircraft"];
        ["ffr_main_setJumplight", [_aircraft, "green"]] call CBA_fnc_globalEvent;
    }, nil, 0, false, false, "", "!isNull (_target getVariable ['ffr_jumplight', objNull]) && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this || {_this in group driver _target}}}"]
] remoteExec ["addAction", _targets, true];

[_aircraft,
    ["<t color='#999999'>Jumplight Off</t>", {
        params ["_aircraft"];
        ["ffr_main_setJumplight", [_aircraft, "off"]] call CBA_fnc_globalEvent;
    }, nil, 0, false, false, "", "!isNull (_target getVariable ['ffr_jumplight', objNull]) && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this || {_this in group driver _target}}}"]
] remoteExec ["addAction", _targets, true];

[_aircraft,
    ["<t color='#999999'>Secure Ramp from Free Fall</t>", {
        params ["_aircraft"];
        [_aircraft] call ffr_main_fnc_cleanUp;
    }, nil, 0, false, false, "", "!isNull (_target getVariable ['ffr_dummy', objNull]) && {!isNull (_target getVariable ['ffr_jumplight', objNull])} && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this || {_this in group driver _target}}}"]
] remoteExec ["addAction", _targets, true];

// Add for CUP C-130 static, it is always placed in editor as compositions
// no need for remoteExec. Also, the stand up action will not be available
// since this is a typeOf house instead of vehicle
if (typeOf _aircraft isEqualTo "C130J_static_EP1") then {
    private _vehsNearby = nearestObjects [_aircraft, ["Car", "Ship"], 10];
    private _veh = objNull;

    {
        if (_x isKindOf "LSV_01_base_F" || _x isKindOf "Rubber_duck_base_F") then {
            _veh = _x;
            break
        }
    } forEach _vehsNearby;

    if !(isNull _veh) then {
        _aircraft addAction ["Drop Vehicle", {
            params ["_aircraft", "", "_actionId", "_veh"];

            _aircraft removeAction _actionId;
            // The tail of the C-130 static is where it's pointing
            private _dropPos = _aircraft getRelPos [50, getDir _aircraft];

            _dropPos set [2, (getPosASL _aircraft) # 2];
            [_veh] call XDF_MF_fnc_addArsenalToCargo;
            [_veh, _dropPos] call XDF_MF_fnc_paradropVehicle
        }, _veh, 0, false, true, "", "!isNull (_target getVariable ['ffr_jumplight', objNull]) && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this}}"]
    }
}
