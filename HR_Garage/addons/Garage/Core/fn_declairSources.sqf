/*
    Author: [Håkon]
    Description:
        Broadcast source availability in garage to all clients

    Arguments:
    0. <Index> Source type to check and broadcast

    Return Value:
    <nil>

    Scope: Server
    Environment: Any
    Public: No
    Dependencies: HR_Garage_Sources

    Example: [0] call HR_Garage_fnc_declairSources;

    License: APL-ND
*/
#include "defines.inc"
FIX_LINE_NUMBERS()
params ["_source"];
if (!isServer) exitWith {};

#define AmmoSource 0
#define FuelSource 1
#define RepairSource 2

switch _source do {
    case AmmoSource: { HR_Garage_hasAmmoSource = !((HR_Garage_Sources#0) isEqualTo []); publicVariable "HR_Garage_hasAmmoSource" };
    case FuelSource: { HR_Garage_hasFuelSource = !((HR_Garage_Sources#1) isEqualTo []); publicVariable "HR_Garage_hasFuelSource" };
    case RepairSource: { HR_Garage_hasRepairSource = !((HR_Garage_Sources#2) isEqualTo []); publicVariable "HR_Garage_hasRepairSource" };
    default { Info_1("Invalid source type: %1", _source) };
};
