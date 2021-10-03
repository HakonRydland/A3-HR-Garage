/*
    Author: [Håkon, DoomMetal]
    Description:
        Garage GUI

    License: APL-ND
*/
#include "CfgDefines.inc"
#include "defines.hpp"
class HR_Garage_VehicleSelect
{
    idd=HR_Garage_IDD_Garage;
    movingenable=false;
    onLoad = "[] spawn HR_Garage_fnc_onLoad;";
    onUnload = "[] spawn HR_Garage_fnc_onUnload;";
    class controls
    {
        // Title text left
        class HR_Garage_CatText: HR_Garage_RscStructuredText
        {
            idc = HR_Garage_IDC_CatText;
            x = SCREEN_LEFT;
            y = SCREEN_TOP;
            w = 39 * GRID_NOUISCALE_W;
            h = 4 * GRID_NOUISCALE_H;
            size = TEXT_SIZE_LARGE;
        };

        // Vehicle listboxes
        class HR_Garage_ListCars: HR_Garage_RscListbox
        {
            idc = HR_Garage_IDC_CatCar;
            x = SCREEN_LEFT;
            y = SCREEN_TOP + 4 * GRID_NOUISCALE_H;
            w = 39 * GRID_NOUISCALE_W;
            h = safeZoneH - (11 * GRID_NOUISCALE_H); // Screen height - title and buttons height
            size = TEXT_SIZE_MEDIUM;
            rowHeight = 3 * GRID_NOUISCALE_H;
            onMouseButtonClick = "_this call HR_Garage_fnc_selectionChange;";
        };
        class HR_Garage_ListArmored: HR_Garage_ListCars
        {
            idc = HR_Garage_IDC_CatArmored;
            onMouseButtonClick = "_this call HR_Garage_fnc_selectionChange;";
        };
        class HR_Garage_ListAir: HR_Garage_ListCars
        {
            idc = HR_Garage_IDC_CatAir;
            onMouseButtonClick = "_this call HR_Garage_fnc_selectionChange;";
        };
        class HR_Garage_ListBoat: HR_Garage_ListCars
        {
            idc = HR_Garage_IDC_CatBoat;
            onMouseButtonClick = "_this call HR_Garage_fnc_selectionChange;";
        };
        class HR_Garage_ListStatic: HR_Garage_ListCars
        {
            idc = HR_Garage_IDC_CatStatic;
            onMouseButtonClick = "_this call HR_Garage_fnc_selectionChange;";
        };

        // Bottom left buttons
        class HR_Garage_ButtonsControlsGroup: HR_Garage_RscControlsGroup
        {
            idc = -1;
            x = SCREEN_LEFT;
            y = SCREEN_BOTTOM - 7 * GRID_NOUISCALE_H;
            w = 39 * GRID_NOUISCALE_W;
            h = 7 * GRID_NOUISCALE_H;

            class controls
            {
                class HR_Garage_Cancel: HR_Garage_RscButton
                {
                    idc = HR_Garage_IDC_Cancel;
                    text = $STR_HR_Garage_Generic_Cancel;
                    x = 0;
                    y = 0;
                    w = 13 * GRID_NOUISCALE_W;
                    h = 7 * GRID_NOUISCALE_H;
                    action = "closeDialog 0;";
                    sizeEx = TEXT_SIZE_LARGE;
                };
                class HR_Garage_toggleLock: HR_Garage_RscButton
                {
                    idc = HR_Garage_IDC_tLock;
                    text = $STR_HR_Garage_Generic_Lock;
                    x = 13 * GRID_NOUISCALE_W;
                    y = 0;
                    w = 13 * GRID_NOUISCALE_W;
                    h = 7 * GRID_NOUISCALE_H;
                    action = "[HR_Garage_PlayerUID, player, HR_Garage_SelectedVehicles] remoteExecCall ['HR_Garage_fnc_toggleLock',2];";
                    sizeEx = TEXT_SIZE_LARGE;
                };
                class HR_Garage_Confirm: HR_Garage_RscButton
                {
                    idc = HR_Garage_IDC_Confirm;
                    text = $STR_HR_Garage_Generic_Confirm;
                    x = 26 * GRID_NOUISCALE_W;
                    y = 0;
                    w = 13 * GRID_NOUISCALE_W;
                    h = 7 * GRID_NOUISCALE_H;
                    action = "[] call HR_Garage_fnc_confirm;";
                    sizeEx = TEXT_SIZE_LARGE;
                };
            };
        };

