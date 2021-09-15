/*
    Author: [Håkon]
    [Description]
        intermidiary between dialog EH and confim placement
        gathers and formats data used in vehicle placement

    Arguments: <nil>

    Return Value: <nil>

    Scope: Clients
    Environment: Any
    Public: No
    Dependencies:

    Example: [] call HR_Garage_fnc_confirm;

    License: APL-ND
*/
HR_Garage_SelectedVehicles params ["_catIndex", "_vehUID", "_class"];
if (_vehUID isEqualTo -1) exitWith {["STR_HR_Garage_Feedback_confirm_NullSelection"] call HR_Garage_fnc_Hint};

//get mounts state
HR_Garage_Mounts apply {
    private _static = (HR_Garage_Vehicles#4) get (_x#1);
    _x pushBack (_static#4);
    _x
};

[
    _class
    , nil //not used internaly
    , nil //not used internaly
    , HR_Garage_Mounts
    , if (
            HR_Garage_Pylons_Enabled //Pylon editing enabled
            && { HR_Garage_hasAmmoSource } //or ammo source registered
    ) then {HR_Garage_Pylons} else {nil}
    , HR_Garage_previewVehState
    , true
] call HR_Garage_fnc_confirmPlacement;
closeDialog 2;
