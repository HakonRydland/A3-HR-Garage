class Extended_Init_EventHandlers {
    class Car {
        class ADDON {
            init = "if (([_this#0] call HR_Garage_logistics_fnc_getCargoNodeType) isNotEqualTo -1) then {[_this#0, 'load'] call HR_Garage_Logistics_fnc_addAction};";
        };
    };

    class StaticWeapon {
        class ADDON {
            init = "if (([_this#0] call HR_Garage_Logistics_fnc_getCargoNodeType) isNotEqualTo -1) then {[_this#0, 'load'] call HR_Garage_Logistics_fnc_addAction};";
        };
    };
};
