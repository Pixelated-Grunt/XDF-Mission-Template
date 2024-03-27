if (!isServer)  exitwith {};


_groupsC = [];

while { (true) } do {

{
if (Side (Leader _x) == INDEPENDENT) then {
	
if !(_x getVariable ["dam_Grp_readyC",false]) then {
	
_groupsC = _groupsC + [_x];
_x setVariable ["dam_Grp_readyC",true];
[_x, 35] spawn JBOY_PatrolChatter_c;
				
};
	
};
	
} forEach allGroups;

sleep 35;

};