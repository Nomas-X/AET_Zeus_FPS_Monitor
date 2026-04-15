#include "../script_component.hpp"

/*
Authors:
	Redwan S / Nomas

Description:
    This function is used to initialize the loadout handling after CBA setting initialization if the CBA settings allows it.

Arguments:
	N/A

Return Value:
	<Nil>

Example:
	[] call AET_ZFM_core_fnc_postInit;
*/

private _code = {

	private _serverHasFunctions = missionNamespace getVariable [QGVAR(serverHasFunctions), false];

	if (!_serverHasFunctions) then {
		missionNamespace setVariable [QGVAR(serverHasFunctions), true, true];
		publicVariableServer QFUNC(handleDataServer);
		publicVariableServer QFUNC(registerZeus);
		publicVariableServer QFUNC(unregisterZeus);
		publicVariableServer QFUNC(startClientStatMonitor);

		[] remoteExec [QFUNC(handleDataServer) ,2, false];
		diag_log format ["%1 ran by Server", QFUNC(postInit)];
	};

	if (hasInterface) then {
		diag_log format ["%1 ran by %2 | %3", QFUNC(postInit), getPlayerUID player, name player];


		["featureCamera", {
			private _inZeus = !isNull findDisplay 312;
			if (_inZeus) then {
				// Zeus opened - add this client to the zeus list on the server
				[player] remoteExec [QFUNC(registerZeus), 2, false];

			} else {
				// Zeus closed - remove this client from the zeus list on the server
				[player] remoteExec [QFUNC(unregisterZeus), 2, false];
			};
		}] call CBA_fnc_addPlayerEventHandler;

		[
			{!isNull (findDisplay 312)},
			{
				[] call FUNC(displayMonitor);
			}
		] call CBA_fnc_waitUntilAndExecute
	};
};

if (missionNamespace getVariable ["cba_settings_ready",false]) then _code else { ["CBA_settingsInitialized",_code,[]] call CBA_fnc_addEventHandler; };
