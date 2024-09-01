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

private _commonActions = [
    ["Prep Ramp for Free Fall", {
        params ["_aircraft", "_caller"];
        missionNamespace setVariable ["XDF_MF_jumpMaster", _caller];
        ["ffr_main_prepRamp", [_aircraft]] call CBA_fnc_serverEvent;
    }, nil, 0, false, true, "", "isNull (_target getVariable ['ffr_dummy', objNull]) && {(getPos _target # 2) > 200 && {_this == driver _target || {!isNull driver _target && {!isPlayer driver _target} && {_this == leader _this}}}}"],
    ["Stand Up", {
        call ffr_main_fnc_standUp;
    }, nil, 0, true, true, "", "!isNull (_target getVariable ['ffr_dummy', objNull]) && {_this in _target} && {_this != driver _target}"],
    ["<t color='#FF0000'>Jumplight Red</t>", {
        params ["_aircraft"];
        ["ffr_main_setJumplight", [_aircraft, "red"]] call CBA_fnc_globalEvent;
    }, nil, 0, false, false, "", "!isNull (_target getVariable ['ffr_jumplight', objNull]) && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this || {_this in group driver _target}}}"],
    ["<t color='#00FF00'>Jumplight Green</t>", {
        params ["_aircraft"];
        ["ffr_main_setJumplight", [_aircraft, "green"]] call CBA_fnc_globalEvent;
    }, nil, 0, false, false, "", "!isNull (_target getVariable ['ffr_jumplight', objNull]) && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this || {_this in group driver _target}}}"],
    ["<t color='#999999'>Jumplight Off</t>", {
        params ["_aircraft"];
        ["ffr_main_setJumplight", [_aircraft, "off"]] call CBA_fnc_globalEvent;
    }, nil, 0, false, false, "", "!isNull (_target getVariable ['ffr_jumplight', objNull]) && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this || {_this in group driver _target}}}"],
    ["<t color='#999999'>Secure Ramp from Free Fall</t>", {
        params ["_aircraft"];
        [_aircraft] call ffr_main_fnc_cleanUp;
    }, nil, 0, false, false, "", "!isNull (_target getVariable ['ffr_dummy', objNull]) && {!isNull (_target getVariable ['ffr_jumplight', objNull])} && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this || {_this in group driver _target}}}"]
];

// Add for CUP C-130 static, it is always placed in editor as compositions
// no need for remoteExec. Also, the stand up action will not be available
// since this is a typeOf house instead of vehicle
if (typeOf _aircraft isEqualTo "C130J_static_EP1") then {
    private _vehsNearby = nearestObjects [_aircraft, ["Car", "Ship"], 10];
    private _veh = objNull;

    {_aircraft addAction _x} forEach _commonActions;

    {
        if (_x isKindOf "LSV_01_base_F" || _x isKindOf "Rubber_duck_base_F") then {
            _veh = _x;
            break
        }
    } forEach _vehsNearby;

    if !(isNull _veh) then {
        _aircraft setVariable ["cargoVehicles", [_veh]];
        _aircraft addAction ["Drop Vehicle", {
            params ["_aircraft", "_caller", "", "_veh"];

            [[_veh], XDF_MF_fnc_addArsenalToCargo] remoteExec ["call", 2];
            [[_veh, _aircraft], XDF_MF_fnc_paradropVehicle] remoteExec ["call", 2];

            // Let the jump master remove the C-130
            if (missionNamespace getVariable["XDF_MF_jumpMaster", objNull] isEqualTo _caller) then {
                [
                    {
                        params ["_caller", "_aircraft"];
                        _caller distance _aircraft > 200
                    },
                    {
                        params ["_caller", "_aircraft"];
                        _caller addAction ["Radio C-130 to RTB", {
                            params ["", "_caller", "_actionId", "_aircraft"];

                            _caller removeAction _actionId;
                            [_aircraft] remoteExec ["hideObjectGlobal", 2]
                        }, _aircraft, 0, false, true]
                    },
                    [_caller, _aircraft],
                    300,
                    {
                        params ["", "_aircraft"];
                        [_aircraft] remoteExec ["hideObjectGlobal", 2]
                    }
                ] call CBA_fnc_waitUntilAndExecute
            }
        }, _veh, 0, false, true, "", "!isNull (_target getVariable ['ffr_jumplight', objNull]) && {!isNull (_target getVariable ['ffr_jumplight_dummy', objNull]) && {_this == leader _this} && {(_target distance (_target getVariable ['cargoVehicles', []])#0) < 10}}"]
    }
} else {
    // For easy testing on self host server to run on everyone
    {[_aircraft, _x] remoteExec ["addAction", [0, -2] select isDedicated, true]} forEach _commonActions
}
