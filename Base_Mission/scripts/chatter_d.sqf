if (!isServer)  exitwith {};


_groupsD = [];

while { (true) } do {

{
if (Side (Leader _x) == INDEPENDENT) then {
	
if !(_x getVariable ["dam_Grp_readyD",false]) then {
	
_groupsD = _groupsD + [_x];
_x setVariable ["dam_Grp_readyD",true];
[_x, 50] spawn JBOY_PatrolChatter_d;
				
};
	
};
	
} forEach allGroups;

sleep 50;

};