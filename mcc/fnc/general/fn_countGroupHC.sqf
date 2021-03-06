//==================================================================MCC_fnc_countGroupHC===============================================================================================
// Count the number of infantry, vehicles, tank, air, ships in a group expand
// Example: [_group1] call MCC_fnc_countGroupHC;
// _group1 = group, the group name
//===========================================================================================================================================================================	
private ["_group","_infantryCount","_vehicleCount","_tankCount","_airCount","_shipCount","_vehiclePic",
		 "_pic","_tankPic","_airPic","_boatPic","_vehicleClass","_reconCount","_supportPic","_supportCount","_autonomousCount","_autonomousPic"];

_group 			= _this select 0; 
_infantryCount 	= 0;
_reconCount		= 0;

_vehicleCount	= 0;
_tankCount		= 0;
_supportCount	= 0;
_airCount		= 0;
_shipCount		= 0;
_autonomousCount = 0;

_tempVehicles	= [];
_vehiclePic		= []; 
_tankPic		= []; 
_supportPic		= [];
_airPic			= []; 
_boatPic		= []; 
_autonomousPic	= [];

if (! isnil "_group") then {
	{
		_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> typeof (vehicle _x) >> "vehicleClass")); 
		if ((vehicle _x) != _x) then {
			if (!((vehicle _x) in _tempVehicles)) then {
				_tempVehicles set [count _tempVehicles, vehicle _x];
				_pic = gettext (configFile >> "CfgVehicles" >> typeof (vehicle _x) >> "picture"); 
				
				if (_vehicleClass == "car") then 
					{
						_vehicleCount = _vehicleCount + 1;
						_vehiclePic set [count _vehiclePic,_pic];
					};
				if (_vehicleClass == "armored") then 
					{
						_tankCount = _tankCount + 1;
						_tankPic set [count _tankPic,_pic];
					};
					
				if (_vehicleClass == "support" || _vehicleClass == "static") then 									//support
					{
						_supportCount = _supportCount + 1;
						_supportPic set [count _supportPic,_pic];
					};
					
				if (_vehicleClass == "air") then 
					{
						_airCount = _airCount + 1;
						_airPic set [count _airPic,_pic];
					};
				if (_vehicleClass == "ship" || _vehicleClass == "submarine") then
					{
						_shipCount = _shipCount + 1;
						_boatPic set [count _boatPic,_pic];
					};
				if (_vehicleClass == "autonomous") then 											//atunomos
					{
						_autonomousCount = _autonomousCount + 1;
						_autonomousPic set [count _autonomousPic,_pic]; 
					};
				};
			} else	{
					if (_vehicleClass == "men" || _vehicleClass == "menstory"  || _vehicleClass == "mensupport") then {_infantryCount = _infantryCount + 1}; 
					if (_vehicleClass == "mendiver" || _vehicleClass == "menrecon" || _vehicleClass == "mensniper") then {_reconCount = _reconCount + 1};
				};
	} foreach units _group; 
	[_infantryCount,_vehicleCount,_tankCount,_airCount,_shipCount,_reconCount,_supportCount,_autonomousCount,[_vehiclePic,_tankPic,_airPic,_boatPic,_supportPic,_autonomousPic]];
};
