#include "..\defines.inc"
disableSerialization;

if (isNull HR_Garage_ZM_AP) exitWith {false};

private _cbAir = (findDisplay HR_Garage_ZM_IDD) displayCtrl HR_Garage_ZM_IDC_cbAir;
private _cbNaval = (findDisplay HR_Garage_ZM_IDD) displayCtrl HR_Garage_ZM_IDC_cbNaval;
private _cbArmor = (findDisplay HR_Garage_ZM_IDD) displayCtrl HR_Garage_ZM_IDC_cbArmor;

[
    HR_Garage_ZM_AP
    , cbChecked _cbAir
    , cbChecked _cbNaval
    , cbChecked _cbArmor
] call HR_Garage_fnc_toggleGarageAccess;

HR_Garage_ZM_AP = objNull;
closeDialog 1;
true;
