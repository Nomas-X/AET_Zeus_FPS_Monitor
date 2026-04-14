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
	{
		{
			if (!isNull _x) then {
				GVAR(PlayersDataMap) set [getPlayerUID _x, _x getVariable [QGVAR(playerData), [-1, -1, -1, -1]]];
			};
		} forEach allPlayers;

		{
			(owner _x) publicVariableClient QGVAR(PlayersDataMap);
			diag_log format ["%1 data sent to %2 | %3", QFUNC(handleDataServer), getPlayerUID _x, name _x];

		} forEach GVAR(zeusList);
	},
	1,
	[]
] call CBA_fnc_addPerFrameHandler;
