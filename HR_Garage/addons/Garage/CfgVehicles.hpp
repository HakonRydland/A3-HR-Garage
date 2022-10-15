class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Combo;
            class Edit;
            class Checkbox;
            class ModuleDescription;
        };
        class ModuleDescription;
    };
    class DOUBLES(ADDON,ModuleBase): Module_F {
        scopeCurator = 2; // 2 is visible in zeus interface
        author = AUTHOR;
        vehicleClass = "Modules";
        category = QUOTE(ADDON);
        isGlobal = 0;
        functionPriority = 1;
        curatorCanAttach = 1;
        class Units;
    };

    class DOUBLES(ADDON,Module_addGarage): DOUBLES(ADDON,ModuleBase) {
        scope = 2; //2 = visible in eden editor
        displayName = $STR_HR_Garage_Modules_addAccess;
        description = "Example description 1";
        function = "HR_Garage_fnc_initModule_addGarage";
        //curatorInfoType = "RscDisplayAttributeModuleNuke"; //displayed when placed by zeus
        //ToDo: create a simple UI for settings when adding a garage access point with zeus
        //      alternativly add another zues only module to configure the garage

        class Attributes: AttributesBase {
            class accessAir: Checkbox {
                displayName = "Allow access to air";
                property = QGVAR(accessAir);
                description = "Enable access to air vehicles from this garage access point";
                typeName = "BOOL";
                defaultValue = 1;
            };
            class accessNaval: Checkbox {
                displayName = "Allow access to naval";
                property = QGVAR(accessNaval);
                description = "Enable access to naval vehicles from this garage access point";
                typeName = "BOOL";
                defaultValue = 1;
            };
            class accessArmor: Checkbox {
                displayName = "Allow access to armored";
                property = QGVAR(accessArmor);
                description = "Enable access to armored vehicles from this garage access point";
                typeName = "BOOL";
                defaultValue = 1;
            };
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = "Synch to objects to make them into garage access points.";
        };
    };

    class DOUBLES(ADDON,Module_removeGarage): DOUBLES(ADDON,ModuleBase) {
        displayName = $STR_HR_Garage_Modules_removeAccess;
        function = "HR_Garage_fnc_initModule_removeGarage";

        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = "Synch to objects remove them as a garage access point.";
        };
    };

    class DOUBLES(ADDON,Module_addVehicle): DOUBLES(ADDON,ModuleBase) {
        scope = 2;
        displayName = $STR_HR_Garage_Modules_addVehicle;
        function = "HR_Garage_fnc_initModule_addVehicle";
        class Attributes: AttributesBase {
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = "Synch to vehicles to add them to the garage on mission start.";
        };
    };

};