        // Vehicle HR_Garage_categories buttons
        class HR_Garage_BttnCars: HR_Garage_RscActivePictureKeepAspect
        {
            idc = HR_Garage_IDC_BttnCars;
            x = SCREEN_LEFT + 39 * GRID_NOUISCALE_W;
            y = SCREEN_TOP;
            w = 10 * GRID_NOUISCALE_W;
            h = 4 * GRID_NOUISCALE_H;
            text = CarIcon;
            tooltip = $STR_HR_Garage_Generic_Cars;
            action = "[0] call HR_Garage_fnc_switchCategory;";
        };
        class HR_Garage_BttnArmor: HR_Garage_BttnCars
        {
            idc = HR_Garage_IDC_BttnArmor;
            y = SCREEN_TOP + 4 * GRID_NOUISCALE_H;
            text = ArmoredIcon;
            tooltip = $STR_HR_Garage_Generic_Armored;
            action = "[1] call HR_Garage_fnc_switchCategory;";
        };
        class HR_Garage_BttnAir: HR_Garage_BttnCars
        {
            idc = HR_Garage_IDC_BttnAir;
            y = SCREEN_TOP + 8 * GRID_NOUISCALE_H;
            text = AirIcon;
            tooltip = $STR_HR_Garage_Generic_Air;
            action = "[2] call HR_Garage_fnc_switchCategory;";
        };
        class HR_Garage_BttnBoats: HR_Garage_BttnCars
        {
            idc = HR_Garage_IDC_BttnBoats;
            y = SCREEN_TOP + 12 * GRID_NOUISCALE_H;
            text = BoatIcon;
            tooltip = $STR_HR_Garage_Generic_Boat;
            action = "[3] call HR_Garage_fnc_switchCategory;";
        };
        class HR_Garage_BttnStatics: HR_Garage_BttnCars
        {
            idc = HR_Garage_IDC_BttnStatics;
            y = SCREEN_TOP + 16 * GRID_NOUISCALE_H;
            text = StaticIcon;
            tooltip = $STR_HR_Garage_Generic_Static;
            action = "[4] call HR_Garage_fnc_switchCategory;";
        };

        //vehicle extras buttons
        class HR_Garage_BttnMounts: HR_Garage_RscActivePictureKeepAspect
        {
            idc = HR_Garage_IDC_BttnMounts;
            x = SCREEN_RIGHT - 49 * GRID_NOUISCALE_W;
            y = SCREEN_TOP;
            w = 10 * GRID_NOUISCALE_W;
            h = 4 * GRID_NOUISCALE_H;
            text = StaticIcon;
            tooltip = $STR_HR_Garage_Generic_Mounts;
            action = "[0] call HR_Garage_fnc_switchExtrasMenu;";
        };
        class HR_Garage_BttnTexture: HR_Garage_BttnMounts
        {
            idc = HR_Garage_IDC_BttnTexture;
            y = SCREEN_TOP + 4 * GRID_NOUISCALE_H;
            text = TexturesIcon;
            tooltip = $STR_HR_Garage_Generic_Texture;
            action = "[1] call HR_Garage_fnc_switchExtrasMenu;";
        };
        class HR_Garage_BttnAnim: HR_Garage_BttnMounts
        {
            idc = HR_Garage_IDC_BttnAnim;
            y = SCREEN_TOP + 8 * GRID_NOUISCALE_H;
            text = AnimationsIcon;
            tooltip = $STR_HR_Garage_Generic_Anim;
            action = "[2] call HR_Garage_fnc_switchExtrasMenu;";
        };
        class HR_Garage_BttnPylons: HR_Garage_BttnMounts
        {
            idc = HR_Garage_IDC_BttnPylons;
            y = SCREEN_TOP + 12 * GRID_NOUISCALE_H;
            text = PylonsIcon;
            tooltip = $STR_HR_Garage_Generic_Pylons;
            action = "[3] call HR_Garage_fnc_switchExtrasMenu;";
        };


