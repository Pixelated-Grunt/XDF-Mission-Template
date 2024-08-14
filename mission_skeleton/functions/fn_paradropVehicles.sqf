#include "script_component.hpp"
/*
 * Author: Killzone_Kid
 * Modified by: Pixelated_Grunt
 * Use with the CUP C-130 static to paradrop vehicles
 *
 * Arguments:
 * 0: Target vehicle to be dropped <OBJECT>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_veh] call XDF_MF_fnc_paradropVehicle
 *
 * Public: No
**/


params ["_vehicle"];

private ["_class", "_para", "_paras", "_p", "_startPos"];

// Drop the vehicle below the C-130
_startPos = getPos _vehicle;
_startPos set [2, _startPos # 2 - 20];
_vehicle setPos _startPos;

_class = format [
    "%1_parachute_02_F", 
    toString [(toArray faction _vehicle) select 0]
];

_para = createVehicle [_class, [0, 0, 0], [], 0, "FLY"];
_para setDir getDir _vehicle;
_para setPos getPos _vehicle;
_paras = [_para];
_vehicle attachTo [_para, [0, 2, 0]];

if ("tacs_Polaris_B" in (typeOf _vehicle)) then {
    {
        _p = createVehicle [_class, [0, 0, 0], [], 0, "FLY"];
        _paras set [count _paras, _p];
        _p attachTo [_para, [0, 0, 0]];
        _p setVectorUp _x
    } count [
        [0.5, 0.4, 0.6], [-0.5, 0.4, 0.6], [0.5, -0.4, 0.6], [-0.5, -0.4, 0.6]
    ]
};

[_vehicle, _paras] spawn {
    private ["_veh", "_vel", "_time"];

    _veh = _this select 0;
    waitUntil { getPos _veh select 2 < 4 };
    _vel = velocity _veh;
    detach _veh;
    _veh setVelocity _vel;
    playSound3D [
        "a3\sounds_f\weapons\Flare_Gun\flaregun_1_shoot.wss",
        _veh
    ];
    {
        detach _x;
        _x disableCollisionWith _veh;
    } count (_this select 1);
    _time = time + 5;
    waitUntil { time > _time };
    {
        if (!isNull _x) then { deleteVehicle _x };
    } count (_this select 1)
}
