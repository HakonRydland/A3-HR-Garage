/*
    Author: [Håkon]
    [Description]
        Handles placement attempt of a vehicle

    Arguments:
    0. <String> className of vehicle
    1. <String> callback name (optional)(see HR_Garage_fnc_callbackHandler for code)
    2. <Any>    Arguments for the callback (optional)
    3. <Array>  Arrays of [className of Mount, Index of mount in garage] (optional) (internal)
    4. <Array>  Pylons (optional)
    5. <Struct/nil> Vehicle state (optional)
    6. <Bool>   use garage vehicle pool for placement (optional: default false)

    Return Value:
    <nil>

    Scope: Clients
    Environment: Any
    Public: [Yes]
    Dependencies:

    Example: [_class, [], [], nil, false] call HR_Garage_fnc_confirmPlacement;

    License: APL-ND
*/
#include "\a3\ui_f\hpp\definedikcodes.inc"
params [
    ["_class", "", [""]]
    , ["_callBack", ""]
    , ["_callBackArgs", []]
    , ["_mounts", [], [[]]]
    , ["_pylons", [], [[]]]
    , "_state"
    , ["_useGRGPool", false, [false]]
];

if (!isClass (configFile >> "CfgVehicles" >> _class)) exitWith {HR_Garage_placing = false};
if (isNil "HR_Garage_curTexture") then {HR_Garage_curTexture = []};
if (isNil "HR_Garage_curAnims") then {HR_Garage_curAnims = []};
HR_Garage_placing = true;

//define global variables
HR_Garage_pos = screenToWorld [0.5,0.5];
HR_Garage_dir = 0;
HR_Garage_keyPause = time;
HR_Garage_keyQ = false;
HR_Garage_keyE = false;
HR_Garage_validPlacement = 0;
HR_Garage_CP_mounts = _mounts;
HR_Garage_CP_pylons = _pylons;
HR_Garage_usePool = _useGRGPool;
HR_Garage_CP_callBack = [_callBack, _callBackArgs];
HR_Garage_callBackFeedback = "";
HR_Garage_EH_EF = -1;
HR_Garage_EH_keyDown = -1;

//define private use function
HR_Garage_cleanUp = {
    //remove EH's
    removeMissionEventHandler ["EachFrame", HR_Garage_EH_EF];
    findDisplay 46 displayRemoveEventHandler ["KeyDown", HR_Garage_EH_keyDown];
    terminate HR_Garage_keyHint;

    //remove display vehicle
    { detach _x; deleteVehicle _x } forEach (attachedObjects HR_Garage_dispVehicle);
    deleteVehicle HR_Garage_dispVehicle;

    //clean variables
    HR_Garage_dispVehicle = nil;
    HR_Garage_pos = nil;
    HR_Garage_dir = nil;
    HR_Garage_bb = nil;
    HR_Garage_keyPause = nil;
    HR_Garage_keyQ = nil;
    HR_Garage_keyE = nil;
    HR_Garage_EH_EF = nil;
    HR_Garage_EH_keyDown = nil;
    HR_Garage_keyHint = nil;
    HR_Garage_placing = false;
    HR_Garage_accessPoint = objNull;
};

