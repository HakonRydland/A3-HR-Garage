class CfgVehicles {
    class Logic;
    class Module_F: Logic {};
    class DOUBLES(ADDON,ModuleBase): Module_F {
        scopeCurator = 2;
        vehicleClass = "Modules";
        category = QUOTE(ADDON);
        isGlobal = 1;
        curatorCanAttach = 1;
        class Units;
        class AttributesBase;
    };

    class DOUBLES(ADDON,Module_addGarage): DOUBLES(ADDON,ModuleBase) {
        scope = 2;
        displayName = "Add garage access";
        function = "HR_GRG_fnc_initModule_addGarage";

        class Attributes: AttributesBase {
            class Units: Units {
                property = QDOUBLES(ADDON,Module_addGarage);
            };
        };
    };

    class DOUBLES(ADDON,Module_removeGarage): DOUBLES(ADDON,ModuleBase) {
        scope = 1;
        displayName = "Remove garage access";
        function = "HR_GRG_fnc_initModule_removeGarage";

        class Attributes: AttributesBase {
            class Units: Units {
                property = QDOUBLES(ADDON,Module_removeGarage);
            };
        };
    };

    class DOUBLES(ADDON,Module_addVehicle): DOUBLES(ADDON,ModuleBase) {
        scope = 2;
        displayName = "Add vehicle to garage";
        function = "HR_GRG_fnc_initModule_addVehicle";

        class Attributes: AttributesBase {
            class Units: Units {
                property = QDOUBLES(ADDON,Module_addVehicle);
            };
        };
    };
};
