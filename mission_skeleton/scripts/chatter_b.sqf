if (!isServer)  exitwith {};


_groupsB = [];

while { (true) } do {

{
if (Side (Leader _x) == East) then {
	
if !(_x getVariable ["dam_Grp_readyB",false]) then {
	
_groupsB = _groupsB + [_x];
_x setVariable ["dam_Grp_readyB",true];
[_x, 50] spawn JBOY_PatrolChatter_b;
				
};
	
};
	
} forEach allGroups;

sleep 50;

};