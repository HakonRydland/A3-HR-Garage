/*
Author: Håkon
Description:
    Declairs if variouse mods are loaded in global variables for other systems and functions to use

Arguments: Nil

Return Value: Nil

Scope: Any
Environment: Any
Public: Yes
Dependencies:

Example:

License: MIT License
*/

HR_hasAce = !isNil "ace_common_fnc_isModLoaded";

//RHS Detection
HR_hasRHS = isClass (configFile >> "CfgFactionClasses" >> "rhs_faction_vdv")
    && isClass (configFile >> "CfgFactionClasses" >> "rhs_faction_usarmy")
    && isClass (configFile >> "CfgFactionClasses" >> "rhsgref_faction_tla");

//3CB BAF + Factions Detection
HR_has3CB = HR_hasRHS
    && isClass (configfile >> "CfgPatches" >> "UK3CB_BAF_Weapons")
    && isClass (configfile >> "CfgPatches" >> "UK3CB_BAF_Vehicles")
    && isClass (configfile >> "CfgPatches" >> "UK3CB_BAF_Units_Common")
    && isClass (configfile >> "CfgPatches" >> "UK3CB_BAF_Equipment")
    && isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_Vehicles_SUV");

//FFAA Detection
HR_hasFFAA = isClass (configfile >> "CfgPatches" >> "ffaa_armas");
