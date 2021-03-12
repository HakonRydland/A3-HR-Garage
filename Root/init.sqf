if (isServer) then {
    [] call HR_fnc_detector;
    [] call HR_fnc_logistics_initNodes;
    [] call HR_GRG_fnc_initServer;
};
