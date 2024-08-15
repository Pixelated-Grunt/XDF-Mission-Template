#include "script_component.hpp"
/*
 * Author: Pixelated_Grunt
 * Create Ace interaction menu structure and entries
 *
 * Arguments:
 * 0: Player who the menu is created for <OBJECT>
 *
 * Return Value:
 * Nil
 *
 * Example:
 * player call XDF_MF_fnc_createUnitAceMenu
 *
 * Public: No
**/


if !(hasInterface) exitWith { [] };

params ["_player"];

[_player, 1, ["ACE_SelfActions"], [
    QUOTE(PREFIX),
    "D F",
    "a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",
    {},
    {
        private _actions = count ([_this # 1] call FUNC(getUnitAllowedActions));
        private _res = [false, true] select ( _actions > 0 );

        _player setVariable [QGVARMAIN(aceMenuExist), _res];
        _res
    },
    {
        params ["", "_player"];

        private _unitAllowedActions = _player getVariable ["UnitAllowedActions", []];
        private _actions = [];

        {
            switch _x do {
                private "_action";

                case "SETERV": {
                    _action = [
                        _x,
                        "Set Emergency RV",
                        "a3\ui_f\data\map\markers\military\end_CA.paa",
                        { [_this # 1] call FUNC(setERV) },
                        { true }
                    ] call ace_interact_menu_fnc_createAction;
                    _actions pushBack [_action, [], "_player"]
                };
                case "CLRVEG": {
                    _action = [
                        _x,
                        "Clear Vegetation",
                        "a3\modules_f\data\editterrainobject\textureunchecked_tree_ca.paa",
                        { [_this # 1] call FUNC(clearVegetation) },
                        { true }
                    ] call ace_interact_menu_fnc_createAction;
                    _actions pushBack [_action, [], "_player"]
                }
            }
        } forEach _unitAllowedActions;

        _actions
    }
] call ace_interact_menu_fnc_createAction] call ace_interact_menu_fnc_addActionToObject
