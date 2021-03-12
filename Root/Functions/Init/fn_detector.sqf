/*
Author: Meerkat
  This file handles the detection of mods.
  Best practice is to detect the presence of a CfgPatches entry, but there are alternatives.
  To add a new mod, give it a hadMod variable with the rest, then add an if (isClass) entry like the FFAA one. (You could even copy/paste the FFAA one and replace its calls with the ones you need.)

Scope: All
Environment: Any (Scheduled Inherited from fn_initVarCommon.sqf)
Public: No
*/

//Var initialisation
private _filename = "detector.sqf";
HR_hasRHS = false;
HR_hasFFAA = false;
HR_has3CB = false;

//RHS Detection
if (
    isClass (configFile >> "CfgFactionClasses" >> "rhs_faction_vdv")
    && isClass (configFile >> "CfgFactionClasses" >> "rhs_faction_usarmy")
    && isClass (configFile >> "CfgFactionClasses" >> "rhsgref_faction_tla")
) then { HR_hasRHS = true };

//3CB BAF + Factions Detection
if (HR_hasRHS && (
    isClass (configfile >> "CfgPatches" >> "UK3CB_BAF_Weapons") &&
    isClass (configfile >> "CfgPatches" >> "UK3CB_BAF_Vehicles") &&
    isClass (configfile >> "CfgPatches" >> "UK3CB_BAF_Units_Common") &&
    isClass (configfile >> "CfgPatches" >> "UK3CB_BAF_Equipment") &&
    isClass (configFile >> "CfgPatches" >> "UK3CB_Factions_Vehicles_SUV")
) ) then { HR_has3CB = true };

//FFAA Detection
if (isClass (configfile >> "CfgPatches" >> "ffaa_armas")) then { HR_hasFFAA = true };
