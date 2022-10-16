//-- display --\\
#define HR_Garage_IDD_Garage 17001

///////////////
// PIXELGRID //
///////////////

#define pixelScale 0.5  // Was originally 0.5.
#define PixelGridScaler pixelGridNoUIScale
#define GRID_W (pixelW * PixelGridScaler * pixelScale)
#define GRID_H (pixelH * PixelGridScaler * pixelScale)

#define GRID_NOUISCALE_W (pixelW * pixelGridNoUIScale * pixelScale)
#define GRID_NOUISCALE_H (pixelH * pixelGridNoUIScale * pixelScale)

// Converts pixelGrid units to GUI coordinates
#define PX_W(n) n*GRID_W
#define PX_H(n) n*GRID_H

// Gets origin (top-left) in GUI coordinates of a centered box defined by pixelGrid units
#define CENTER_X(n) ((getResolution select 2) * 0.5 * pixelW) - (0.5 * (PX_W(n)))
#define CENTER_Y(n) ((getResolution select 3) * 0.5 * pixelH) - (0.5 * (PX_H(n)))

//-- Screen edge coordinates --\\
#define SCREEN_TOP safeZoneY
#define SCREEN_BOTTOM safeZoneH + safeZoneY
#define SCREEN_LEFT safeZoneX
#define SCREEN_RIGHT safeZoneW + safeZoneX

//-- Text sizes --\\
#define TEXT_SIZE_SMALL GRID_NOUISCALE_H * 2
#define TEXT_SIZE_MEDIUM GRID_NOUISCALE_H * 2.4
#define TEXT_SIZE_LARGE GRID_NOUISCALE_H * 3

//-- Category --\\
#define HR_Garage_IDC_CatCar 1700100
#define HR_Garage_IDC_CatArmored 1700101
#define HR_Garage_IDC_CatAir 1700102
#define HR_Garage_IDC_CatBoat 1700103
#define HR_Garage_IDC_CatStatic 1700104
#define HR_Garage_IDC_BttnCars 1700105
#define HR_Garage_IDC_BttnArmor 1700106
#define HR_Garage_IDC_BttnAir 1700107
#define HR_Garage_IDC_BttnBoats 1700108
#define HR_Garage_IDC_BttnStatics 1700109

//-- extra --\\
#define HR_Garage_IDC_BttnMounts 1700170
#define HR_Garage_IDC_BttnTexture 1700171
#define HR_Garage_IDC_BttnAnim 1700172
#define HR_Garage_IDC_BttnPylons 1700173
#define HR_Garage_IDC_ExtraMounts 1700150
#define HR_Garage_IDC_ExtraTexture 1700151
#define HR_Garage_IDC_ExtraAnim 1700152
#define HR_Garage_IDC_ExtraPylonsContainer 1700153 // Outer controlsgroup
#define HR_Garage_IDC_ExtraPylonsMirrorCheckbox 1700154
#define HR_Garage_IDC_ExtraPylonsMirrorLabel 1700155
#define HR_Garage_IDC_ExtraPylonsPresetsCombo 1700156
#define HR_Garage_IDC_ExtraPylons 1700157 // Controlsgroup containing all the actual pylons
#define HR_Garage_IDC_PylonsFirstIDC 1715300
#define checkboxTextures [tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")]

//-- General --\\
#define HR_Garage_IDC_Cancel 170011
#define HR_Garage_IDC_tLock 170012
#define HR_Garage_IDC_Confirm 170013
#define HR_Garage_IDC_InfoPanel 170014
#define HR_Garage_IDC_SourcePanelAmmo 1700141
#define HR_Garage_IDC_SourcePanelFuel 1700142
#define HR_Garage_IDC_SourcePanelRepair 1700143
#define HR_Garage_IDC_SourcePanelTopLine 1700144
#define HR_Garage_IDC_SourcePanelBottomLine 1700145
#define HR_Garage_IDC_CatText 170016
#define HR_Garage_IDC_ExtrasText 170017
#define HR_Garage_IDC_KeyBindHint 170018
#define HR_Garage_IDC_CapacityCount 170019

//-- ID's for ZM --\\
#define HR_Garage_ZM_IDD 171001
#define HR_Garage_ZM_IDC_cbAir 171002
#define HR_Garage_ZM_IDC_cbNaval 171003
#define HR_Garage_ZM_IDC_cbArmor 171004

//icons
#define CheckOutIcon "\a3\ui_f\data\Map\Diary\Icons\diaryLocateTask_ca.paa"
#define LockIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayMain\infoDLCs_ca.paa"
#define TexturesIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\textureSources_ca.paa"
#define AnimationsIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_debug_ca.paa"
#define PylonsIcon "\a3\ui_f\data\GUI\Cfg\Hints\warhead_types_ca.paa"

#define CarIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\car_ca.paa"
#define ArmoredIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\tank_ca.paa"
#define AirIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\helicopter_ca.paa"
#define BoatIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\naval_ca.paa"
#define StaticIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayGarage\static_ca.paa"

#define DriverIcon "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa"
#define GunnerIcon "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa"
#define CommanderIcon "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa"
#define CargoIcon "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa"

#define LineIcon "\a3\ui_f\data\IGUI\Cfg\HelicopterHUD\border_line_ca.paa"
#define CrateIcon "\a3\ui_f\data\Map\VehicleIcons\iconCrateWpns_ca.paa"
#define VehCargoIcon "\a3\ui_f\data\IGUI\Cfg\VehicleToggles\VehicleCargoIconOn2_ca.paa"
#define SpeedIcon "\a3\ui_f\data\GUI\Rsc\RscDisplayOptionsVideo\icon_performance.paa"
#define EngineIcon "\a3\ui_f\data\IGUI\Cfg\Actions\engine_on_ca.paa"
#define MassIcon "\a3\ui_f\data\GUI\Cfg\Cursors\raise_gs.paa"
#define RearmIcon "\a3\ui_f\data\IGUI\Cfg\Actions\reload_ca.paa"
#define RefuelIcon "\a3\ui_f\data\IGUI\Cfg\Actions\refuel_ca.paa"
#define RepairIcon "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa"

#define TutorialIcon "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\unknown_ca.paa"
#define cameraIcon "\a3\ui_f\data\GUI\Cfg\KeyframeAnimation\IconCamera_CA.paa"
#define moveIcon "\a3\ui_f\data\GUI\Cfg\Cursors\move_gs.paa"
#define zoomIcon "\a3\ui_f\data\IGUI\Cfg\Actions\autohover_ca.paa"

//Cfg macros
#define cfgPreview(className) getText(configfile >> "CfgVehicles" >> className >> "editorPreview")
#define cfgIcon(className) getText(configfile >> "CfgVehicles" >> className >> "picture")
#define cfgDispName(className) getText(configfile >> "CfgVehicles" >> className >> "displayName")
#define cfgVehClass(className) getText(configfile >> "CfgVehicles" >> className >> "vehicleClass")
#define cfgEditorCat(className) getText(configfile >> "CfgVehicles" >> className >> "editorSubCategory")
#define cfgMaxSpeed(className) getNumber(configfile >> "CfgVehicles" >> className >> "maxSpeed")
#define cfgEnginePower(className) getNumber(configfile >> "CfgVehicles" >> className >> "enginePower")
#define cfgAceCargo(className) getNumber(configfile >> "CfgVehicles" >> className >> "ace_cargo_space")
