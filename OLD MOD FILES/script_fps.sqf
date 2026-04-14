#include "script_component.hpp"

/*
This an edited version of DriftingNitro's Zeus Framerate Monitor. Full credit to the original Authors.
Hints, System Messages and obsolete Code have been removed.
FPS Visible Distance has been reduced from 1200m to 500m from Zeus by default.
Replaced ASLToAGL getPosASL with AGLToASL getPosASLVisual for a smoother display.
Replaced isMultiplayer with hasinterface for Singleplayer Support. (Would just display defaultValue otherwise)
Added Minimum Distance of 0 By Default.
Replaced ATLtoASL Conversion of positionCameraToWorld with curatorCamera modelToWorld for optimal distance detection.
Allows Min Value to be above 0 and Max to be below 50 or whatever the distance is to Water level
Changed defaultValue of FPS to 999 so people will scream at me if it breaks rather than eachother.
Changed Default FontSize of Low FPS Text from 0.05 to 0.04
Increased Regular Text Transparency from 0.7 to 0.75 by default.
Removed Name from Fps Display Text. Only shows "FPS: Value" now.
Added CBA Settings for pretty much everything.
*/

/*
Hey, I just wanted to state what I added: Different modes, not just FPS like Desync, ping etc.
I also added some more conditions and safety checks. New keybind were added with the CBA system for better stability
- Phenosi
*/

missionNamespace setVariable  ["ZFM_ModToggle",SET(toggle)];
if (!ZFM_ModToggle) exitWith {};

/////////////////////////////////////////////////////////
////////////Script Written by DriftingNitro//////////////
//////////Help from Commy2, Dedmen, and Dscha////////////
/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
//Waits until curators are initalized in order to check//
//if player is zeus/admin to run the fps scripts       //
/////////////////////////////////////////////////////////

waitUntil {_adminState = call BIS_fnc_admin; sleep 5; (!isNull (findDisplay 312)) || (_adminState == 2)};	

//_module addEventHandler ['CuratorObjectRegistered',{}];
//RscDisplayCurator .. idd=312 - thanks dedmen
/////////////////////////////////////////////////////////
//If player is a curator it will run the script and each/
//player will have their FPS appear beneath them       //
/////////////////////////////////////////////////////////
	
DNI_showFrames = true;

missionNamespace setVariable  ["ZFM_FPSViewDistanceMin",SET(viewdistance_min)];
missionNamespace setVariable  ["ZFM_FPSViewDistanceMax",SET(viewdistance_max)];
missionNamespace setVariable  ["ZFM_LowFPSLimit",SET(low_fps_limit)];
missionNamespace setVariable  ["ZFM_Font",SET(font)];
missionNamespace setVariable  ["ZFM_TextRegularColour",SET(regular_text_colour)];
missionNamespace setVariable  ["ZFM_TextRegularSize",SET(regular_text_size)];
missionNamespace setVariable  ["ZFM_TextRegularOutline",SET(regular_text_outline)];
missionNamespace setVariable  ["ZFM_TextLowColour",SET(low_text_colour)];
missionNamespace setVariable  ["ZFM_TextLowSize",SET(low_text_size)];
missionNamespace setVariable  ["ZFM_TextLowOutline",SET(low_text_outline)];

