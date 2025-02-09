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

// Public Loadouts
private _rifleLO = [[[],[],[],["vn_b_uniform_aus_10_01",[["ACE_MapTools",1],["ACE_Flashlight_MX991",1],["grad_paceCountBeads_functions_paceCountBeads",1],["ACE_CableTie",2],["ACE_fieldDressing",10],["ACE_morphine",1],["ACE_salineIV_500",1],["ACE_splint",1],["ACE_tourniquet",1],["ACE_painkillers",1,10]]],["vn_b_vest_anzac_01",[["ACE_Canteen",2],["vn_prop_food_lrrp_01_04",1,100],["vn_prop_food_lrrp_01_05",1,100],["vn_prop_food_lrrp_01_03",1,100],["vn_m18_yellow_mag",2,1]]],[],"","",["Binocular","","","",[],[],""],["vn_b_item_map","","","ItemCompass","vn_b_item_watch",""]],[]];

private _rtoLO = [[[],[],[],["vn_b_uniform_aus_10_01",[["ACE_MapTools",1],["ACE_Flashlight_MX991",1],["grad_paceCountBeads_functions_paceCountBeads",1],["ACE_CableTie",2],["ACE_fieldDressing",10],["ACE_morphine",1],["ACE_salineIV_500",1],["ACE_splint",1],["ACE_tourniquet",1],["ACE_painkillers",1,10]]],["vn_b_vest_anzac_01",[["ACE_Canteen",2],["vn_prop_food_lrrp_01_04",1,100],["vn_prop_food_lrrp_01_05",1,100],["vn_prop_food_lrrp_01_03",1,100],["vn_m18_yellow_mag",2,1]]],["vn_b_pack_lw_06",[["ACRE_PRC117F",1]]],"","",["Binocular","","","",[],[],""],["vn_b_item_map","","","ItemCompass","vn_b_item_watch",""]],[]];

private _eodLO = [[[],[],[],["vn_b_uniform_aus_10_01",[["ACE_MapTools",1],["ACE_Flashlight_MX991",1],["grad_paceCountBeads_functions_paceCountBeads",1],["ACE_CableTie",2],["ACE_fieldDressing",10],["ACE_morphine",1],["ACE_salineIV_500",1],["ACE_splint",1],["ACE_tourniquet",1],["ACE_painkillers",1,10]]],["vn_b_vest_anzac_01",[["ACE_Canteen",2],["ACE_DefusalKit",1],["ACE_EntrenchingTool",1],["vn_prop_food_lrrp_01_04",1,100],["vn_prop_food_lrrp_01_05",1,100],["vn_prop_food_lrrp_01_03",1,100],["vn_m18_yellow_mag",2,1]]],[],"","",["Binocular","","","",[],[],""],["vn_b_item_map","","","ItemCompass","vn_b_item_watch",""]],[]];

["Base", _rifleLO, true] call ace_arsenal_fnc_addDefaultLoadout;
["EOD", _eodLO, true] call ace_arsenal_fnc_addDefaultLoadout;
["RTO", _rtoLO, true] call ace_arsenal_fnc_addDefaultLoadout;
