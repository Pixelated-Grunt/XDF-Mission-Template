/*
 * Author: Pixelated_Grunt
 * Description: Include file contains all arsenal whitelisted items
 *
 */

if !(isServer) exitWith {};

//ACE3 items
private _ace3Items = ["ACE_wirecutter", "ACE_UAVBattery", "ACE_tourniquet", "ACE_SpraypaintBlue", "ACE_SpraypaintRed", "ACE_salineIV_250", "ACE_rope3", "ACE_rope12", "ACE_plasmaIV_250", "ACE_painkillers", "grad_paceCountBeads_functions_paceCountBeads", "acex_intelitems_notepad", "ACE_MRE_SteakVegetables", "ACE_MRE_MeatballsPasta", "ACE_MRE_ChickenTikkaMasala", "ACE_MRE_BeefStew", "ACE_morphine", "ACE_MapTools", "ACE_Flashlight_XL50", "ACE_Clacker", "ACE_IR_Strobe_Item", "ACE_epinephrine", "ACE_EntrenchingTool", "ACE_EarPlugs", "ACE_DefusalKit", "ACE_Canteen", "ACE_bloodIV_500", "ACE_bloodIV_250", "ACE_elasticBandage", "ACE_quikclot", "ACE_fieldDressing", "ACE_M14", "ACE_M84", "ACE_Chemlight_HiRed", "ACE_NVG_Wide_Black", "ACE_FlareTripMine_Mag", "ACE_Altimeter"];

//ACRE2 items
private _acre2Items = ["ACRE_PRC117F", "ACRE_PRC152"];

//CUP items
private _cupItems = ["CUP_arifle_XM8_Sharpshooter", "CUP_sgun_slamfire", "CUP_H_PMC_Beanie_Khaki", "CUP_H_PMC_Beanie_Black", "CUP_HandGrenade_M67", "CUP_B_USMC_AssaultPack", "CUP_B_USPack_Coyote", "CUP_B_USPack_Black", "CUP_B_AssaultPack_Black", "CUP_B_TacticalPack_CCE", "CUP_H_Ger_M92_RGR", "CUP_V_I_RACS_Carrier_Vest_3", "CUP_U_B_BDUv2_gloves_desert", "CUP_U_B_BDUv2_desert", "CUP_I_B_PMC_Unit_33", "CUP_I_B_PMC_Unit_31", "CUP_I_B_PMC_Unit_24", "CUP_I_B_PMC_Unit_23", "CUP_U_C_Policeman_01", "CUP_U_C_Suit_01", "CUP_U_C_Functionary_jacket_01", "CUP_FR_NeckScarf3", "CUP_G_Oakleys_Drk", "CUP_NVG_PVS15_black", "CUP_SOFLAM", "CUP_PipeBomb_M", "CUP_muzzle_snds_M3A1_blk", "CUP_acc_Glock17_Flashlight", "CUP_optic_Elcan_SpecterDR_black", "CUP_optic_AN_PVS_10_black", "CUP_hgun_Colt1911", "CUP_hgun_Glock17_blk", "CUP_launch_M72A6", "CUP_launch_FIM92Stinger", "CUP_launch_Javelin", "CUP_lmg_L7A2_Flat", "CUP_lmg_M249_E2", "CUP_smg_MP5A5_Rail", "CUP_arifle_M4A1_SOMMOD_black", "CUP_arifle_HK416_CQB_M203_Black", "CUP_arifle_HK416_Black"];

//Community Factions Project items
private _cfpItems = ["CFP_BoonieHat_DCU", "CFP_Lungee_Brown", "CFP_BoonieHat_DBDU", "CFP_U_BattleDressUniform_woodlanddark", "CFP_Polo_RealMadrid"];

//Specialist Military Arms items
private _smaItems = ["sma_minimi_mk3_762tsb", "SMA_Steyr_AUG_F", "SMA_M4_GL"];

//Theseus Services items
private _tacsItems = ["tacs_Helmet_Ballistic_White", "tacs_Helmet_Ballistic_DarkBlack", "tacs_Uniform_Long_Black", "tacs_Uniform_Garment_LS_BS_BP_BB", "tacs_Uniform_Plaid_JP_CB_BP_BB", "tacs_Uniform_TShirt_JP_GS_TP_BB"];

//Generic items
private _genericItems = ["launch_NLAW_F", "launch_MRAWS_green_F", "optic_ERCO_blk_F", "acc_pointer_IR", "ClaymoreDirectionalMine_Remote_Mag", "DemoCharge_Remote_Mag", "ItemGPS", "B_UavTerminal", "ItemCompass", "Laserdesignator_01_khk_F", "Rangefinder", "G_Diving", "G_Sport_Blackred", "G_WirelessEarpiece_F", "U_B_T_Soldier_F", "V_PlateCarrier2_blk", "SP_Modular1_White", "B_Carryall_blk", "B_FieldPack_blk", "B_FieldPack_khk", "B_FieldPack_oli", "Chemlight_green", "SmokeShellRed", "SmokeShellYellow", "SmokeShell", "FirstAidKit", "MineDetector", "H_HelmetB_desert", "H_HelmetB_tna_F", "H_HelmetB_plain_wdl", "H_Watchcap_blk", "H_Beret_blk", "SP_BoonieHat_Green", "SP_BoonieHat_Black"];

//Complete list
private _fullList = _ace3Items + _acre2Items + _cupItems + _cfpItems + _smaItems + _tacsItems + _genericItems;

_fullList
