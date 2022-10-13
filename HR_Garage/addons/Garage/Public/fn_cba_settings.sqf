if (isClass (configfile >> "CBA_Extended_EventHandlers")) then {

    ["HR_Garage_dLock", "CHECKBOX", ["Lock on garage", "Lock vehicles when garaged"], [HR_Garage_Prefix,"Garage"], (HR_Garage_dLock isEqualTo {getPlayerUID player}), false, {
        HR_Garage_dLock = [{""}, { getPlayerUID player }] select _this;
    }] call CBA_fnc_addSetting;

    ["HR_Garage_Pylons_Enabled", "CHECKBOX", ["Allow pylon editing", "Allows player to configure pylons in the garage"], [HR_Garage_Prefix,"Garage"], true, true, {
        HR_Garage_Pylons_Enabled = _this;
    }] call CBA_fnc_addSetting;

    //Service disablers
    ["HR_Garage_ServiceDisabled_Rearm", "CHECKBOX", ["Disable garage rearm feature", "Prevent vehicles from being rearmed on ungarage"], [HR_Garage_Prefix,"Garage"], false, true, {
        HR_Garage_ServiceDisabled_Rearm = _this;
    }] call CBA_fnc_addSetting;
    ["HR_Garage_ServiceDisabled_Refuel", "CHECKBOX", ["Disable garage refuel feature", "Prevent vehicles from being refueled on ungarage"], [HR_Garage_Prefix,"Garage"], false, true, {
        HR_Garage_ServiceDisabled_Refuel = _this;
    }] call CBA_fnc_addSetting;
    ["HR_Garage_ServiceDisabled_Repair", "CHECKBOX", ["Disable garage repair feature", "Prevent vehicles from being repaired on ungarage"], [HR_Garage_Prefix,"Garage"], false, true, {
        HR_Garage_ServiceDisabled_Repair = _this;
    }] call CBA_fnc_addSetting;

    ["HR_Garage_PoolBase", "SLIDER", ["Capacity", "Garage capacity"], [HR_Garage_Prefix,"Garage"], [0, 150, HR_Garage_PoolBase, 0], true, {
        HR_Garage_PoolBase = round _this;
    }] call CBA_fnc_addSetting;

/*
    ["HR_Garage_PoolIncr", "SLIDER", ["Capacity increase", "Capacity increase per war level"], [HR_Garage_Prefix,"Garage"], [0, 10, HR_Garage_PoolIncr, 0], true, {
        HR_Garage_PoolIncr = round _this;
    }] call CBA_fnc_addSetting;
*/
    ["HR_Garage_renderPlacementRays", "CHECKBOX", ["Render placement rays", "Render the debug placement rays when placing vehicles"], [HR_Garage_Prefix,"Garage"], false, false, {
        HR_Garage_renderPlacementRays = _this;
    }] call CBA_fnc_addSetting;

};