addMissionEventHandler ["Draw3D", {
	if (isNil QGVAR(PlayersDataMap)) exitWith {};
	{
		private _playerData = GVAR(PlayersDataMap) getOrDefault [(getPlayerUID _x), [-1,-1,-1], false];
		_distance = (curatorCamera modelToWorld [0,0,0]) distance _x;
		//if camera is closer than ZFM_FPSViewDistanceMin (Default 0) and farther than ZFM_FPSViewDistanceMax (Default 500) meters away from the targets the text will not display
		if (_distance > ZFM_FPSViewDistanceMin and _distance < ZFM_FPSViewDistanceMax) then {
			// private _playerFPS = _x getVariable ["DNI_PlayerFPS", -1];
			// private _avgPing = _x getVariable ["DNI_avgPing", -1];
			// private _desync = _x getVariable ["DNI_desync", -1];
			private _playerFPS = _playerData # 0;
			private _avgPing = _playerData # 1;
			private _desync = _playerData # 2;
			
			switch (missionNamespace getVariable ["DNI_MonitorMode", 0]) do {
					case 0: {
							//FPS
							//if the FPS is below ZFM_LowFPSLimit (Default 20) it turns red and becomes more visible for zeus/admin to see so they are aware
							if ((_playerFPS isNotEqualTo -1) and { _playerFPS  < ZFM_LowFPSLimit }) then {
								if(DNI_showFrames) then {
									drawIcon3D
									[
										"",//Path to image displayed near text
										ZFM_TextLowColour,//color of the text using RGBA
										ASLToAGL getPosASLVisual _x,//position of the text _x referring to the player in 'allPlayers'
										1,//Width
										2,//height from position, below
										0,//angle
										format["FPS: %1", str _playerFPS],//text to be displayed
										ZFM_TextLowOutline,//shadow on text, 0=none,1=shadow,2=outline
										ZFM_TextLowSize,//text size
										ZFM_Font,//text font
										"center"//align text left, right, or center
									];
								};
							}
							//if the FPS is above 20 text is smaller and less visible as to not concern zeus/admin as much
							else
							{
								if(DNI_showFrames) then {
									drawIcon3D
									[
										"",//Path to image displayed near text
										ZFM_TextRegularColour,//color of the text using RGBA
										ASLToAGL getPosASLVisual _x,//position of the text _x referring to the player in 'allPlayers'
										1,//Width
										2,//height from position, below
										0,//angle
										format["FPS: %1", str _playerFPS],//text to be displayed
										ZFM_TextRegularOutline,//shadow on text, 0=none,1=shadow,2=outline
										ZFM_TextRegularSize,//text size
										ZFM_Font,//text font
										"center"//align text left, right, or center
									];
								};
							};
						};
					case 1: { 
							//PING 
							if ((_avgPing isNotEqualTo -1) and { _avgPing >= SET(high_ping_limit) }) then {
								if(DNI_showFrames) then {
									drawIcon3D
									[
										"",//Path to image displayed near text
										ZFM_TextLowColour,//color of the text using RGBA
										ASLToAGL getPosASLVisual _x,//position of the text _x referring to the player in 'allPlayers'
										1,//Width
										2,//height from position, below
										0,//angle
										format["Ping: %1", str _avgPing],//text to be displayed
										ZFM_TextLowOutline,//shadow on text, 0=none,1=shadow,2=outline
										ZFM_TextLowSize,//text size
										ZFM_Font,//text font
										"center"//align text left, right, or center
									];
								};
							} else {
								if((DNI_showFrames)) then {
									drawIcon3D
									[
										"",//Path to image displayed near text
										ZFM_TextRegularColour,//color of the text using RGBA
										ASLToAGL getPosASLVisual _x,//position of the text _x referring to the player in 'allPlayers'
										1,//Width
										2,//height from position, below
										0,//angle
										format["Ping: %1", str _avgPing],//text to be displayed
										ZFM_TextRegularOutline,//shadow on text, 0=none,1=shadow,2=outline
										ZFM_TextRegularSize,//text size
										ZFM_Font,//text font
										"center"//align text left, right, or center
									];
								};
							};
						};
					case 2: {
							//Desync 
							if ((_desync isNotEqualTo -1) and { _desync >= 2000 }) then {
								if(DNI_showFrames) then {
									if (SET(DesyncVisual_toggle)) then {
										if ((_desync >= 19999)) then {
											drawIcon3D
											[
												"a3\ui_f\data\gui\rsc\rscpendinginvitation\desynchigh_ca.paa",//Path to image displayed near text
												[1, 1, 1, 0.85],//color of the text using RGBA
												[((unitAimPositionVisual _x)#0),((unitAimPositionVisual _x)#1),(((unitAimPositionVisual _x)#2) +0.5)],//position of the text _x referring to the player in 'allPlayers'
												1,//Width
												1,//height from position, below
												0,//angle
												format["%1", str _desync],//text to be displayed
												ZFM_TextLowOutline,//shadow on text, 0=none,1=shadow,2=outline
												ZFM_TextLowSize,//text size
												ZFM_Font,//text font
												"center"//align text left, right, or center
											];
										} else {
											drawIcon3D
											[
												"a3\ui_f\data\gui\rsc\rscpendinginvitation\desynclow_ca.paa",//Path to image displayed near text
												[1, 1, 1, 0.85],//color of the text using RGBA
												[((unitAimPositionVisual _x)#0),((unitAimPositionVisual _x)#1),(((unitAimPositionVisual _x)#2) +0.5)],//position of the text _x referring to the player in 'allPlayers'
												1,//Width
												1,//height from position, below
												0,//angle
												format["%1", str _desync],//text to be displayed
												ZFM_TextLowOutline,//shadow on text, 0=none,1=shadow,2=outline
												ZFM_TextLowSize,//text size
												ZFM_Font,//text font
												"center"//align text left, right, or center
											];										
										};
									} else {
										if ((_desync >= 19999)) then {
											drawIcon3D
											[
												"",//Path to image displayed near text
												ZFM_TextLowColour,//color of the text using RGBA
												ASLToAGL getPosASLVisual _x,//position of the text _x referring to the player in 'allPlayers'
												1,//Width
												2,//height from position, below
												0,//angle
												format["Desync: %1", str _desync],//text to be displayed
												ZFM_TextLowOutline,//shadow on text, 0=none,1=shadow,2=outline
												ZFM_TextLowSize,//text size
												ZFM_Font,//text font
												"center"//align text left, right, or center
											];
										} else {
											drawIcon3D
											[
												"",//Path to image displayed near text
												[1, 0.8, 0, 0.85],//color of the text using RGBA
												ASLToAGL getPosASLVisual _x, //position of the text _x referring to the player in 'allPlayers'
												1,//Width
												2,//height from position, below
												0,//angle
												format["Desync: %1", str _desync],//text to be displayed
												ZFM_TextLowOutline,//shadow on text, 0=none,1=shadow,2=outline
												ZFM_TextLowSize,//text size
												ZFM_Font,//text font
												"center"//align text left, right, or center
											];										
										};
									};
								};
							} else {
								if (DNI_showFrames) then {
									if (SET(DesyncVisual_toggle)) then {
										drawIcon3D
										[
											"a3\ui_f\data\igui\rsctitles\rschvtphase\jac_a3_signal_4_ca.paa",//Path to image displayed near text
											[0, 1, 0.3, 0.85],//color of the text using RGBA
											[((unitAimPositionVisual _x)#0),((unitAimPositionVisual _x)#1),(((unitAimPositionVisual _x)#2) +0.5)],//position of the text _x referring to the player in 'allPlayers'
											1.7,//Width
											1,//height from position, below
											0,//angle
											format["%1", str _desync],//text to be displayed Desync: %1
											ZFM_TextRegularOutline,//shadow on text, 0=none,1=shadow,2=outline
											ZFM_TextRegularSize,//text size
											ZFM_Font,//text font
											"center"//align text left, right, or center
										];
									} else {
										drawIcon3D
										[
											"",//Path to image displayed near text
											[0, 1, 0.3, 0.85],//color of the text using RGBA
											ASLToAGL getPosASLVisual _x,//position of the text _x referring to the player in 'allPlayers'
											1,//Width
											2,//height from position, below
											0,//angle
											format["Desync: %1", str _desync],//text to be displayed Desync: %1
											ZFM_TextRegularOutline,//shadow on text, 0=none,1=shadow,2=outline
											ZFM_TextRegularSize,//text size
											ZFM_Font,//text font
											"center"//align text left, right, or center
										];
									};
								};
							};
					 };
					default { 
						if (DNI_showFrames) then {
							drawIcon3D
							[
								"",//Path to image displayed near text
								ZFM_TextLowColour,//color of the text using RGBA
								ASLToAGL getPosASLVisual _x,//position of the text _x referring to the player in 'allPlayers'
								1,//Width
								1,//height from position, below
								0,//angle
								format["N/A %1", str _playerFPS],//text to be displayed
								ZFM_TextRegularOutline,//shadow on text, 0=none,1=shadow,2=outline
								ZFM_TextRegularSize,//text size
								ZFM_Font,//text font
								"center"//align text left, right, or center
							];
						};
					};
				};
			};
	} forEach allPlayers;
	//Here is the array of units you wish to display the FPS text for, it can be 
	//changed to be an array of specific units or players if you wish
}];

/////////////////////////////////////////////////////////
/////////////////////End FPS Script//////////////////////
/////////////////////////////////////////////////////////
