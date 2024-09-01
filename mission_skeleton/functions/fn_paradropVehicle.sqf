#include "script_component.hpp"
/*
 * Author: Killzone_Kid
 * Modified by: Pixelated_Grunt
 * Use with the CUP C-130 static to paradrop a single vehicle
 *
 * Arguments:
 * 0: Target vehicle to be dropped <OBJECT>
 * 1: Carrier object <OBJECT>
 * 2: Optional: Distance away from the plane before chute deploys <ARRAY> (default: 50)
 * 3: Optional: Vehicle will be released backward <BOOL> (default: true)
 *
 * Return Value:
 * Nil
 *
 * Example:
 * [_veh] call XDF_MF_fnc_paradropVehicle
 *
 * Public: No
**/


if (!isServer) exitWith {};
params [
    ["_vehicle", objNull, [objNull]],
    ["_aircraft", objNull, [objNull]],
    ["_dist", 50, [0]],
    ["_dir", true, [true]]
];

if ((_vehicle distance _aircraft) > 10) exitWith {WARNING_2("%1 is too far from %2 for paradrop.", _vehicle, _aircraft)};
private ["_class", "_para", "_paras", "_p"];

_vehicle allowDamage false;
if (_dir) then {_dist = -(_dist)};

//push the vehicle out of the C-130 static
_vehicle setVelocityModelSpace [0, _dist, 0];

[
    {
        params ["_vehicle", "_dist"];
        (velocityModelSpace _vehicle#1) <= (_dist + -1)
    },
    {
        params ["_vehicle"];
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
                //[0.5, 0.4, 0.6], [-0.5, 0.4, 0.6], [0.5, -0.4, 0.6], [-0.5, -0.4, 0.6]
                [0.5, 0.4, 0.6], [-0.5, 0.4, 0.6]
            ]
        };

        [{
            params ["_object", "_parachute"];

            _parachute setVectorUp [0, 0, 1];
            isNull _object || !alive _parachute
        }, {
            params ["_object","_parachute"];

            if (!alive _parachute && getPos _object # 2 < 2) then {
                _object setVectorUp surfaceNormal getPosWorld _object;
                _object setVelocity [0, 0, 0];

                playSound3D [
                    "a3\sounds_f\weapons\Flare_Gun\flaregun_1_shoot.wss",
                    _object
                ];
                _object allowDamage true
            }
        }, [_vehicle, _para, []]] call CBA_fnc_waitUntilAndExecute
    },
    [_vehicle, _dist]
] call CBA_fnc_waitUntilAndExecute
