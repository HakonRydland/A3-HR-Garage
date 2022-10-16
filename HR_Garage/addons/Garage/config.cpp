#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {QDOUBLES(ADDON,Module_addGarage), QDOUBLES(ADDON,Module_removeGarage), QDOUBLES(ADDON,Module_addVehicle)};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Modules_F", "cba_main", QDOUBLES(PREFIX,Logistics)};
        author = AUTHOR;
        authors[] = { AUTHORS };
        authorUrl = "";
        VERSION_CONFIG;
    };
};

#include "CfgFactionClasses.hpp"
#include "CfgFunctions.hpp"
#include "Dialogs.hpp"
#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
