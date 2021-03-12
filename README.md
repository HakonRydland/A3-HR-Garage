# A3-HR-Garage

Install:
copy contents of the folder Root into your mission root. if you already have some of these files, merge them together. that easy.

How to use:
----------------------------------------------------------
- To create an ``Garage access point`` you need to use the function ``[_obj] remoteExec ["HR_GRG_fnc_initGarage",0,true]`` replacing ``_obj`` with your garage access point object.
Example:
```
   [cursorObject] remoteExecCall ["HR_GRG_fnc_initGarage",0,true] // will make the cursorObject into an garage access point
```
```
[this] call HR_GRG_fnc_initGarage; //in the init line of an object will make it a garage access point
```
----------------------------------------------------------
- To Add a vehicle to the garage, you can do one of two things:
  1)  to add vehicles by `className` use 
```
[_classes, _lockUID] RemoteExecCall ["HR_GRG_fnc_addVehiclesByClass",2]
```
replacing ``_classes`` with an array of vehicle classnames

  2)  to add an vehicle by `Object` use 
```
[_obj, clientOwner, call HR_GRG_dLock, player] remoteExecCall ["HR_GRG_fnc_addVehicle",2];
```
replacing ``_obj`` with the object in questin, note certain restrictions are in place for object garaging.

----------------------------------------------------------
- To get the save data for the garage do 
```
private _saveData = [] call HR_GRG_fnc_getSaveData;
``` 
you can the store this somewhere like in profilenameSpace...
Note this is a ``server only`` function

----------------------------------------------------------
- To restore the save data for the garage do 
```
[_saveData] call HR_GRG_fnc_loadSaveData;
```
Note this is a ``server only`` function

----------------------------------------------------------
- Furter customisation of the garage behaviour can be done in the ``config.inc`` file located in ``Root\Garage``
