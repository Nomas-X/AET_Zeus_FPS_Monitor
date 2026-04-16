#include "../script_component.hpp"

/*	here, you put in your CBA Settings so they are available in the editor!
[
	
	QSET(displayMusic),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	["Display Music Title","This enables the message of the currently played music title by the CVO Music System"],
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	["AET", "AET Music"],					//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	false,									//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	0,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
*/

[
	QSET(toggle), "CHECKBOX",
	["Enable Mod", "Toggle the Mod on or off."],
 	"Zeus Framerate Monitor Rework", true, true,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			GVAR(showFrames) = false;
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(viewdistance_min), "SLIDER",
	["FPS Minimum Viewdistance", "Sets the minimum distance the Curator Camera can be from an Unit before its FPS are no longer displayed underneath."],
 	"Zeus Framerate Monitor Rework",
 	[0, 5000, 0, 0], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

// Draw3D Text will not appear when script is told to display at below 50m
[
	QSET(viewdistance_max), "SLIDER",
	["FPS Maximum Viewdistance", "Sets the maximum distance the Curator Camera can be from an Unit before its FPS are no longer displayed underneath."],
 	"Zeus Framerate Monitor Rework",
 	[0, 15000, 500, 0], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(low_fps_limit), "SLIDER",
	["Low FPS Limit", "Sets the FPS Limit under which the Low FPS Text will be displayed instead of the regular one."],
 	"Zeus Framerate Monitor Rework",
 	[15, 60, 20, 0], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(high_ping_limit), "SLIDER",
	["High Ping Limit", "Sets the ping (ms) limit above which the High Ping Text will be displayed instead of the regular one."],
	"Zeus Framerate Monitor Rework",
	[50, 1000, 250, 0], 0,
	{
		["CBA_SettingChanged", 
			{
				terminate GVAR(scriptHandle);
				[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;


[
	QSET(font), "LIST",
	["Font", "Sets the font to be used for the Texts"],
 	"Zeus Framerate Monitor Rework",
 	[[	
	"Caveat",
  	"EtelkaMonospacePro",
    "EtelkaMonospaceProBold",
    "EtelkaNarrowMediumPro",
	"LCD14",
	"PuristaBold",
    "PuristaLight",
    "PuristaMedium",
    "PuristaSemibold",
    "RobotoCondensed",
    "RobotoCondensedBold",
    "RobotoCondensedLight",
	"TahomaB"
	],
	[
	"Caveat",
  	"Etelka Monospace Pro",
    "Etelka Monospace Pro Bold",
    "Etelka Narrow Medium Pro",
	"Lucidia Console B",
	"Purista Bold",
    "Purista Light",
    "Purista Medium",
    "Purista Semibold",
    "Roboto Condensed",
    "Roboto Condensed Bold",
    "Roboto Condensed Light",
	"Tahoma Bold"
	], 9], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(regular_text_colour), "COLOR",
	["Colour", "Sets the Colour and Alpha Value of the Text to be displayed."],
 	["Zeus Framerate Monitor Rework", "Regular Text"],
 	[1, 1, 1, 0.75], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;


[
	QSET(regular_text_size), "SLIDER",
	["Size", "Sets the size of the Text to be displayed."],
 	["Zeus Framerate Monitor Rework", "Regular Text"],
 	[0.02, 0.04, 0.03, 2], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(regular_text_outline), "LIST",
	["Outline", "Sets whether or not the Text should be displayed with an Outline"],
 	["Zeus Framerate Monitor Rework", "Regular Text"],
 	[[0, 2],["No", "Yes"]], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(low_text_colour), "COLOR",
	["Colour", "Sets the Colour and Alpha Value of the Low FPS Text to be displayed."],
 	["Zeus Framerate Monitor Rework", "Low FPS Text"],
 	[1, 0, 0, 0.5], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(low_text_size), "SLIDER",
	["Size", "Sets the size of the Low FPS Text to be displayed."],
 	["Zeus Framerate Monitor Rework", "Low FPS Text"],
 	[0.03, 0.05, 0.04, 2], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(low_text_outline), "LIST",
	["Outline", "Sets whether or not the Low FPS Text should be displayed with an Outline"],
 	["Zeus Framerate Monitor Rework", "Low FPS Text"],
 	[[0, 2],["No", "Yes"]], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	QSET(DesyncVisual_toggle), "CHECKBOX",
	["Desync: Icon/Text Toggle", "[Default: Icons] Toggle the Desync using Icons above the head or text below"],
 	["Zeus Framerate Monitor Rework", "Desync"], true, false,
	{
		["CBA_SettingChanged", 
			{
			terminate GVAR(scriptHandle);
			[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

//keybinds
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

["Zeus Framerate Monitor Rework", "switchModes", ["Switch Monitor Mode", "hello there! :))"], {

	_CurrentMode = missionNamespace getVariable [QGVAR(MonitorMode), 0];
	_NewMode = _CurrentMode + 1;
	if (_NewMode >= 3) then { _NewMode = 0; };
	missionNamespace setVariable [QGVAR(MonitorMode), _NewMode];

}, {}, [DIK_GRAVE, [true, true, false]]] call cba_fnc_addKeybind;

[
	"Zeus Framerate Monitor Rework", 
	"toggleFrameDisplay", 
	["Toggle Display", "Toggles whether FPS/Ping/Desync HUD elements are shown."], 
	{
		if !(SET(toggle)) exitWith {};
		GVAR(showFrames) = !GVAR(showFrames);
	}, 
	{}, 
	[DIK_GRAVE, [false, true, false]]  // Ctrl only
] call CBA_fnc_addKeybind;
