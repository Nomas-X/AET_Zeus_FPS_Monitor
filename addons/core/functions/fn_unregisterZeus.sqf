#include "../script_component.hpp"

/*
Authors:
	Redwan S / Nomas

Description:
    This function is used to unregister / remove a Zeus to the list of clients to receive the FPS data of all other clients from the server.

Arguments:
	1. <Object> The player object that will be removed

Return Value:
	<Nil>

Example:
	[] call AET_ZFM_core_fnc_unregisterZeus;
*/

params ["_player"];

GVAR(zeusList) = GVAR(zeusList) - [_player];
