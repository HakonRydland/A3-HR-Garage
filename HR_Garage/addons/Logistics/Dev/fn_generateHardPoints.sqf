/*
    Author: [Håkon]
    [Description]
        Generates a rough node array for you based on the visual start and end of the intended cargo plane,
        in addition visual guides are rendered on screen to give you an idea of where it is relative to you.
        visuals last for 60 seconds.

        These are:
            Green dot   : start position of cargo plane (only visible if you can see the position)
            Red dot     : end position of cargo plane (only visible if you can see the position)
            white line  : cargo plane bounds
            white dots  : Node return positions

    Arguments:
    0. <Object> Vehicle your generating the nodes for
    1. <Array>  Model relativ position of cargo plane start position
    2. <Int>    The lenght of the cargo plane
    3. <Bool>   Return preped for model based definition instead of class based

    Return Value:
    <Array> vehicle hardpoint point [model, node array]

    Scope: Clients
    Environment: unscheduled
    Public: [Yes]
    Dependencies:

    Example: [cursorTarget, [0,-0.7,-0.7], 2.1] call HR_logistics_fnc_generateHardPoints;
*/
#include "..\script_component.hpp"
params [["_vehicle", objNull, [objNull]], ["_planeStart", [], [[]], 3], ["_planeSpan", 0, [0]], ["_defineWithModel", true, [true]]];

//validate input
if (isNull _vehicle) exitWith {"Null vehicle"};
if (_planeStart isEqualTo []) exitWith {"Invalid start off plane"};
if (_planeSpan < 0) exitWith {"Plane length cannot be negative"};

//calculate nodes
private _planeEnd = +_planeStart;
_planeEnd set [1, (_planeEnd#1) - _planeSpan];
private _diameter = 0.8;
private _radius = _diameter/2;// get some distance from walls
private _plane = _planeStart vectorDiff _planeEnd;

private _nodeArray = [];
private _node = _planeStart vectorDiff [0,_radius,0];//first point
while {(_radius*1.5) < (_plane#1)} do {
    _plane = _plane vectorDiff [0,_diameter,0];
    _nodeArray pushBack _node;
    _node = _node vectorDiff [0,_diameter,0];
};

//construct output string
private _nodes = [];
{
    private _offsetArray = str _x;

    _nodes pushBack text (format [
        "        class %1%3        {%3            offset[] = {%2};%3        };",
        "Node"+ str (_forEachIndex + 1),
        _offsetArray select [1, count _offsetArray - 2],
        endl
    ]);
} forEach _nodeArray;
private _nodesString = "    class Nodes" + endl + "    {" + endl + (_nodes joinString endl) + endl + "    };";

private _return = format ["class %1 : TRIPLES(ADDON,Nodes,Base)%3{%3    %2%3};%3",
    if (_defineWithModel) then { modelOfClass(typeOf _vehicle) } else { typeOf _vehicle },
    _nodesString,
    endl
];

//Rendering visuals
HR_Logistics_nodeArray = _nodeArray;
HR_Logistics_vehicle = _vehicle;
HR_Logistics_pStart = _planeStart;
HR_Logistics_pEnd = _planeEnd;
HR_Logistics_RenderTime = time + 60;

if !(isNil "HR_Logistics_RenderCP") exitWith {_return};
HR_Logistics_RenderCP = addMissionEventHandler ["Draw3D", {
    //get the render position of the start and end cargo plane positions
    private _startPos = HR_Logistics_vehicle modelToWorldVisual HR_Logistics_pStart;
    private _startPosASL = HR_Logistics_vehicle modelToWorldVisualWorld HR_Logistics_pStart;
    private _endPos = HR_Logistics_vehicle modelToWorldVisual HR_Logistics_pEnd;
    private _endPosASL = HR_Logistics_vehicle modelToWorldVisualWorld HR_Logistics_pEnd;

    //plane boundries corner positions
    private _startGuide1 = HR_Logistics_vehicle modelToWorldVisual (HR_Logistics_pStart vectorAdd [-0.6,0,0]);
    private _startGuide2 = HR_Logistics_vehicle modelToWorldVisual (HR_Logistics_pStart vectorAdd [0.6,0,0]);
    private _endGuide1 = HR_Logistics_vehicle modelToWorldVisual (HR_Logistics_pEnd vectorAdd [-0.6,0,0]);
    private _endGuide2 = HR_Logistics_vehicle modelToWorldVisual (HR_Logistics_pEnd vectorAdd [0.6,0,0]);

    //Plane Start and end
    if (count (lineIntersectsSurfaces [eyePos player, _startPosASL, player]) isEqualTo 0) then {
        drawIcon3D ["\a3\ui_f\data\map\markers\military\dot_ca.paa", [0.1,0.9,0.2,1], _startPos, 0.6, 0.6, 0, "", true, 0.03, "TahomaB", "center"];
    };
    if (count (lineIntersectsSurfaces [eyePos player, _endPosASL, player]) isEqualTo 0) then {
        drawIcon3D ["\a3\ui_f\data\map\markers\military\dot_ca.paa", [0.9,0.1,0.2,1], _endPos, 0.6, 0.6, 0, "", true, 0.03, "TahomaB", "center"];
    };

    //plane boundries
    drawLine3D [_startGuide1, _startGuide2, [0.9,0.9,0.9,1]];
    drawLine3D [_endGuide1, _endGuide2, [0.9,0.9,0.9,1]];
    drawLine3D [_startGuide1, _endGuide1, [0.9,0.9,0.9,1]];
    drawLine3D [_startGuide2, _endGuide2, [0.9,0.9,0.9,1]];

    //nodes
    {
        drawIcon3D ["\a3\ui_f\data\map\markers\military\dot_ca.paa", [0.9,0.9,0.9,1], HR_Logistics_vehicle modelToWorldVisual _x, 0.6, 0.6, 0, "", true, 0.03, "TahomaB", "center"];
    } forEach HR_Logistics_nodeArray;


    //remove if render time is out
    if (HR_Logistics_RenderTime < time || isNull HR_Logistics_vehicle) then {
        removeMissionEventHandler ["Draw3D", HR_Logistics_RenderCP];
        HR_Logistics_RenderCP = nil;
        HR_Logistics_vehicle = nil;
        HR_Logistics_pStart = nil;
        HR_Logistics_pEnd = nil;
        HR_Logistics_RenderTime = nil;
    };
}];

_return;
