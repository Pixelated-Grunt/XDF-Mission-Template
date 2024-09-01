#include "functions\script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Description: Init script for server side setup
 *
 */


/*********************************************************
 * MISSION SPECIFIC - Put scripts for current mission only
 *********************************************************/



/********************************************
 * COMMON SECTION - Settings for all missions
 ********************************************/
// Add content to predefine arsenals with "xdf_arsenal" as prefix in mission 
{if ("xdf_arsenal" in _x) then {[missionNamespace getVariable _x] call FUNC(fillArsenal)}} forEach allVariables missionNamespace;

// Show server FPS in map screen
[] execVM "scripts\show_fps.sqf";
diag_log text "--------------------[Executed show_fps on Server]--------------------"; //will show in server logs
