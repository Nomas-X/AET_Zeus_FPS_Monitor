#include "../script_component.hpp"

ZFM_ScriptHandle = [] execVM QPATHTOF(script_fps.sqf);

0 spawn {
	waitUntil {!isNull (findDisplay 46)};
	uiSleep 1;
	/*
		ZFM_DesyncAlertSystem_activated = false;

		ZFM_AlertSystem = [
			{
				// if (!DNI_showFrames) exitWith {};
				if (!zfm_DesyncAlertSytem_toggle) exitWith {};

				private _desync = player getVariable ["DNI_desync", -1];

				if ((_desync isNotEqualTo -1) and { _desync >= 2000 }) then {
					if (_desync >= 19999) then {
						["ZFM_DesyncSevere", ["Severe desync detected! Expect major lag and rubberbanding,"]] call BIS_fnc_showNotification;
						ZFM_DesyncAlertSystem_activated = true;
					} else {
						["ZFM_DesyncMild", ["Mild desync detected. Connection may be unstable."]] call BIS_fnc_showNotification;
						ZFM_DesyncAlertSystem_activated = true;
					};
				};

				if ((missionNamespace getVariable ['ZFM_DesyncAlertSystem_activated', false]) and ((_desync isNotEqualTo -1) and { _desync <= 1999 })) then {
					["ZFM_DesyncResolved", ["Previous desync has ended. Connection appears stable."]] call BIS_fnc_showNotification;
					ZFM_DesyncAlertSystem_activated = false;
				};
			},
			10 // Check interval: (5 second popups + 5 second rest period)
		] call CBA_fnc_addPerFrameHandler;
	*/

	/////////////////////////////////////////////////////////
	//Spawns a thread that will loop for each player and   //
	//output their FPS to the server to be read by the zeus//
	/////////////////////////////////////////////////////////

	/////////////////////////////////////////////////////////
	//Add onPlayerConnected event handler remotely to server/
	//to spawn the FPS setter to the client that joined    //
	/////////////////////////////////////////////////////////

	DNI_fnc_startClientStatMonitor = {
		if (!hasInterface || isDedicated) exitWith {};
		if (!isNil "DNI_FPSDiag_Initialized") exitWith {};

		DNI_FPSDiag_Initialized = true;

		if ((hasInterface) && (!isDedicated)) then {
			DNI_ZeusFPSMonitor_Updated = [{
				if ((!hasInterface) || (isDedicated)) exitWith {};
				if (!ZFM_ModToggle) exitWith {};

				if ((isNil "DNI_FPSDiagActive") || { (DNI_FPSDiagActive) }) then {
					DNI_FPSDiagActive = true;

					// --- Local cache variables (define only once)
					// if (isNil "DNI_lastFPS") then { DNI_lastFPS = -1; };
					// if (isNil "DNI_lastPing") then { DNI_lastPing = -1; };
					// if (isNil "DNI_lastBW") then { DNI_lastBW = -1; };
					// if (isNil "DNI_lastDesync") then { DNI_lastDesync = -1; };

					// --- FPS update
					private _fps = floor diag_fps;
					// if (_fps != DNI_lastFPS) then {
					// 	DNI_lastFPS = _fps;
					// 	player setVariable ["DNI_PlayerFPS", _fps, true];
					// };

					if (isMultiplayer) then {
						// private _userInfo = getUserInfo (getPlayerID player);
						// _userInfo params ["_playerID", "_ownerId", "_playerUID", "_profileName", "_displayName", "_steamName", "_clientState", "_isHC", "_adminState", ["_networkInfo", [-1,-1,-1]], ["_unit", player]];
						// _networkInfo params [["_avgPing", -1], ["_avgBandwidth", -1], ["_desync", -1]];

						// if (_avgPing != DNI_lastPing) then {
						// 	DNI_lastPing = _avgPing;
						// 	player setVariable ["DNI_avgPing", _avgPing, true];
						// };
						// if (_avgBandwidth != DNI_lastBW) then {
						// 	DNI_lastBW = _avgBandwidth;
						// 	player setVariable ["DNI_avgBandwidth", _avgBandwidth, true];
						// };
						// if (_desync != DNI_lastDesync) then {
						// 	DNI_lastDesync = _desync;
						// 	player setVariable ["DNI_desync", _desync, true];
						// };
					};
					player setVariable [QGVAR(playerFPS), _fps, 2];
					diag_log format ["%1 data sent to server by %2 | %3", QFUNC(initFPS), getPlayerUID player, name player];
				};
			}, 1, []] call CBA_fnc_addPerFrameHandler;
		};
	};

	publicVariableServer "DNI_fnc_startClientStatMonitor";

	{
		// Only remoteExec to players
		if (!isNull _x) then {
			[] remoteExec ["DNI_fnc_startClientStatMonitor", _x, false];
		};
	} forEach allPlayers;
};
