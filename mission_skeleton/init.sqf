/*
 * Author: Pixelated_Grunt
 * Description: Common init file
 *
 */


/*********************************************************
 * MISSION SPECIFIC - Put scripts for current mission only
 *********************************************************/



/**********************************************
 * COMMON SECTION - Settings for every missions
 **********************************************/
// Setup default radio nets
["ACRE_PRC152", "default", "isc"] call acre_api_fnc_copyPreset;

["ACRE_PRC152", "isc", 1, "label", "SQDNET 1"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 1, "frequencyRX", 42.1] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 1, "frequencyTX", 42.1] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 2, "label", "SQDNET 2"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 2, "frequencyRX", 42.2] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 2, "frequencyTX", 42.2] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 3, "label", "SQDNET 3"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 3, "frequencyRX", 42.3] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 3, "frequencyTX", 42.3] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 4, "label", "PLTNET"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 4, "frequencyRX", 43.1] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 4, "frequencyTX", 43.1] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 5, "label", "SUPPORT"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 5, "frequencyRX", 44.1] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "isc", 5, "frequencyTX", 44.1] call acre_api_fnc_setPresetChannelField;

["ACRE_PRC152", "isc"] call acre_api_fnc_setPreset;

// List of XDF access items
XDF_MF_accessItems = createHashMapFromArray [
    ["SETERV", "ACE_Cellphone"],
    ["CLRVEG", "ACE_EntrenchingTool"]
];

// View Distance Settings
tawvd_disablenone = true;

// Free Fall off the Ramp
[] execVM "ffr\ffr_init.sqf";

// Add menu actions to various mission objects with predefined variable names
{
    // Arsenals
    private _arsenal = objNull;

    if ("xdf_arsenal" in _x) then {
        _arsenal = missionNamespace getVariable _x;

        // Open arsenal
        _arsenal addAction [
            "<t color='#f5d142'>Open Arsenal</t>", {
                params ["_target", "_caller"];

                [_target, _caller] call ace_arsenal_fnc_openBox
            }, [], 9, false, true, ""
        ];

        // Add move player menu action
        _arsenal addAction [
            "<t color='#0040ff'>Move Player</t>", {
                openMap [true, true];
                sleep 1;
                onMapSingleClick "player setPos _pos; openMap [false, false]; onMapSingleClick ''; true"
            }, [], 8, false, true, ""
        ];

        // Add heal menu action
        _arsenal addAction [
            "<t color='#00ff00'>Heal Player</t>", {
                [_this select 1] call ace_medical_treatment_fnc_fullHealLocal
            }, [], 7, false, true, ""
        ];
    };

    // HALO points
    if ("xdf_halo_pt" in _x) then {
        private _haloObj = missionNamespace getVariable _x;

        _haloObj addAction [
            "HALO Jump", {
                params ["", "_caller"];
                private _callerPos = getPos _caller;

                openMap [true, false];
                sleep 1;
                onMapSingleClick "player setPos _pos; openMap [false, false]; onMapSingleClick ''; true";
                waitUntil { !(visiblemap) };
                if (_callerPos isNotEqualTo getPos _caller) then { [_caller, 2500, false, false, false] execVM "scripts\cob_halo.sqf" }
            },
            [],
            1.5,
            true,
            true,
            ""
        ]
    }
} forEach allVariables missionNamespace;
