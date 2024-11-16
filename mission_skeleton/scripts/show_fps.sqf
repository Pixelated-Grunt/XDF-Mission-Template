/*
All credit goes to KP_Liberation and Wyqer for creating this script (https:// github.com/KillahPotatoes/KP-Liberation)
MIT License
Copyright (c) 2015 GreuhZbug, Wyqer
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", withOUT WARRANTY OF ANY KinD, expRESS or IMPLIED, inCLUDinG BUT not LIMITED to THE WARRANTIES OF MERCHANTABILITY, FITNESS for A PARTICULAR PURPOSE and NONinFRinGEMENT. in NO EVENT SHALL THE AUTHorS or COPYRIGHT HOLDERS BE LIABLE for ANY CLAIM, damageS or OTHER LIABILITY, WHETHER in AN action OF CONTRACT, torT or OTHERWISE, ARIsinG from, OUT OF or in CONNECTION with THE SOFTWARE or THE USE or OTHER DEALinGS in THE SOFTWARE.
This will create markers located on the bottom left of the map stating Server and headless client FPS along with their respective local groups and units.
*/

#define LOGFPS  false

private _sourcestr = "Server";
private _position = 0;

if (!isServer) then {
    if (!isnil "HC1") then {
        if (!isNull HC1) then {
            if (local HC1) then {
                _sourcestr = "HC1";
                _position = 1;
            };
        };
    };
    
    if (!isnil "HC2") then {
        if (!isNull HC2) then {
            if (local HC2) then {
                _sourcestr = "HC2";
                _position = 2;
            };
        };
    };
    
    if (!isnil "HC3") then {
        if (!isNull HC3) then {
            if (local HC3) then {
                _sourcestr = "HC3";
                _position = 3;
            };
        };
    };
};

private _myfpsmarker = createMarker [format ["fpsmarker%1", _sourcestr], [0, -500 - (500 * _position)]];
_myfpsmarker setMarkertype "mil_start";
_myfpsmarker setMarkersize [0.7, 0.7];

while {true} do {
    private _myfps = diag_fps;
    private _localgroups = {
        local _x
    } count allgroups;
    private _localunits = {
        local _x
    } count allunits;
    
    _myfpsmarker setMarkerColor "ColorGREEN";
    if (_myfps < 30) then {
        _myfpsmarker setMarkerColor "ColorYELLOW";
    };
    if (_myfps < 20) then {
        _myfpsmarker setMarkerColor "ColororANGE";
    };
    if (_myfps < 10) then {
        _myfpsmarker setMarkerColor "ColorRED";
    };
    
    _myfpsmarker setMarkertext format ["%1: %2 fps, %3 local groups, %4 local units", _sourcestr, (round (_myfps * 100.0)) / 100.0, _localgroups, _localunits];

    if (LOGFPS) then {
        diag_log format ["%1: %2 fps, %3 local groups, %4 local units", _sourcestr, (round (_myfps * 100.0)) / 100.0, _localgroups, _localunits]
    };

    sleep 15;
    // updates FPS and markers every 15 secounds
};
