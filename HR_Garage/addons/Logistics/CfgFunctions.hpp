class CfgFunctions {
    class ADDON
    {

#if __A3_DEBUG__

    #undef RECOMPILE
    #define RECOMPILE recompile = 1

        class Dev
        {
            file = QPATHTOFOLDER(Dev);
            DFUNC(convertCargoToNew)
            DFUNC(convertNodesToNew)
            DFUNC(generateCargoOffset)
            DFUNC(generateHardPoints)
        };

#endif

        class Public
        {
            file = QPATHTOFOLDER(Public);
            DFUNC(addLoadAction)
            DFUNC(getVehCapacity)
        };
        class Private
        {
            file = QPATHTOFOLDER(Private);
            DFUNC(addAction)
            DFUNC(addOrRemoveObjectMass)
            DFUNC(addWeaponAction)
            DFUNC(canLoad)
            DFUNC(getCargoConfig)
            DFUNC(getCargoNodeType)
            DFUNC(getCargoOffsetAndDir)
            DFUNC(getNodeConfig)
            DFUNC(getVehicleNodes)
            DFUNC(initMountedWeapon)
            DFUNC(load)
            DFUNC(refreshVehicleLoad)
            DFUNC(removeWeaponAction)
            DFUNC(toggleAceActions)
            DFUNC(toggleLock)
            DFUNC(tryLoad)
            DFUNC(unload)
        };
    };
};
