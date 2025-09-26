if (!isServer) exitwith {};

private _grpB = _this select 0;
private _intervalB = _this select 1;

while { ({ alive _x } count(units _grpB) > 1) } do {
    if (!(behaviour leader _grpB == "COMBAT") || !(behaviour leader _grpB == "STEALTH")) then {
       private ["_membersB", "_memberB", "_soundB", "_random_soundB", "_dist"];

       _membersB = units _grpB select {!captive _x};
       _memberB = selectRandom _membersB;
       _dist = round random [30, 150, 200];

       // add-remove sounds here
       _soundB = [
           "vnTalksN01",
           "vnTalksN02",
           "vnTalksN03",
           "vnTalksN04",
           "vnTalksN05",
           "vnTalksN06",
           "vnTalksN07",
           "vnTalksN08",
           "vnTalksN09",
           "vnTalksN10",
           "vnTalksN11",
           "vnTalksN12",
           "vnTalksN13",
           "vnTalksN14",
           "vnTalksN15",
           "vnTalksN16",
           "vnTalksN17",
           "vnTalksN18",
           "vnTalksN19",
           "vnTalksN20",
           "vnTalksN21",
           "vnTalksN22",
           "vnTalksN23",
           "vnTalksN24",
           "vnTalksN25",
           "vnTalksN26",
           "vnTalksN27",
           "vnTalksN28",
           "vnTalksN29",
           "vnTalksN30",
           "vnRadioN01",
           "vnRadioN02",
           "vnRadioN03",
           "vnRadioN04",
           "vnRadioN05",
           "vnRadioN06",
           "vnRadioN07",
           "vnRadioN08",
           "vnRadioN09",
           "vnRadioN10",
           "vnRadioN11",
           "vnRadioN12",
           "vnRadioN13",
           "vnRadioN14",
           "vnRadioN15",
           "vnRadioN16",
           "vnRadioN17",
           "vnRadioN18",
           "vnRadioN19",
           "vnRadioN20",
           "noAudioN01",
           "noAudioN02",
           "noAudioN03",
           "noAudioN04",
           "noAudioN05",
           "noAudioN06",
           "noAudioN07",
           "noAudioN08",
           "noAudioN09",
           "noAudioN10",
           "noAudioN11",
           "noAudioN12",
           "noAudioN13",
           "noAudioN14",
           "noAudioN15",
           "noAudioN16",
           "noAudioN17",
           "noAudioN18",
           "noAudioN19",
           "noAudioN20",
           "noAudioN21",
           "noAudioN22",
           "noAudioN23",
           "noAudioN24",
           "noAudioN25",
           "noAudioN26",
           "noAudioN27",
           "noAudioN28",
           "noAudioN29",
           "noAudioN30"
       ];
       _random_soundB = selectRandom _soundB;
       [_memberB, [_random_soundB, _dist, 1]] remoteExec["say3D", 0];
       //diag_log format["AI: %1 playing sound: %2 at distance: %3", _memberB, _random_soundB, _dist];
    };
    sleep (_intervalB + random(1));
};