        // Vehicle Extras | Right side panel

        // Title text
        class HR_Garage_ExtrasText: HR_Garage_RscStructuredText
        {
            idc = HR_Garage_IDC_ExtrasText;
            x = SCREEN_RIGHT - 39 * GRID_NOUISCALE_W;
            y = SCREEN_TOP;
            w = 39 * GRID_NOUISCALE_W;
            h = 4 * GRID_NOUISCALE_H;
            size = TEXT_SIZE_LARGE;
        };

        // Vehicle extras lists/controlsgroup
        class HR_Garage_ExtraMount: HR_Garage_RscListbox
        {
            idc = HR_Garage_IDC_ExtraMounts;
            x = SCREEN_RIGHT - 39 * GRID_NOUISCALE_W;
            y = SCREEN_TOP + 4 * GRID_NOUISCALE_H;
            w = 39 * GRID_NOUISCALE_W;
            h = safeZoneH - (56 * GRID_NOUISCALE_H); // Screen height - title and buttons height
            size = TEXT_SIZE_MEDIUM;
            rowHeight = 3 * GRID_NOUISCALE_H;
            onMouseButtonClick = "_this call HR_Garage_fnc_requestMount;";
        };

        class HR_Garage_ExtraTexture: HR_Garage_ExtraMount
        {
            idc = HR_Garage_IDC_ExtraTexture;
            onMouseButtonClick = "_this call HR_Garage_fnc_switchTexture;";
        };

        class HR_Garage_ExtraAnim: HR_Garage_ExtraMount
        {
            idc = HR_Garage_IDC_ExtraAnim;
            onMouseButtonClick = "_this call HR_Garage_fnc_toggleAnim;";
        };

        class HR_Garage_ExtraPylonsContainer: HR_Garage_RscControlsGroup
        {
            idc = HR_Garage_IDC_ExtraPylonsContainer;
            x = SCREEN_RIGHT - 39 * GRID_NOUISCALE_W;
            y = SCREEN_TOP + 4 * GRID_NOUISCALE_H;
            w = 39 * GRID_NOUISCALE_W;
            h = safeZoneH - (56 * GRID_NOUISCALE_H); // Screen height - title and buttons height

            class controls
            {
                class HR_Garage_ExtraPylonsBg: HR_Garage_RscBox
                {
                    idc = -1;
                    x = 0;
                    y = 0;
                    w = 39 * GRID_NOUISCALE_W;
                    h = safeZoneH - (56 * GRID_NOUISCALE_H);
                };

                class HR_Garage_MirrorCheckbox: HR_Garage_RscCheckBox
                {
                    idc = HR_Garage_IDC_ExtraPylonsMirrorCheckbox;
                    x = 1 * GRID_NOUISCALE_W;
                    y = 0;
                    w = 3 * GRID_NOUISCALE_W;
                    h = 3 * GRID_NOUISCALE_H;
                };

                class HR_Garage_MirrorLabel: HR_Garage_RscText
                {
                    idc = HR_Garage_IDC_ExtraPylonsMirrorLabel;
                    x = 4 * GRID_NOUISCALE_W;
                    y = 0;
                    w = 8 * GRID_NOUISCALE_W;
                    h = 3 * GRID_NOUISCALE_H;
                    colorBackground[] = {0,0,0,0};
                };

                class HR_Garage_PresetsCombo: HR_Garage_RscCombo
                {
                    idc = HR_Garage_IDC_ExtraPylonsPresetsCombo;
                    x = 13 * GRID_NOUISCALE_W;
                    y = 0;
                    w = 25 * GRID_NOUISCALE_W;
                    h = 3 * GRID_NOUISCALE_H;
                    colorBackground[] = {0,0,0,1};
                };

                class HR_Garage_ExtraPylons: HR_Garage_RscControlsGroup
                {
                    idc = HR_Garage_IDC_ExtraPylons;
                    x = 0;
                    y = 4 * GRID_NOUISCALE_H;
                    w = 38 * GRID_NOUISCALE_W;
                    h = safeZoneH - (65 * GRID_NOUISCALE_H); // Screen height - title and buttons height 51
                };
            };
        };

