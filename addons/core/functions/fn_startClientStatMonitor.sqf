#include "../script_component.hpp"

/*
Authors:
	DriftingNitro
	Redwan S / Nomas

Description:
    This function is used to to display the FPS monitor icons / UI while in Zeus.

Arguments:
	N/A

Return Value:
	<Nil>

Example:
	[] call AET_ZFM_core_fnc_startClientStatMonitor;
*/

if (!hasInterface || isDedicated) exitWith {};
if (!isNil QGVAR(FPSDiag_Initialized)) exitWith {};

GVAR(FPSDiag_Initialized) = true;

if ((hasInterface) && (!isDedicated)) then {
	GVAR(ZeusFPSMonitor_Updated) = [{
		if ((!hasInterface) || (isDedicated)) exitWith {};
		if (!GVAR(ModToggle)) exitWith {};

		if ((isNil QGVAR(FPSDiagActive)) || { (GVAR(FPSDiagActive)) }) then {
			GVAR(FPSDiagActive) = true;

			private _fps = floor diag_fps;
			
			player setVariable [QGVAR(playerFPS), _fps, 2];
			diag_log format ["%1 data sent to server by %2 | %3", QFUNC(initFPS), getPlayerUID player, name player];
		};
	}, 1, []] call CBA_fnc_addPerFrameHandler;
};
