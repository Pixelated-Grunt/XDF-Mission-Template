if (!isServer)  exitwith {};


_groupsA = [];

while { (true) } do {

{
if (Side (Leader _x) == East) then {
	
if !(_x getVariable ["dam_Grp_readyA",false]) then {
	
_groupsA = _groupsA + [_x];
_x setVariable ["dam_Grp_readyA",true];
[_x, 35] spawn JBOY_PatrolChatter_a;
				
};
	
};
	
} forEach allGroups;

sleep 35;

};