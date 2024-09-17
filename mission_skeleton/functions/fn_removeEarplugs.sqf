#include "script_component.hpp"
/*
 * Author: Pixelate_Grunt
 * Takes out earplugs. A stripped down version of ace hearing function.
 *
 * Arguments:
 * 0: Unit (player) <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ace_player] call XDF_MF_fnc_removeEarplugs
 *
 * Public: No
 */

params ["_player"];

if !([_player, "ACE_EarPlugs"] call CBA_fnc_canAddItem) exitWith { // inventory full
    hint "Inventory full cannot fit earplugs"
};

// Plugs already in and removing them.
_player addItem "ACE_EarPlugs";

_player setVariable ["ACE_hasEarPlugsIn", false, true];

//Force an immediate fast volume update:
[[true]] call ace_hearing_updateVolume;

[] call ace_hearing_updateHearingProtection;
