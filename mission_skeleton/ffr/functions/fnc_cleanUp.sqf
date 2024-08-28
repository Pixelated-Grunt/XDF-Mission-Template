/*
Modified by: Pixelated_Grunt
Author: Ampers
Move unit out of aicraft seat to standing in ViV space

* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* -

* Example:
* [_aircraft] call ffr_main_fnc_cleanUp = {
*/

params ["_aircraft"];

// Close ramp
private _jumpInfo = _aircraft getVariable "ffr_jumpInfo";
_jumpInfo params ["_animInfo"];
_animInfo params ["_animType", "_anims"];
{
    switch (_animType) do {
        case (""): {
            _aircraft animate [_x, 0];
        };
        case ("source"): {
            _aircraft animateSource [_x, 0];
        };
        case ("door"): {
            _aircraft animateDoor [_x, 0];
        };
    };
} forEach _anims;

{
    deleteVehicle (_aircraft getVariable [_x, objNull]);
    _aircraft setVariable [_x, nil];
} forEach ["ffr_dummy", "ffr_helper", "ffr_jumplight", "ffr_jumplight_dummy"];