        class HR_Garage_SourcePanel: HR_Garage_RscControlsGroup
        {
            x = SCREEN_RIGHT - 39 * GRID_NOUISCALE_W;
            y = SCREEN_BOTTOM - 52 * GRID_NOUISCALE_H;
            w = 39 * GRID_NOUISCALE_W;
            h = 7 * GRID_NOUISCALE_H;
            size = TEXT_SIZE_MEDIUM;
            class controls
            {
                class HR_Garage_sourceInfo: HR_Garage_RscStructuredText
                {
                    x = 0 * GRID_NOUISCALE_W;
                    y = 0 * GRID_NOUISCALE_H;
                    w = 39 * GRID_NOUISCALE_W;
                    h = 3 * GRID_NOUISCALE_H;
                    size = TEXT_SIZE_MEDIUM;
                    Text = $STR_HR_Garage_SourcePanel_Header;
                };
                class HR_Garage_sourceAmmo: HR_Garage_RscStructuredText
                {
                    idc = HR_Garage_IDC_SourcePanelAmmo;
                    x = 0 * GRID_NOUISCALE_W;
                    y = 3 * GRID_NOUISCALE_H;
                    w = 13 * GRID_NOUISCALE_W;
                    h = 4 * GRID_NOUISCALE_H;
                    size = TEXT_SIZE_MEDIUM;
                };
                class HR_Garage_sourceFuel: HR_Garage_RscStructuredText
                {
                    idc = HR_Garage_IDC_SourcePanelFuel;
                    x = 13 * GRID_NOUISCALE_W;
                    y = 3 * GRID_NOUISCALE_H;
                    w = 13 * GRID_NOUISCALE_W;
                    h = 4 * GRID_NOUISCALE_H;
                    size = TEXT_SIZE_MEDIUM;
                };
                class HR_Garage_sourceRepair: HR_Garage_RscStructuredText
                {
                    idc = HR_Garage_IDC_SourcePanelRepair;
                    x = 26 * GRID_NOUISCALE_W;
                    y = 3 * GRID_NOUISCALE_H;
                    w = 13 * GRID_NOUISCALE_W;
                    h = 4 * GRID_NOUISCALE_H;
                    size = TEXT_SIZE_MEDIUM;
                };
                class HR_Garage_sourceTopLine: HR_Garage_RscStructuredText
                {
                    idc = HR_Garage_IDC_SourcePanelTopLine;
                    x = 1 * GRID_NOUISCALE_W;
                    y = 0 * GRID_NOUISCALE_H;
                    w = 37 * GRID_NOUISCALE_W;
                    h = 0.1 * GRID_NOUISCALE_H;
                    size = TEXT_SIZE_MEDIUM;
                    colorBackground[] = {1,1,1,1};
                };
                class HR_Garage_sourceBottomLine: HR_Garage_RscStructuredText
                {
                    idc = HR_Garage_IDC_SourcePanelBottomLine;
                    x = 1 * GRID_NOUISCALE_W;
                    y = 6.9 * GRID_NOUISCALE_H;
                    w = 37 * GRID_NOUISCALE_W;
                    h = 0.1 * GRID_NOUISCALE_H;
                    size = TEXT_SIZE_MEDIUM;
                    colorBackground[] = {1,1,1,1};
                };
            };
        };

        // Info Panel
        class HR_Garage_InfoPanel: HR_Garage_RscStructuredText
        {
            idc = HR_Garage_IDC_InfoPanel;
            x = SCREEN_RIGHT - 39 * GRID_NOUISCALE_W;
            y = SCREEN_BOTTOM - 45 * GRID_NOUISCALE_H;
            w = 39 * GRID_NOUISCALE_W;
            h = 45 * GRID_NOUISCALE_H;
            size = TEXT_SIZE_MEDIUM;
        };

        // Camera controls hint
        class HR_Garage_KeyBindHint: HR_Garage_RscStructuredText
        {
            idc = HR_Garage_IDC_KeyBindHint;
            x = SCREEN_LEFT + 39 * GRID_NOUISCALE_W;
            y = SCREEN_BOTTOM - 7 * GRID_NOUISCALE_H;
            w = 36 * GRID_NOUISCALE_W;
            h = 7 * GRID_NOUISCALE_H;
            size = TEXT_SIZE_SMALL;
        };
    };
};