//create display vehicle localy
HR_Garage_dispVehicle = _class createVehicleLocal HR_Garage_pos;
if (!isNil "_state") then {
    [HR_Garage_dispVehicle, _state] call HR_Garage_fnc_setState;
};
HR_Garage_dispVehicle enableSimulation false;
HR_Garage_dispVehicle allowDamage false;
HR_Garage_dispVehicle lock true;
HR_Garage_dispVehicle lockInventory true;
HR_Garage_dispVehicle setDir HR_Garage_dir;
[HR_Garage_dispVehicle, HR_Garage_curTexture, HR_Garage_curAnims] call BIS_fnc_initVehicle;
HR_Garage_dispMounts = [];
{
    private _static = (_x#0) createVehicleLocal HR_Garage_pos;
    [_static, _x#2] call HR_Garage_fnc_setState;
    _static enableSimulation false;
    _static allowDamage false;

    private _nodes = [HR_Garage_dispVehicle, _static] call HR_logistics_fnc_canLoad;
    if (_nodes isEqualType 0) exitWith {};
    (_nodes + [true]) call HR_logistics_fnc_load; //we know we can load it, just need the nodes from can load
    hintSilent ""; //clear load hint

    private _offsetAndDir = [_static] call HR_logistics_fnc_getCargoOffsetAndDir;
    private _node = _nodes#2;
    private _nodeOffset = if ((_node#0) isEqualType []) then {
        private _lastNode = (count _node) -1;
        private _offsetOne = (_node#0#1);
        private _offsetTwo = (_node#_lastNode#1);
        private _diff = _offsetOne vectorDiff _offsetTwo;
        _offsetTwo vectorAdd [0,(_diff#1)/2,0];//middle of nodes
    } else { _node#1 };//only one node so on node

    HR_Garage_dispMounts pushBack [
        _static
        , _nodeOffset vectorAdd (_offsetAndDir#0)//vector add static offset
        , _offsetAndDir#1
        , _x
    ]; //format [static object, attachment offset, rotation, static data]
} forEach HR_Garage_CP_mounts;

{
    _x params ["_pylonIndex", "_mag", "_forced", "_turret"];
    HR_Garage_dispVehicle setPylonLoadout [_pylonIndex, _mag, _forced, _turret];
} forEach HR_Garage_CP_pylons;

{
    _x hideObject true;
} forEach (attachedObjects HR_Garage_dispVehicle);
HR_Garage_dispVehicle hideObject true;

//calculate raycast positions
private _bb = (0 boundingBoxReal HR_Garage_dispVehicle);
private _back = (_bb#0#1);
private _front = (_bb#1#1);
private _top = (_bb#1#2);
private _left = (_bb#0#0);
private _right = (_bb#1#0);
private _bottom = (_bb#0#2) + 0.2;//rais slightly from the ground
private _knee = _bottom + 0.5;
HR_Garage_rays = [
    //outer box
    [[_left,_back,_bottom], [_right,_back,_top]]            //back cross
    ,[[_left,_back,_top], [_right,_back,_bottom]]

    ,[[_left,_front,_bottom], [_right,_front,_top]]         //front cross
    ,[[_left,_front,_top], [_right,_front,_bottom]]

    ,[[_left,_back,_bottom], [_left,_front,_top]]           //left cross
    ,[[_left,_back,_top], [_left,_front,_bottom]]

    ,[[_right,_back,_bottom], [_right,_front,_top]]         //right cross
    ,[[_right,_back,_top], [_right,_front,_bottom]]

    ,[[_left,_back,_top], [_right,_front,_top]]             //top cross
    ,[[_right,_back,_top], [_left,_front,_top]]

    ,[[_left,_back,_bottom], [_right,_front,_bottom]]       //bottom cross
    ,[[_right,_back,_bottom], [_left,_front,_bottom]]

    ,[[_left,_back,_bottom], [_left,_back,_top]]            //back left vertical
    ,[[_left,_front,_bottom], [_left,_front,_top]]          //front left vertical
    ,[[_right,_back,_bottom], [_right,_back,_top]]          //back right vertical
    ,[[_right,_front,_bottom], [_right,_front,_top]]        //front right vertical

    ,[[_left,_back,_bottom], [_left,_front,_bottom]]        //left bottom horisontal
    ,[[_left,_back,_top], [_left,_front,_top]]              //left top horisontal

    ,[[_right,_back,_bottom], [_right,_front,_bottom]]      //right bottom horisontal
    ,[[_right,_back,_top], [_right,_front,_top]]            //right top horisontal

    ,[[_left,_front,_bottom], [_right,_front,_bottom]]      //front bottom horisontal
    ,[[_left,_front,_top], [_right,_front,_top]]            //front top horisontal

    ,[[_left,_back,_bottom], [_right,_back,_bottom]]        //back bottom horisontal
    ,[[_left,_back,_top], [_right,_back,_top]]              //back top horisontal

    //inner lines
    ,[[_left,_back,_bottom], [_right,_front,_top]]          //diag 1
    ,[[_left,_back,_top], [_right,_front,_bottom]]

    ,[[_right,_back,_bottom], [_left,_front,_top]]          //diag 2
    ,[[_right,_back,_top], [_left,_front,_bottom]]

    ,[[_left,_back,0], [_right,_front,0]]                   //diag 3
    ,[[_right,_back,0], [_left,_front,0]]

    ,[[_left,0,0], [_right,0,0]]                            //center
    ,[[0,_back,0], [0,_front,0]]
    ,[[0,0,_bottom], [0,0,_top]]

    ,[[_left,_back,_knee], [_right,_front,_knee]]           //knee check
    ,[[_right,_back,_knee], [_left,_front,_knee]]
    ,[[0,_back,_knee], [0,_front,_knee]]
    ,[[_left,0,_knee], [_right,0,_knee]]
    ,[[_left,_back,_knee], [_left,_front,_knee]]
    ,[[_left,_front,_knee], [_right,_front,_knee]]
    ,[[_right,_front,_knee], [_right,_back,_knee]]
    ,[[_right,_back,_knee], [_left,_back,_knee]]
];

//player in vehicle detection
private _diff = ((_bb#1) vectorDiff (_bb#0)) apply {_x/2};
private _adjustment = (_bb#1) vectorDiff _diff;
HR_Garage_dispSquare = [_adjustment, _diff apply {_x + 0.6}, (_bb#2)]; //square offset from center, square radius [x,y], bb diameter

//add EH's (data is set on the display vehicle)
HR_Garage_EH_keyDown = findDisplay 46 displayAddEventHandler ["KeyDown", {
    params ["", "_key"];
    private _return = false;

    //rotate vehicle
    if (_key isEqualTo DIK_Q && HR_Garage_keyPause < time) then {
        _return = true;
        HR_Garage_keyPause = time + 0.01;
        HR_Garage_keyQ = true;
    };

    if (_key isEqualTo DIK_E && HR_Garage_keyPause < time) then {
        _return = true;
        HR_Garage_keyPause = time + 0.01;
        HR_Garage_keyE = true;
    };

    if (HR_Garage_validPlacement > 0) exitWith { // 0 is valid placement, 1 too far away, 2 colision
        if (_key in [DIK_ESCAPE, DIK_RETURN]) then {
            _return = true;
            call HR_Garage_cleanUp;
            [clientOwner, player, "HR_Garage_fnc_releaseAllVehicles"] remoteExecCall ["HR_Garage_fnc_execForGarageUsers", 2];
            HR_Garage_placing = false;
        };
        _return
    };

    //complete or cancel placement
    if (_key in [DIK_ESCAPE, DIK_RETURN, DIK_SPACE, DIK_Y]) then {
        _return = true;

        //get type from display vehicle, and private copies of pos and dir
        private _class = typeOf HR_Garage_dispVehicle;
        private _state = [HR_Garage_dispVehicle] call HR_Garage_fnc_getState;
        private _pos = HR_Garage_pos;
        private _dir = HR_Garage_dir;
        call HR_Garage_cleanUp;

        //place vehicle if confirming placement
        private _placed = if (_key isEqualTo DIK_SPACE) then {
            //create vehicle
            private _veh = _class createVehicle [0,0,10000];
            [_veh] call HR_Garage_fnc_prepPylons;
            [_veh, _state] call HR_Garage_fnc_setState;
            _veh enableSimulation false;
            _veh allowDamage false;
            [_veh, HR_Garage_curTexture, HR_Garage_curAnims] call BIS_fnc_initVehicle;
            _veh setDir _dir;
            _veh setPos _pos;
            _veh setVectorUp surfaceNormal position _veh;

            //create and load cargo
            {
                private _static = (_x#0) createVehicle _pos;
                [_static, _x#2] call HR_Garage_fnc_setState;
                _static allowDamage false;
                private _nodes = [_veh, _static] call HR_logistics_fnc_canLoad;
                if (_nodes isEqualType 0) exitWith {};
                (_nodes + [true]) call HR_logistics_fnc_load;
                _static call HR_Garage_fnc_vehInit;
            } forEach HR_Garage_CP_mounts;

            //set pylons loudout
            if !(HR_Garage_CP_pylons isEqualTo []) then {
                {
                    _x params ["_pylonIndex", "_mag", "_forced", "_turret"];
                    _veh setPylonLoadout [_pylonIndex, _mag, _forced, _turret]
                } forEach HR_Garage_CP_pylons;
            };
            _veh spawn {sleep 0.5;_this allowDamage true;_this enableSimulation true; { _x allowDamage true; } forEach (attachedObjects _this); };
            _veh call HR_Garage_fnc_vehInit;
            if !(HR_Garage_usePool) then { [_veh,HR_Garage_CP_callBack, "Placed"] call HR_Garage_fnc_callbackHandler };

            true && (_key isNotEqualTo DIK_Y);
        } else { false };
        //handle garage pool changes
        if (HR_Garage_usePool) then {
            private _fnc = if (_placed) then {"HR_Garage_fnc_removeFromPool"} else {"HR_Garage_fnc_releaseAllVehicles"};
            [clientOwner, player, _fnc] remoteExecCall ["HR_Garage_fnc_execForGarageUsers", 2]; //run code on server as HR_Garage_Users is maintained ONLY on the server
        };
    };

    //block key press if valid key
    _return
}];

HR_Garage_EH_EF = addMissionEventHandler ["EachFrame", {
    private _updateState = false;

    //update Pos and rotation
    if ((HR_Garage_pos distance screenToWorld [0.5,0.5]) > 0.1) then {
        HR_Garage_pos = screenToWorld [0.5,0.5];
        _updateState = true;
    };

    if (HR_Garage_keyQ) then {
        HR_Garage_keyQ = false;
        HR_Garage_dir = HR_Garage_dir - 1;
        _updateState = true;
    };

    if (HR_Garage_keyE) then {
        HR_Garage_keyE = false;
        HR_Garage_dir = HR_Garage_dir + 1;
        _updateState = true;
    };

    //vallidate new pos
    private _hide = {
        {
            _x hideObject _this;
        } forEach (attachedObjects HR_Garage_dispVehicle);
        HR_Garage_dispVehicle hideObject _this;
    };
    if (_updateState) then {
        //if invalid position, block placement
        if (HR_Garage_pos distance player > 50) exitWith { true call _hide; HR_Garage_validPlacement = 1 }; //distance

        private _exit = false;
        {
            _x params ["_start", "_end"];
            if (lineIntersects [
                HR_Garage_dispVehicle modelToWorldVisualWorld _start
                , HR_Garage_dispVehicle modelToWorldVisualWorld _end
                , HR_Garage_dispVehicle
            ]) exitWith { _exit = true; HR_Garage_validPlacement = 2 }; //collision
        } forEach HR_Garage_rays;
        if (_exit) exitWith { true call _hide };

        //callback check
        private _callBack = [HR_Garage_dispVehicle,HR_Garage_CP_callBack, "invalidPlacement"] call HR_Garage_fnc_callbackHandler;
        private _callbackCheck = _callBack param [0, false, [false]];
        HR_Garage_callBackFeedback = _callBack param [1, "", [""]];
        if ( _callbackCheck ) exitWith { true call _hide ; HR_Garage_validPlacement = 3 };

        //player in vehicle
        HR_Garage_dispSquare params ["_adjustment", "_square", "_diameter"];
        _square params ["_a","_b"];
        _nearObjects = HR_Garage_dispVehicle nearObjects ["CAManBase", _diameter];
        private _inArea = _nearObjects inAreaArray [HR_Garage_dispVehicle modelToWorldVisual _adjustment, _a, _b, HR_Garage_dir, true];
        if !(_inArea isEqualTo []) exitWith { true call _hide; HR_Garage_validPlacement = 2 };

        HR_Garage_validPlacement = 0;
        false call _hide;
    };

    //update vehicle placement
    if (_updateState) then {
        HR_Garage_dispVehicle setPos HR_Garage_pos;
        HR_Garage_dispVehicle setDir HR_Garage_dir;
        private _vecUp = surfaceNormal position HR_Garage_dispVehicle;
        HR_Garage_dispVehicle setVectorUp _vecUp;
        {
            (_x#0) setVectorDirAndUp [_x#2, _vecUp];
            (_x#0) attachTo [HR_Garage_dispVehicle, _x#1];
        } forEach HR_Garage_dispMounts;
    };

    //render keybind hint
    private _text = switch HR_Garage_validPlacement do {
        case 0: {localize "STR_HR_Garage_Feedback_CP_Rotation"};
        case 1: {localize "STR_HR_Garage_Feedback_CP_TooFar"};
        case 2: {localize "STR_HR_Garage_Feedback_CP_Blocked"};
        case 3: { HR_Garage_callBackFeedback };
        default {localize "STR_HR_Garage_Feedback_CallbackFailed"};
    };

    HR_Garage_keyHint = [
        _text
        ,0,0.98
        ,0.2
        ,0
        ,0
        ,17001
    ] spawn BIS_fnc_dynamicText;

    if (call HR_Garage_CP_closeCnd) exitWith {
        call HR_Garage_cleanUp;
        if (HR_Garage_usePool) then {
            [clientOwner, player, "HR_Garage_fnc_releaseAllVehicles"] remoteExecCall ["HR_Garage_fnc_execForGarageUsers", 2];
        };
    };

    #ifdef Debug //Debug render
    HR_Garage_dispSquare params ["_adjustment", "_square"];
    _square params ["_a","_b"];
    drawLine3D [HR_Garage_dispVehicle modelToWorldVisual _adjustment,HR_Garage_dispVehicle modelToWorldVisual (_adjustment vectorAdd [_a,0,0]), [0.9,0,0,1]];
    drawLine3D [HR_Garage_dispVehicle modelToWorldVisual _adjustment,HR_Garage_dispVehicle modelToWorldVisual (_adjustment vectorAdd [0,_b,0]), [0.9,0,0,1]];
    drawLine3D [HR_Garage_dispVehicle modelToWorldVisual _adjustment,HR_Garage_dispVehicle modelToWorldVisual (_adjustment vectorAdd [0,0,_c]), [0.9,0,0,1]];
    drawLine3D [HR_Garage_dispVehicle modelToWorldVisual _adjustment,HR_Garage_dispVehicle modelToWorldVisual (_adjustment vectorAdd [-_a,0,0]), [0.9,0,0,1]];
    drawLine3D [HR_Garage_dispVehicle modelToWorldVisual _adjustment,HR_Garage_dispVehicle modelToWorldVisual (_adjustment vectorAdd [0,-_b,0]), [0.9,0,0,1]];
    drawLine3D [HR_Garage_dispVehicle modelToWorldVisual _adjustment,HR_Garage_dispVehicle modelToWorldVisual (_adjustment vectorAdd [0,0,-_c]), [0.9,0,0,1]];
    { drawLine3D [HR_Garage_dispVehicle modelToWorldVisual _x#0,HR_Garage_dispVehicle modelToWorldVisual _x#1, [0.9,0,0,1]] } forEach HR_Garage_rays;
    #endif
}];
