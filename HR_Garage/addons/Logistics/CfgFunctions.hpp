class CfgFunctions {
	class HR
	{
		class LogisticsPublic
		{
			file = QPATHTOFOLDER(Public);
			class logistics_addLoadAction {};
			class logistics_getVehCapacity {};
			class logistics_initNodes { preInit = 1; };
		};
		class LogisticsPrivate
		{
			file = QPATHTOFOLDER(Private);
			class logistics_addAction {};
			class logistics_addOrRemoveObjectMass {};
			class logistics_addWeaponAction {};
			class logistics_canLoad {};
			class logistics_generateHardPoints {};
			class logistics_getCargoNodeType {};
			class logistics_getCargoOffsetAndDir {};
			class logistics_getVehicleNodes {};
			class logistics_initMountedWeapon {};
			class logistics_load {};
			class logistics_refreshVehicleLoad {};
			class logistics_removeWeaponAction {};
			class logistics_toggleAceActions {};
			class logistics_toggleLock {};
			class logistics_tryLoad {};
			class logistics_unload {};
		};
	};
};
