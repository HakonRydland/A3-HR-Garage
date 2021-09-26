class CfgFunctions {
	class ADDON
	{
		class Public
		{
			file = QPATHTOFOLDER(Public);
			class addLoadAction {};
			class getVehCapacity {};
			class initNodes { preInit = 1; };
		};
		class Private
		{
			file = QPATHTOFOLDER(Private);
			class addAction {};
			class addOrRemoveObjectMass {};
			class addWeaponAction {};
			class canLoad {};
			class generateHardPoints {};
			class getCargoConfig {};
			class getCargoNodeType {};
			class getCargoOffsetAndDir {};
			class getNodeConfig {};
			class getVehicleNodes {};
			class initMountedWeapon {};
			class load {};
			class refreshVehicleLoad {};
			class removeWeaponAction {};
			class toggleAceActions {};
			class toggleLock {};
			class tryLoad {};
			class unload {};
		};
	};
};
