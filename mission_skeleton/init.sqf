/*
 * Author: Pixelated_Grunt
 * Description: Common init file
 *
 */


/*
 * COMMON SECTION - Settings for every missions
 *
 */

// List of XDF access items
XDF_MF_accessItems = createHashMapFromArray [
    ["SETERV", "ACRE_PRC152"],
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


/*
 * MISSION SPECIFIC - Put scripts for current mission only
 *
 */
