#include "..\script_component.hpp"

["HR_Garage_dLock", "CHECKBOX", ["Lock on garage", "Lock vehicles when garaged"], [ COMPONENT_NAME ,"Garage"], false, false, {
    HR_Garage_dLock = [{""}, { getPlayerUID player }] select _this;
}] call CBA_fnc_addSetting;

["HR_Garage_LogLevel", "LIST", ["Log level", "How much detail should be logged"], [ COMPONENT_NAME ,"Garage"], [[1,2,3,4],["Error", "Info", "Debug", "Verbose"],2], false, {
    HR_Garage_LogLevel = _this;
}] call CBA_fnc_addSetting;

["HR_Garage_Pylons_Enabled", "CHECKBOX", ["Allow pylon editing", "Allows player to configure pylons in the garage"], [ COMPONENT_NAME ,"Garage"], true, true, {
    HR_Garage_Pylons_Enabled = _this;
}] call CBA_fnc_addSetting;

//Service disablers
["HR_Garage_ServiceBehaviour_Rearm", "LIST", ["Rearm behavior", "Should the garage rearm vehicles on ungarage"], [ COMPONENT_NAME ,"Garage"], [[0,1,2],["Require source", "Allways", "Never"],0], true, {
    HR_Garage_ServiceBehaviour_Rearm = _this;
}] call CBA_fnc_addSetting;
["HR_Garage_ServiceBehaviour_Refuel", "LIST", ["Refuel behaviour", "Should the garage refuel vehicles on ungarage"], [ COMPONENT_NAME ,"Garage"], [[0,1,2],["Require source", "Allways", "Never"],0], true, {
    HR_Garage_ServiceBehaviour_Refuel = _this;
}] call CBA_fnc_addSetting;
["HR_Garage_ServiceBehaviour_Repair", "LIST", ["Repair behaviour", "Should the garage repair vehicles on ungarage"], [ COMPONENT_NAME ,"Garage"], [[0,1,2],["Require source", "Allways", "Never"],0], true, {
    HR_Garage_ServiceBehaviour_Repair = _this;
}] call CBA_fnc_addSetting;

["HR_Garage_PoolBase", "SLIDER", ["Base Capacity", "Garage base capacity"], [ COMPONENT_NAME ,"Garage"], [0, 50, HR_Garage_PoolBase, 50], true, {
    HR_Garage_PoolBase = round _this;
}] call CBA_fnc_addSetting;

["HR_Garage_PoolIncr", "SLIDER", ["Capacity increase", "Capacity scaling"], [ COMPONENT_NAME ,"Garage"], [0, 10, HR_Garage_PoolIncr, 10], true, {
    HR_Garage_PoolIncr = round _this;
}] call CBA_fnc_addSetting;
