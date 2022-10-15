class Extended_Init_EventHandlers {
	class allVehicles {
		class ADDON {
			init = "_this call HR_Garage_fnc_addVehicleAction;";
		};
	};
};
class Extended_PreInit_EventHandlers {
	GVAR(preInit) = call compile preprocessFileLineNumbers "\x\HR_Garage\addons\Garage\XEH_preInit.sqf";
	/*
    class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
	*/
};
