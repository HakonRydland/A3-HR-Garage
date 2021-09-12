/*
    Author: [Håkon]
    [Description]
        removes garage access from a object

    Arguments:
    0. <Object> Object to remove access the garage from

    Return Value:
    <Bool> success

    Scope: Clients
    Environment: Any
    Public: [Yes]
    Dependencies:

    Example: [_object] call HR_GRG_fnc_initGarage;

    License: APL-ND
*/
params [ ["_object", objNull, [objNull]] ];
if (isNull _object) exitWith {false};
if (!isMultiplayer) exitWith {false};

private _oldID = _object getVariable ["HR_GRG_GarageID", -1];
_object removeAction _oldID;
_object setVariable ["HR_GRG_GarageID", nil];

//add it to the registra of access points
if (isNil "HR_GRG_accessPoints") exitWith {true};
HR_GRG_accessPoints deleteAt (HR_GRG_accessPoints find _object);
HR_GRG_accessPoints = HR_GRG_accessPoints select {!isNull _x};

true;
