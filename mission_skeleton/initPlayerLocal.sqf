/*
 * Author: Pixelated_Grunt
 * Last modified: 20240324
 * Description: Init script to setup players who joined the server
 *
 */


/*
 * COMMON SECTION - Settings for all missions
 *
 */

params ["_player", "_didJIP"];

// Add briefing to the mission map screen
[] execVM "scripts\briefing.sqf";

// Place ERV respawn point with ACE self-interaction menu, player needs to carry a PRC77 radio
private ["_statement", "_condition", "_action"];

_condition = {[_player, "ACRE_PRC77"] call acre_api_fnc_hasKindofradio};
_statement = {
    private _group = groupId group _player;
    private _markerName = format["respawn_west_%1", _group];
    private _markerText = format["%1 ERV", _group];

    openMap true;
    [_markerName, _markerText] onMapSingleClick {
        private _marker = _this select 0;
        private _markerText = _this select 1;

        if !(_marker in allMapMarkers) then {
            createMarkerLocal [_marker, [0,0,0]];
        };
        _marker setMarkerColorLocal 'ColorBlue';
        _marker setMarkerTypeLocal 'mil_end';
        _marker setMarkerText _markerText;
        _marker setMarkerPos _pos;
        true;
    };

    addMissionEventHandler ["Map", {
        params ["_mapIsOpened", "_mapIsForced"];

        if !_mapIsOpened then {
            onMapSingleClick "";
            removeMissionEventHandler ["Map", _thisEventHandler];
        };
    }];
};

_action = ["Set ERV", "Set Emergency RV", "\A3\ui_f\data\map\markers\military\end_CA.paa", _statement, _condition] call ace_interact_menu_fnc_createAction;
[(typeOf _player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;


/*
 * MISSION SPECIFIC - Put scripts for current mission only
 *
 */
