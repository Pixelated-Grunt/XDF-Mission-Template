#include "script_component.hpp"
/*
 * Author: Killzone_Kid
 * Modified by: Pixelated_Grunt
 * Use with the CUP C-130 static to paradrop a single vehicle
 *
 * Arguments:
 * 0: Target vehicle to be dropped <OBJECT>
 * 1: Starting position of the vehicle in air <ARRAY>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_veh] call XDF_MF_fnc_paradropVehicle
 *
 * Public: No
**/


params ["_vehicle", "_destPos"];

private ["_class", "_para", "_paras", "_p"];

_vehicle allowDamage false;

// push the vehicle out of the C-130
_vehicle setPosASL _destPos;

_class = "B_parachute_02_F";
_para = createVehicle [_class, [0, 0, 0], [], 0, "FLY"];
_para setDir getDir _vehicle;
_para setPos getPos _vehicle;
_paras = [_para];
_vehicle attachTo [_para, [0, 0, abs ((0 boundingBoxReal _vehicle) # 0 # 2)]];

if ("tacs_Polaris_B" in (typeOf _vehicle)) then {
    {
        _p = createVehicle [_class, [0, 0, 0], [], 0, "FLY"];
        _paras set [count _paras, _p];
        _p attachTo [_para, [0, 0, 0]];
        _p setVectorUp _x
    } count [
        [0.5, 0.4, 0.6], [-0.5, 0.4, 0.6], [0.5, -0.4, 0.6], [-0.5, -0.4, 0.6]
        //[0.5, 0.4, 0.6], [-0.5, 0.4, 0.6]
    ]
};

[{
    params ["_object", "_parachute"];

    _parachute setVectorUp [0, 0, 1];
    isNull _object || !alive _parachute
}, {
    params ["_object","_parachute","_signals"];

    if (!alive _parachute && getPos _object # 2 < 2) then {
        _object setVectorUp surfaceNormal getPosWorld _object;
        _object setVelocity [0, 0, 0];

//        _signals params [
//            ["_signal1Class","",[""]],  //SmokeShellBlue
//            ["_signal2Class","",[""]]   //ACE_G_Chemlight_HiBlue
//        ];
//
//        private _offset = (boundingBoxReal _object) # 0;
//        private _signal1 = _signal1Class createVehicle [0,0,0];
//        _signal1 attachTo [_object,_offset];
//        private _signal2 = _signal2Class createVehicle [0,0,0];
//        _signal2 attachTo [_object,_offset];

        playSound3D [
            "a3\sounds_f\weapons\Flare_Gun\flaregun_1_shoot.wss",
            _object
        ];
        _object allowDamage true
    }
}, [_vehicle, _para, []]] call CBA_fnc_waitUntilAndExecute