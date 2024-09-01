#include "functions\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Description: Init script to setup players who joined the server
 *
 */


params ["_player"];
/*********************************************************
 * MISSION SPECIFIC - Put scripts for current mission only
 *********************************************************/



/********************************************
 * COMMON SECTION - Settings for all missions
 ********************************************/
// Create ACE menu
_player call FUNC(createUnitAceMenu);

// Add briefing to the mission map screen
[] execVM "scripts\briefing.sqf";
