/*
    Author: [Håkon]
    [Description]
        Update veh pool on all clients in garage

    Arguments:
    0. <String> Lock UID, (nil if to not change)
    1. <String> Checkout UID
    2. <Int>    Categroy index
    3. <Int>    Vehicle UID
    4. <Object> Player whom made the request
    5. <Bool>   Switch selected vehicle to this for player

    Return Value:
    <Bool> succeded

    Scope: Server
    Environment: Any
    Public: [No]
    Dependencies:

    Example: [nil, _UID, _catIndex, _vehUID, _player, true] call HR_Garage_fnc_broadcast;

    License: APL-ND
*/
if !(isServer) exitWith {false};
HR_Garage_Event = _this;
{
    _x publicVariableClient "HR_Garage_Event";
} forEach HR_Garage_Users;
true
