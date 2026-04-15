#include "../script_component.hpp"

/*
Authors:
	Redwan S / Nomas

Description:
    This function is used to handle the data received from each client then handles its forwarding to the Zeus clients, as well as keeping the Zeus List in check incase of a player disconnect.

Arguments:
	N/A

Return Value:
	<Nil>

Example:
	[] call AET_ZFM_core_fnc_handleDataServer;
*/

GVAR(zeusList) = [];

addMissionEventHandler ["OnUserClientStateChanged", {
	params ["_networkId", "_clientStateNumber", "_clientState"];

    // Give the JIP client a moment to finish loading before pushing the function
	if (_clientStateNumber > 8) then {
		private _owner = getUserInfo _networkId;
		_owner = _owner#1;

		_owner publicVariableClient QFUNC(startClientStatMonitor);
	    [] remoteExec [QFUNC(startClientStatMonitor), _owner, false];
	};
}];

addMissionEventHandler ["PlayerDisconnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

	{
		if (!isPlayer _x) then {
			GVAR(zeusList) = GVAR(zeusList) - [_x];
			diag_log format ["%1 player disconnected and removed from Zeus list %2 | %3", QFUNC(handleDataServer), _uid, _name];
		};
	} forEach GVAR(zeusList);
}];

GVAR(PlayersDataMap) = createHashMap;


[
	{GVAR(zeusList) isNotEqualTo []},
	{
		{
			// Only remoteExec to players
			if (!isNull _x) then {
				_owner publicVariableClient QFUNC(startClientStatMonitor);
				[] remoteExec [QFUNC(startClientStatMonitor), _x, false];
			};
		} forEach allPlayers;
	}
] call CBA_fnc_waitUntilAndExecute;

if (isMultiplayer) then {
	[
		{
			{
				if (!isNull _x) then {
					private _networkData = [-1,-1,-1];
					private _fps = _x getVariable [QGVAR(playerFPS), -1];
					if (isMultiplayer) then {
						_networkData = (getUserInfo (getPlayerID _x));
					};
					if (_networkData isNotEqualTo []) then {
						_networkData = _networkData # 9;
					} else {
						_networkData = [-1, -1, -1];
					};
					GVAR(PlayersDataMap) set [getPlayerUID _x, [_fps, _networkData#0, _networkData#2]];
				};
			} forEach allPlayers;

			{
				(owner _x) publicVariableClient QGVAR(PlayersDataMap);
			} forEach GVAR(zeusList);
		},
		1,
		[]
	] call CBA_fnc_addPerFrameHandler;
};
