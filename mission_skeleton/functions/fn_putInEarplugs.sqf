#include "script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Puts in earplugs. A stripped down version of ace hearing function.
 *
 * Arguments:
 * 0: Unit (player) <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ace_player] call XDF_MF_fnc_putInEarplugs
 *
 * Public: No
 */

params ["_player"];

// Plugs in inventory, putting them in
_player removeItem "ACE_EarPlugs";

_player setVariable ["ACE_hasEarPlugsIn", true, true];

//Force an immediate fast volume update:
[[true]] call ace_hearing_updateVolume;

[] call ace_hearing_updateHearingProtection;
