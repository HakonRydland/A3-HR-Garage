/*
    Author: [Håkon]
    [Description]
        Finds the node type(size) from HR_logistics_attachmentOffset

    Arguments:
    0. <Object> Object that is loadable (Cargo)

    Return Value:
    <Int> Cargo node size/type

    Scope: Any
    Environment: unscheduled
    Public: [Yes]
    Dependencies: HR_logistics_attachmentOffset

    Example: private _objNodeType = [_object] call HR_fnc_logistics_getCargoNodeType;
*/
params [["_object", objNull, [objNull, ""]]];
private _type = if (_object isEqualType objNull) then { typeOf _object } else { _object };
private _size = -1;
if (_type isEqualTo "") exitWith {_size};

private _model = getText (configFile >> "CfgVehicles" >> _type >> "model");
{
    if ((_x#0) isEqualTo _model) exitWith {_size = _x#3};
}forEach HR_logistics_attachmentOffset;

_size;
