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
private _rifleLO = [[],[],[],["tacs_Uniform_Combat_RS_TS_TP_TB",[["greenmag_item_speedloader",1],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["kat_AFAK",1],["ACRE_PRC343_ID_1",1],["ItemAndroid",1],["ItemcTabHCam",1]]],[],["CUP_B_AFU_IIID_MM14",[["ACE_Canteen",1],["ACE_MRE_BeefStew",1],["ACE_plasmaIV_500",2]]],"","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]];

private _rtoLO = [[],[],[],["tacs_Uniform_Combat_RS_TS_TP_TB",[["greenmag_item_speedloader",1],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["kat_AFAK",1],["ACRE_PRC343_ID_1",1],["ItemAndroid",1],["ItemcTabHCam",1],["ACE_Cellphone",1]]],[],["CUP_B_AFU_IIID_MM14",[["ACE_Canteen",1],["ACE_MRE_BeefStew",1],["ACE_plasmaIV_500",2],["ACRE_PRC152_ID_1",1]]],"","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]];

private _eodLO = [[],[],[],["tacs_Uniform_Combat_RS_TS_TP_TB",[["greenmag_item_speedloader",1],["ACE_MapTools",1],["ACE_Flashlight_XL50",1],["kat_AFAK",1],["ACRE_PRC343_ID_1",1],["ItemAndroid",1],["ItemcTabHCam",1]]],[],["CUP_B_AFU_IIID_MM14",[["ACE_Canteen",1],["ACE_MRE_BeefStew",1],["ACE_plasmaIV_500",2],["ACE_DefusalKit",1],["ACE_EntrenchingTool",1],["ToolKit",1]]],"","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]];

["Base", _rifleLO, true] call ace_arsenal_fnc_addDefaultLoadout;
["EOD", _eodLO, true] call ace_arsenal_fnc_addDefaultLoadout;
["RTO", _rtoLO, true] call ace_arsenal_fnc_addDefaultLoadout;

// Simplex resupply items
sss_logistics_medicalDefaults = ["kat_MFAK", "kat_AFAK", "ACE_plasmaIV", "ACE_plasmaIV_500", "ACE_plasmaIV_250"];
