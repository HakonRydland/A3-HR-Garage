class HR
{
    class Init
    {
        class detector {};
    };
    class Logistics
    {
        class logistics_addLoadAction {};
        class logistics_getVehCapacity {};
        class logistics_initNodes {};
    };
    class LogisticsFunctions
    {
        file = "functions\Logistics\functions";
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
    class Utility
    {
        class canFight {};
        class classNameToModel {};
        class ValidateObjects {};
    };
};
