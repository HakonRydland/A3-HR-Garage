/*
    Author: [Håkon]
    [Description]
        Sets the fuel state of a vehicle

    Arguments:
        0. <Objet> Vehicle
        1. <Array> [
            <Int> Fuel
            <Int> Fuel cargo
            <Int> Ace Fuel cargo
        ] Fuel state

    Return Value: <nil>

    Scope: Any
    Environment: Any
    Public: Yes
    Dependencies:

    Example:

    License: APL-ND
*/
params [["_vehicle",objnull,[objNull]], "_fuelStats"];
if (isNull _vehicle) exitWith {};
if !(local _vehicle) exitWith {};
if (isnil "_fuelStats") exitWith {};
_fuelStats params [["_fuel",1, [0]], ["_fuelCargo",-1,[0]], ["_aceFuel",-2,[0]]];
_vehicle setFuel ([_fuel, 1] select (HR_Garage_ServiceBehaviour_Refuel isEqualTo 1 || HR_Garage_ServiceBehaviour_Refuel isEqualTo 0 && HR_Garage_hasFuelSource));
_vehicle setFuelCargo _fuelCargo;
if (_aceFuel > -2) then { // my nill indicator
    _vehicle setVariable ["ace_refuel_currentFuelCargo", _aceFuel, true];
};
