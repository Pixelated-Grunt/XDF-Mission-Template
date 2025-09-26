if (!isServer) exitwith {};

private _grpC = _this select 0;
private _intervalC = _this select 1;

while { ({ alive _x } count(units _grpC) > 1) } do {
    if (behaviour leader _grpC == "COMBAT") then {
       private ["_membersC", "_memberC", "_soundC", "_random_soundC", "_dist"];

       _membersC = units _grpC select {!captive _x};
       _memberC = selectRandom _membersC;
       _dist = round random [50, 200, 250];

       // add-remove sounds here
       _soundC = [
           "vnTalksY01",
           "vnTalksY02",
           "vnTalksY03",
           "vnTalksY04",
           "vnTalksY05",
           "vnTalksY06",
           "vnTalksY07",
           "vnTalksY08",
           "vnTalksY09",
           "vnTalksY10",
           "vnTalksY11",
           "vnTalksY12",
           "vnTalksY13",
           "vnTalksY14",
           "vnTalksY15",
           "vnTalksY16",
           "vnTalksY17",
           "vnTalksY18",
           "vnTalksY19",
           "vnTalksY20",
           "vnTalksY21",
           "vnTalksY22",
           "vnTalksY23",
           "vnTalksY24",
           "vnTalksY25",
           "vnTalksY26",
           "vnTalksY27",
           "vnTalksY28",
           "vnTalksY29",
           "vnTalksY30",
           "vnRadioY01",
           "vnRadioY02",
           "vnRadioY03",
           "vnRadioY04",
           "vnRadioY05",
           "vnRadioY06",
           "vnRadioY07",
           "vnRadioY08",
           "vnRadioY09",
           "vnRadioY10",
           "vnRadioY11",
           "vnRadioY12",
           "vnRadioY13",
           "vnRadioY14",
           "vnRadioY15",
           "vnRadioY16",
           "vnRadioY17",
           "vnRadioY18",
           "vnRadioY19",
           "vnRadioY20",
           "noAudioN01",
           "noAudioN02",
           "noAudioN03",
           "noAudioN04",
           "noAudioN05",
           "noAudioN30"
       ];
       _random_soundC = selectRandom _soundC;
       [_memberC, [_random_soundC, _dist, 1]] remoteExec["say3D", 0]
    };
    sleep (_intervalC + random(1));
};
