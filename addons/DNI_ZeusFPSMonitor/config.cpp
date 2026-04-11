class CfgPatches
{
	class DNI_ZeusFPSMonitor
	{
		units[]={};
		weapons[]={};
		requiredVersion=1;
		author="DriftingNitro / Nero / Phenosi / 'The VII Legion: Imperial Fists' Developers";
		requiredAddons[]=
		{
			"A3_Modules_F",
			"cba_main"
		};
	};
};
class CfgFunctions
{
	class DNI
	{
		class startup
		{
			file="\DNI_ZeusFPSMonitor\functions";
			class initFPS
			{
				postInit=1;
			};
		};
	};
};
class Extended_PreInit_EventHandlers
{
	class ZFM_EH
	{
		init="call compile preprocessFileLineNumbers 'DNI_ZeusFPSMonitor\XEH_preInit.sqf'";
	};
};
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
	class ZFM_DesyncMild
	{
		title="MILD DESYNC";
		iconPicture="\A3\ui_f\data\gui\rsc\rscpendinginvitation\desynclow_ca.paa";
		description="%1";
		color[]={1,0.85000002,0,1};
		duration=5;
		priority=6;
	};
	class ZFM_DesyncSevere
	{
		title="SEVERE DESYNC";
		iconPicture="\A3\ui_f\data\gui\rsc\rscpendinginvitation\desynchigh_ca.paa";
		description="%1";
		color[]={1,0,0,1};
		duration=6;
		priority=9;
	};
	class ZFM_DesyncResolved
	{
		title="CONNECTION STABLE";
		iconPicture="\A3\ui_f\data\igui\rsctitles\rschvtphase\jac_a3_signal_4_ca.paa";
		description="%1";
		color[]={0,1,0.30000001,1};
		duration=4;
		priority=4;
	};
};
class cfgMods
{
	author="Phenosi";
	timepacked="1752183380";
};
