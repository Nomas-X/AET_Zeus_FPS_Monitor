[
	"zfm_setting_toggle", "CHECKBOX",
	["Enable Mod", "Toggle the Mod on or off."],
 	"[Forges of Dorn] Improved Zeus Monitor", true, true,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			DNI_showFrames = false;
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_setting_viewdistance_min", "SLIDER",
	["FPS Minimum Viewdistance", "Sets the minimum distance the Curator Camera can be from an Unit before its FPS are no longer displayed underneath."],
 	"[Forges of Dorn] Improved Zeus Monitor",
 	[0, 5000, 0, 0], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

// Draw3D Text will not appear when script is told to display at below 50m
[
	"zfm_setting_viewdistance_max", "SLIDER",
	["FPS Maximum Viewdistance", "Sets the maximum distance the Curator Camera can be from an Unit before its FPS are no longer displayed underneath."],
 	"[Forges of Dorn] Improved Zeus Monitor",
 	[0, 15000, 500, 0], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_setting_low_fps_limit", "SLIDER",
	["Low FPS Limit", "Sets the FPS Limit under which the Low FPS Text will be displayed instead of the regular one."],
 	"[Forges of Dorn] Improved Zeus Monitor",
 	[15, 60, 20, 0], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_setting_high_ping_limit", "SLIDER",
	["High Ping Limit", "Sets the ping (ms) limit above which the High Ping Text will be displayed instead of the regular one."],
	"[Forges of Dorn] Improved Zeus Monitor",
	[50, 1000, 250, 0], 0,
	{
		["CBA_SettingChanged", 
			{
				terminate ZFM_ScriptHandle;
				ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;


[
	"zfm_setting_font", "LIST",
	["Font", "Sets the font to be used for the Texts"],
 	"[Forges of Dorn] Improved Zeus Monitor",
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
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_setting_regular_text_colour", "COLOR",
	["Colour", "Sets the Colour and Alpha Value of the Text to be displayed."],
 	["[Forges of Dorn] Improved Zeus Monitor", "Regular Text"],
 	[1, 1, 1, 0.75], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;


[
	"zfm_setting_regular_text_size", "SLIDER",
	["Size", "Sets the size of the Text to be displayed."],
 	["[Forges of Dorn] Improved Zeus Monitor", "Regular Text"],
 	[0.02, 0.04, 0.03, 2], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_setting_regular_text_outline", "LIST",
	["Outline", "Sets whether or not the Text should be displayed with an Outline"],
 	["[Forges of Dorn] Improved Zeus Monitor", "Regular Text"],
 	[[0, 2],["No", "Yes"]], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_setting_low_text_colour", "COLOR",
	["Colour", "Sets the Colour and Alpha Value of the Low FPS Text to be displayed."],
 	["[Forges of Dorn] Improved Zeus Monitor", "Low FPS Text"],
 	[1, 0, 0, 0.5], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_setting_low_text_size", "SLIDER",
	["Size", "Sets the size of the Low FPS Text to be displayed."],
 	["[Forges of Dorn] Improved Zeus Monitor", "Low FPS Text"],
 	[0.03, 0.05, 0.04, 2], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_setting_low_text_outline", "LIST",
	["Outline", "Sets whether or not the Low FPS Text should be displayed with an Outline"],
 	["[Forges of Dorn] Improved Zeus Monitor", "Low FPS Text"],
 	[[0, 2],["No", "Yes"]], 0,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;

[
	"zfm_DesyncVisual_toggle", "CHECKBOX",
	["Desync: Icon/Text Toggle", "[Default: Icons] Toggle the Desync using Icons above the head or text below"],
 	["[Forges of Dorn] Improved Zeus Monitor", "Desync"], true, false,
	{
		["CBA_SettingChanged", 
			{
			terminate ZFM_ScriptHandle;
			ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
			}
		] call CBA_fnc_addEventHandler;
	}
] call CBA_fnc_addSetting;
/*
	[
		"zfm_DesyncAlertSytem_toggle", "CHECKBOX",
		["Desync: Alert System", "[Default: True] Will send a message with icon to all on the server whenever there is desync"],
		["[Forges of Dorn] Improved Zeus Monitor", "Desync"], true, false,
		{
			["CBA_SettingChanged", 
				{
				terminate ZFM_ScriptHandle;
				ZFM_ScriptHandle = [] execVM "\DNI_ZeusFPSMonitor\script_fps.sqf";
				}
			] call CBA_fnc_addEventHandler;
		}
	] call CBA_fnc_addSetting;
*/

//keybinds
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

["[Forges of Dorn] Improved Zeus Monitor", "switchModes", ["Switch Monitor Mode", "hello there! :))"], {

	_CurrentMode = missionNamespace getVariable ["DNI_MonitorMode", 0];
	_NewMode = _CurrentMode + 1;
	if (_NewMode >= 3) then { _NewMode = 0; };
	missionNamespace setVariable ["DNI_MonitorMode", _NewMode];

}, {}, [DIK_GRAVE, [true, true, false]]] call cba_fnc_addKeybind;

[
	"[Forges of Dorn] Improved Zeus Monitor", 
	"toggleFrameDisplay", 
	["Toggle Display", "Toggles whether FPS/Ping/Desync HUD elements are shown."], 
	{
		if !(zfm_setting_toggle) exitWith {};
		DNI_showFrames = !DNI_showFrames;
	}, 
	{}, 
	[DIK_GRAVE, [false, true, false]]  // Ctrl only
] call CBA_fnc_addKeybind;
