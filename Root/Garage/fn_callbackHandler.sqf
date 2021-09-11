/*
    Author: [Håkon]
    Description:
        Meant to handle outside use of placement code, will trigger callbacks for event _callback passed, for the internal actions of the placement code.

        Important, always default to false.

        Actions:            | Return    | Description
        invalidPlacement    | Bool      | If can place, return false for can place
        Placed              | Nil       | Vehicle placed, gives you chance to do custom stuff


    Arguments:
    0. <Object> Vehicle
    1. <Array> Callback owner, and the callback arguments
    2. <String> Callback action

    Return Value:
    <Bool/Nil> Callback succesfull

    Scope: Any
    Environment: Any
    Public: No
    Dependencies:

    Example:

    License: MIT
*/
params [["_vehicle", objNull, [objNull]], ["_callback",[], [[]]], ["_action", ""]];
_callback params [["_callBackName", "", [""]], ["_arguments", []] ];

switch _callBackName do {
    default {false};
};
