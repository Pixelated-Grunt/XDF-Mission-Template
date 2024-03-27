/*
 * Author: Pixelated_Grunt
 * Last modified (common section): 20240321
 * Description: Init script for server side setup
 *
 */


/*
 * COMMON SECTION - Settings for all missions
 *
 */

// Add content to predefine arsenals with "xdf_arsenal" as prefix in mission 
[] execVM "scripts\setupXDFArsenals.sqf";

// Show server FPS in map screen
[] execVM "scripts\show_fps.sqf";
diag_log text "--------------------[Executed show_fps on Server]--------------------"; //will show in server logs


/*
 * MISSION SPECIFIC - Put scripts for current mission only
 *
 */
