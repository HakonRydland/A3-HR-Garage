/*
Author: Håkon
Description:
    Checks if a unit can fight

Arguments:
0. <Object> Unit

Return Value:
<Bool> Unit can fight

Scope: Any
Environment: Any
Public: Yes
Dependencies:

Example:

License: MIT License
*/
params [["_unit", objNull, [objNull]]];
alive _unit && !captive _unit;
