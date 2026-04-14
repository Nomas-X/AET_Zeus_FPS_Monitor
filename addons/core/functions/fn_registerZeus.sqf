#include "../script_component.hpp"

/*
Authors:
	Redwan S / Nomas

Description:
    This function is used to register / add a Zeus to the list of clients to receive the FPS data of all other clients from the server.

Arguments:
	1. <Object> The player object that will be added

Return Value:
	<Nil>

Example:
	[] call AET_ZFM_core_fnc_registerZeus;
*/

params ["_player"];

GVAR(zeusList) pushBackUnique _player;
