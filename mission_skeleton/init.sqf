/*
 * Author: Pixelated_Grunt
 * Description: Common init file
 *
 */


/*
 * COMMON SECTION - Settings for every missions
 *
 */

#define MAINRADIO "ACRE_PRC77"
#define RADIOFREQ 41

// View Distance Settings
tawvd_disablenone = true;

// Johnny Boy chatter script that utilises Fox's audio files for side EAST
JBOY_PatrolChatter_a = compile preprocessfilelinenumbers "scripts\JBOY_PatrolChatter_a.sqf";
JBOY_PatrolChatter_b = compile preprocessfilelinenumbers "scripts\JBOY_PatrolChatter_b.sqf";
[] execVM "scripts\Chatter_a.sqf";
[] execVM "scripts\Chatter_b.sqf";

//Johnny Boy chatter script that utilises Fox's audio files for side INDEPENDENT
//JBOY_PatrolChatter_c = compile preprocessfilelinenumbers "scripts\JBOY_PatrolChatter_c.sqf";
//JBOY_PatrolChatter_d = compile preprocessfilelinenumbers "scripts\JBOY_PatrolChatter_d.sqf";
//[] execVM "scripts\Chatter_c.sqf";
//[] execVM "scripts\Chatter_d.sqf";

// Setup default radio frequency
[MAINRADIO, "default", "xdf_default_net"] call acre_api_fnc_copyPreset;
[MAINRADIO, "xdf_default_net", 1, "label", "NET"] call acre_api_fnc_setPresetChannelField;
[MAINRADIO, "xdf_default_net", 1, "frequencyRX", RADIOFREQ] call acre_api_fnc_setPresetChannelField;
[MAINRADIO, "xdf_default_net", 1, "frequencyTX", RADIOFREQ] call acre_api_fnc_setPresetChannelField;
[MAINRADIO, "xdf_default_net"] call acre_api_fnc_setPreset;

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

    // Table top radios
    if ("xdf_ncs" in _x) then {
        private _radio = missionNamespace getVariable _x;

        _radio addAction [
            "Turn Radio On", {
                params ["_target", "", "_actionId"];
                _target removeAction _actionId;
                [_target, ["ACRE_VRC64", "Main Dash", "Dash", false, ["external"], [], MAINRADIO, [], []], true] remoteExec ["acre_api_fnc_addRackToVehicle", 2];
            },
            [],
            9,
            true,
            true,
            ""
        ];
    };

    // HALO points
    if ("xdf_halo_pt" in _x) then {
        private _haloObj = missionNamespace getVariable _x;

        _haloObj addAction [
            "HALO Jump", {
                params ["_target"];

                openMap [true, true];
                sleep 1;
                onMapSingleClick "player setPos _pos; openMap [false, false]; onMapSingleClick ''; true";
                [_target, 2500, false, false, true] execVM "scripts\cob_halo.sqf"
            },
            [],
            1.5,
            true,
            true,
            ""
        ]
    };

    // LALO points
    if ("xdf_lalo_pt" in _x) then {
        private _laloObj = missionNamespace getVariable _x;

        _laloObj addAction [
            "LALO Jump", {
                params ["_target"];

                openMap [true, true];
                sleep 1;
                onMapSingleClick "player setPos _pos; openMap [false, false]; onMapSingleClick ''; true";
                [_target, 500, false, false, true] execVM "scripts\cob_halo.sqf"
            },
            [],
            1.5,
            true,
            true,
            ""
        ]
    }
} forEach allVariables missionNamespace;


/*
 * MISSION SPECIFIC - Put scripts for current mission only
 *
 */
