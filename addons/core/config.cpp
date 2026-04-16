#include "script_component.hpp"

class CfgPatches {
	class ADDON {

        // Meta information for editor
		name = ADDON_NAME;

        author = "$STR_aet_zfm_author";
        authors[] = {"Nomas / Redwan S. [AET]", "DriftingNitro", "Nero", "Phenosi", "The VII Legion: Imperial Fists' Developers"};
        
        url = "$STR_github_aet_zfm_URL";

		VERSION_CONFIG;

        // Addon Specific Information
        // Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
        requiredVersion = 2.06;

        // Required addons, used for setting load order.
        // When any of the addons is missing, pop-up warning will appear when launching the game.
        requiredAddons[] = {QPVAR(main),"cba_main"};

		// Optional. If this is 1, if any of requiredAddons[] entry is missing in your game the entire config will be ignored and return no error (but in rpt) so useful to make a compat Mod (Since Arma 3 2.14)
		skipWhenMissingDependencies = 1;
        
        // List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups)
        units[] = {};

        // List of weapons (CfgWeapons classes) contained in the addon.
        weapons[] = {};

	};
};

#include "CfgFunctions.hpp"
#include "XEH\CfgXEH.hpp"

class CfgNotifications
{
	class Default
	{
		title="";
		iconPicture="";
		iconText="";
		description="";
		color[]={1,1,1,1};
		duration=5;
		priority=0;
		difficulty[]={};
	};
	class GVAR(DesyncMild)
	{
		title="MILD DESYNC";
		iconPicture="\A3\ui_f\data\gui\rsc\rscpendinginvitation\desynclow_ca.paa";
		description="%1";
		color[]={1,0.85000002,0,1};
		duration=5;
		priority=6;
	};
	class GVAR(DesyncSevere)
	{
		title="SEVERE DESYNC";
		iconPicture="\A3\ui_f\data\gui\rsc\rscpendinginvitation\desynchigh_ca.paa";
		description="%1";
		color[]={1,0,0,1};
		duration=6;
		priority=9;
	};
	class GVAR(DesyncResolved)
	{
		title="CONNECTION STABLE";
		iconPicture="\A3\ui_f\data\igui\rsctitles\rschvtphase\jac_a3_signal_4_ca.paa";
		description="%1";
		color[]={0,1,0.30000001,1};
		duration=4;
		priority=4;
	};
};
