/*
    Author: [Håkon]
    [Description]
        Generates a vehicle UID for the garage, up to 10 mil before looping back to 0.
        returns copy so nothing else modifies the UID count

    Arguments:
    0. <nil>

    Return Value:
    <Int> vehicle UID

    Scope: Server
    Environment: unscheduled
    Public: [No]
    Dependencies: HR_GRG_UID

    Example: [] call HR_GRG_fnc_genVehUID;

    License: MIT License
*/
HR_GRG_UID = HR_GRG_UID + 1 % 10000000;
+HR_GRG_UID
