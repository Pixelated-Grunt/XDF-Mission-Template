if (!isServer) exitwith {};

private _grpD = _this select 0;
private _intervalD = _this select 1;

while { ({ alive _x } count(units _grpD) > 1) } do {
    if ((behaviour leader _grpD == "Safe")) then {
       private ["_membersD", "_memberD", "_soundD", "_random_soundD", "_dist"];

       _membersD = units _grpD select {!captive _x};
       _memberD = selectRandom _membersD;
       _dist = round random [13, 91, 169];

       // add-remove sounds here
       _soundD = [
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
       _random_soundD = selectRandom _soundD;
       [_memberD, [_random_soundD, _dist, 1]] remoteExec["say3D", 0]
    };
    sleep _intervalD + random(1);
};
