["staboDeploy",{
    params ["_vehicle"];

    private _stabo = "stabo" createVehicle [0,0,0];
    _stabo setPosASL (getPosASL _vehicle vectorAdd [0,0,-10]);
    _vehicle setVariable ["stabo",_stabo,true];
    
    private _rope = ropeCreate [_vehicle,"slingload0",_stabo,[0,0,8.2],1]; 
    _vehicle setVariable ["staboRope",_rope,true];
}] call CBA_fnc_addEventHandler;

["staboRaise",{
    params ["_vehicle"];
    ropeUnwind [_vehicle getVariable ["staboRope",objNull],3,-(getPos _vehicle # 2 - 10),true];
}] call CBA_fnc_addEventHandler;

["staboLower",{
    params ["_vehicle"];
    ropeUnwind [_vehicle getVariable ["staboRope",objNull],3,(getPos _vehicle # 2 - 10),true];
}] call CBA_fnc_addEventHandler;

["staboDestroy",{
    params ["_vehicle"];
    ropeDestroy (_vehicle getVariable ["staboRope",objNull]);
    deleteVehicle (_vehicle getVariable ["stabo",objNull]);
}] call CBA_fnc_addEventHandler;

["Helicopter","initPost",{
    params ["_vehicle"];

    _vehicle addAction ["Drop S.T.A.B.O",{
        params ["_vehicle"];
        ["staboDeploy",[_vehicle],_vehicle] call CBA_fnc_targetEvent;
    },nil,1.5,true,true,"","getPos _originalTarget # 2 > 10 && isNull (_originalTarget getVariable ['staboRope',objNull])",60,false,"",""];
    
    _vehicle addAction ["Pull-Up/Despawn S.T.A.B.O",{
        params ["_vehicle"];
        ["staboDestroy",[_vehicle],_vehicle] call CBA_fnc_targetEvent;
    },nil,1.5,true,true,"","!isNull (_originalTarget getVariable ['staboRope',objNull])",60,false,"",""];

    _vehicle addAction ["Raise S.T.A.B.O",{
        params ["_vehicle"];
        ["staboRaise",[_vehicle],_vehicle] call CBA_fnc_targetEvent;
    },nil,1.5,true,true,"","!isNull (_originalTarget getVariable ['staboRope',objNull])",60,false,"",""];

    _vehicle addAction ["Lower S.T.A.B.O",{
        params ["_vehicle"];
        ["staboLower",[_vehicle],_vehicle] call CBA_fnc_targetEvent;
    },nil,1.5,true,true,"","!isNull (_originalTarget getVariable ['staboRope',objNull])",60,false,"",""];
}] call CBA_fnc_addClassEventHandler;