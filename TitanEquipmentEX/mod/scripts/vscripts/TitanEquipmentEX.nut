untyped

global function TitanEquipmentEX;

global function coolswordatk
global function cooltimer
global function spcoolswordatk


global function Applysomepassive
const string FLAME_WAVE_LEFT_SFX = "flamewave_blast_left"
const string FLAME_WAVE_MIDDLE_SFX = "flamewave_blast_middle"
const string FLAME_WAVE_RIGHT_SFX = "flamewave_blast_right"

global const TITAN_EXPLOSION_GROUNDWASH_FX_TABLE = "titan_exp_ground"

const asset BEAM1 = $"hol_beam_CH_laser"
const BEAM2	= $"wpn_arc_cannon_beam"
const BEAM3	= $"P_wpn_charge_tool_beam"
const BEAM4	= $"P_wpn_lasercannon_aim"
global int TITAN_EXPLOSION_EFFECT

global array<int> allpassive = [
    ePassives.PAS_NORTHSTAR_WEAPON,
    ePassives.PAS_NORTHSTAR_CLUSTER,
    ePassives.PAS_NORTHSTAR_TRAP,
    ePassives.PAS_NORTHSTAR_FLIGHTCORE,
    ePassives.PAS_NORTHSTAR_OPTICS,

    ePassives.PAS_VANGUARD_COREMETER,
    ePassives.PAS_VANGUARD_SHIELD,
    ePassives.PAS_VANGUARD_REARM,
    ePassives.PAS_VANGUARD_DOOM,



    ePassives.PAS_SCORCH_WEAPON,
    ePassives.PAS_SCORCH_FIREWALL,
    ePassives.PAS_SCORCH_SHIELD,
    ePassives.PAS_SCORCH_SELFDMG,
    ePassives.PAS_SCORCH_FLAMECORE,

    ePassives.PAS_ION_WEAPON,
    ePassives.PAS_ION_TRIPWIRE,
    ePassives.PAS_ION_VORTEX,
    ePassives.PAS_ION_LASERCANNON,
    ePassives.PAS_ION_WEAPON_ADS,

    ePassives.PAS_RONIN_WEAPON,
    ePassives.PAS_RONIN_ARCWAVE,
    ePassives.PAS_RONIN_PHASE,
    ePassives.PAS_RONIN_SWORDCORE,
    ePassives.PAS_RONIN_AUTOSHIFT,

    ePassives.PAS_TONE_WEAPON,
    ePassives.PAS_TONE_ROCKETS,
    ePassives.PAS_TONE_SONAR,
    ePassives.PAS_TONE_WALL,
    ePassives.PAS_TONE_BURST,

    ePassives.PAS_LEGION_CHARGESHOT,
    ePassives.PAS_LEGION_GUNSHIELD,
    ePassives.PAS_LEGION_SMARTCORE,
    ePassives.PAS_LEGION_SPINUP,
    ePassives.PAS_LEGION_WEAPON

]


global table< int , int > passivetable = {

	[ePassives.PAS_NORTHSTAR_WEAPON] 		= 0,
    [ePassives.PAS_NORTHSTAR_CLUSTER]		= 0,
    [ePassives.PAS_NORTHSTAR_TRAP]		   = 0,
    [ePassives.PAS_NORTHSTAR_FLIGHTCORE]	= 0,
    [ePassives.PAS_NORTHSTAR_OPTICS]		= 0,

    [ePassives.PAS_VANGUARD_COREMETER]		= 0,
    [ePassives.PAS_VANGUARD_SHIELD]		   = 0,
    [ePassives.PAS_VANGUARD_REARM]		   = 0,
    [ePassives.PAS_VANGUARD_DOOM]		   = 0,

    [ePassives.PAS_VANGUARD_CORE1]		   = 0,
    [ePassives.PAS_VANGUARD_CORE2]		   = 0,
    [ePassives.PAS_VANGUARD_CORE3]		  	= 0,
    [ePassives.PAS_VANGUARD_CORE4]		   = 0,
    [ePassives.PAS_VANGUARD_CORE5]		  	= 0,
    [ePassives.PAS_VANGUARD_CORE6]		   = 0,
    [ePassives.PAS_VANGUARD_CORE7]		   = 0,
    [ePassives.PAS_VANGUARD_CORE8]		   	= 0,
    [ePassives.PAS_VANGUARD_CORE9]		   	= 0,



    [ePassives.PAS_SCORCH_WEAPON]		   = 0,
    [ePassives.PAS_SCORCH_FIREWALL]		   = 0,
    [ePassives.PAS_SCORCH_SHIELD]		   = 0,
    [ePassives.PAS_SCORCH_SELFDMG]		   = 0,
    [ePassives.PAS_SCORCH_FLAMECORE]		= 0,

    [ePassives.PAS_ION_WEAPON]		       = 0,
    [ePassives.PAS_ION_TRIPWIRE]	     	= 0,
    [ePassives.PAS_ION_VORTEX]		       = 0,
    [ePassives.PAS_ION_LASERCANNON]	    	= 0,
    [ePassives.PAS_ION_WEAPON_ADS]	    	= 0,

    [ePassives.PAS_RONIN_WEAPON]	    	= 0,
    [ePassives.PAS_RONIN_ARCWAVE]	    	= 0,
    [ePassives.PAS_RONIN_PHASE]		       = 0,
    [ePassives.PAS_RONIN_SWORDCORE]	    	= 0,
    [ePassives.PAS_RONIN_AUTOSHIFT]	    	= 0,

    [ePassives.PAS_TONE_WEAPON]	        	= 0,
    [ePassives.PAS_TONE_ROCKETS]	    	= 0,
    [ePassives.PAS_TONE_SONAR]	        	= 0,
    [ePassives.PAS_TONE_WALL]		       = 0,
    [ePassives.PAS_TONE_BURST]		       = 0,

    [ePassives.PAS_LEGION_CHARGESHOT]		= 0,
    [ePassives.PAS_LEGION_GUNSHIELD]		= 0,
    [ePassives.PAS_LEGION_SMARTCORE]		= 0,
    [ePassives.PAS_LEGION_SPINUP]	    	= 0,
    [ePassives.PAS_LEGION_WEAPON]		   = 0,


}

global table< int , int > passivetableglobal = {

	[ePassives.PAS_NORTHSTAR_WEAPON] 		= 0,
    [ePassives.PAS_NORTHSTAR_CLUSTER]		= 0,
    [ePassives.PAS_NORTHSTAR_TRAP]		   = 0,
    [ePassives.PAS_NORTHSTAR_FLIGHTCORE]	= 0,
    [ePassives.PAS_NORTHSTAR_OPTICS]		= 0,

    [ePassives.PAS_VANGUARD_COREMETER]		= 0,
    [ePassives.PAS_VANGUARD_SHIELD]		   = 0,
    [ePassives.PAS_VANGUARD_REARM]		   = 0,
    [ePassives.PAS_VANGUARD_DOOM]		   = 0,

    [ePassives.PAS_VANGUARD_CORE1]		   = 0,
    [ePassives.PAS_VANGUARD_CORE2]		   = 0,
    [ePassives.PAS_VANGUARD_CORE3]		  	= 0,
    [ePassives.PAS_VANGUARD_CORE4]		   = 0,
    [ePassives.PAS_VANGUARD_CORE5]		  	= 0,
    [ePassives.PAS_VANGUARD_CORE6]		   = 0,
    [ePassives.PAS_VANGUARD_CORE7]		   = 0,
    [ePassives.PAS_VANGUARD_CORE8]		   	= 0,
    [ePassives.PAS_VANGUARD_CORE9]		   	= 0,



    [ePassives.PAS_SCORCH_WEAPON]		   = 0,
    [ePassives.PAS_SCORCH_FIREWALL]		   = 0,
    [ePassives.PAS_SCORCH_SHIELD]		   = 0,
    [ePassives.PAS_SCORCH_SELFDMG]		   = 0,
    [ePassives.PAS_SCORCH_FLAMECORE]		= 0,

    [ePassives.PAS_ION_WEAPON]		       = 0,
    [ePassives.PAS_ION_TRIPWIRE]	     	= 0,
    [ePassives.PAS_ION_VORTEX]		       = 0,
    [ePassives.PAS_ION_LASERCANNON]	    	= 0,
    [ePassives.PAS_ION_WEAPON_ADS]	    	= 0,

    [ePassives.PAS_RONIN_WEAPON]	    	= 0,
    [ePassives.PAS_RONIN_ARCWAVE]	    	= 0,
    [ePassives.PAS_RONIN_PHASE]		       = 0,
    [ePassives.PAS_RONIN_SWORDCORE]	    	= 0,
    [ePassives.PAS_RONIN_AUTOSHIFT]	    	= 0,

    [ePassives.PAS_TONE_WEAPON]	        	= 0,
    [ePassives.PAS_TONE_ROCKETS]	    	= 0,
    [ePassives.PAS_TONE_SONAR]	        	= 0,
    [ePassives.PAS_TONE_WALL]		       = 0,
    [ePassives.PAS_TONE_BURST]		       = 0,

    [ePassives.PAS_LEGION_CHARGESHOT]		= 0,
    [ePassives.PAS_LEGION_GUNSHIELD]		= 0,
    [ePassives.PAS_LEGION_SMARTCORE]		= 0,
    [ePassives.PAS_LEGION_SPINUP]	    	= 0,
    [ePassives.PAS_LEGION_WEAPON]		   = 0,


}

global table< int , string >Passivesnames = {
	[ePassives.PAS_NORTHSTAR_WEAPON] 		= "Northstar---Piercing Shot",
    [ePassives.PAS_NORTHSTAR_CLUSTER]		= "Northstar---Enhanced Payload",
    [ePassives.PAS_NORTHSTAR_TRAP]		    = "Northstar---Dual Tether Traps",
    [ePassives.PAS_NORTHSTAR_FLIGHTCORE]	= "Northstar---Viper Thrusters",
    [ePassives.PAS_NORTHSTAR_OPTICS]		= "Northstar---Threat Optics",

    [ePassives.PAS_VANGUARD_COREMETER]		= "Monarch---Energy Thief",
    [ePassives.PAS_VANGUARD_SHIELD]		    = "Monarch---Shield Amplifier",
    [ePassives.PAS_VANGUARD_REARM]		    = "Monarch---Rapid Rearm",
    [ePassives.PAS_VANGUARD_DOOM]		    = "Monarch---Survival of the Fittest",

    [ePassives.PAS_VANGUARD_CORE1]		    = "Monarch---Arc Rounds",
    [ePassives.PAS_VANGUARD_CORE2]		    = "Monarch---Missile Racks",
    [ePassives.PAS_VANGUARD_CORE3]		    = "Monarch---Energy Transfer",
    [ePassives.PAS_VANGUARD_CORE4]		    = "Monarch---Rapid Rearm",
    [ePassives.PAS_VANGUARD_CORE5]		    = "Monarch---Vortex Shield",
    [ePassives.PAS_VANGUARD_CORE6]		    = "Monarch---Energy Field",
    [ePassives.PAS_VANGUARD_CORE7]		    = "Monarch---Multi-Target Missiles",
    [ePassives.PAS_VANGUARD_CORE8]		    = "Monarch---Superior Chassis",
    [ePassives.PAS_VANGUARD_CORE9]		    = "Monarch---XO-16 Accelerator",

    [ePassives.PAS_SCORCH_WEAPON]		    = "Scorch---Wildfire Launcher",
    [ePassives.PAS_SCORCH_FIREWALL]		    = "Scorch---Inferno Shield",
    [ePassives.PAS_SCORCH_SHIELD]		    = "Scorch---Flame Shield",
    [ePassives.PAS_SCORCH_SELFDMG]		    = "Scorch---Tempered Plating",
    [ePassives.PAS_SCORCH_FLAMECORE]		= "Scorch---Flame Core",

    [ePassives.PAS_ION_WEAPON]		        = "Ion---Entangled Energy",
    [ePassives.PAS_ION_TRIPWIRE]	    	= "Ion---Zero-Point Tripwire",
    [ePassives.PAS_ION_VORTEX]		        = "Ion---Vortex Amplifier",
    [ePassives.PAS_ION_LASERCANNON]	    	= "Ion---Grand Cannon",
    [ePassives.PAS_ION_WEAPON_ADS]	    	= "Ion---Refraction Lens",

    [ePassives.PAS_RONIN_WEAPON]	    	= "Ronin---Ricochet Rounds",
    [ePassives.PAS_RONIN_ARCWAVE]	    	= "Ronin---Thunderstorm",
    [ePassives.PAS_RONIN_PHASE]		        = "Ronin---Temporal Anomaly",
    [ePassives.PAS_RONIN_SWORDCORE]	    	= "Ronin---Highlander",
    [ePassives.PAS_RONIN_AUTOSHIFT]	    	= "Ronin---Phase Reflex",

    [ePassives.PAS_TONE_WEAPON]	        	= "Tone---Enhanced Tracker Rounds",
    [ePassives.PAS_TONE_ROCKETS]	    	= "Tone---Rocket Barrage",
    [ePassives.PAS_TONE_SONAR]	        	= "Tone---Pulse Echo",
    [ePassives.PAS_TONE_WALL]		        = "Tone---Reinforced Particle Wall",
    [ePassives.PAS_TONE_BURST]		        = "Tone---Burst Loader",

    [ePassives.PAS_LEGION_CHARGESHOT]		= "Legion---Hidden Compartment",
    [ePassives.PAS_LEGION_GUNSHIELD]		= "Legion---Bulwark",
    [ePassives.PAS_LEGION_SMARTCORE]		= "Legion---Sensor Array",
    [ePassives.PAS_LEGION_SPINUP]	    	= "Legion---Lightweight Alloys",
    [ePassives.PAS_LEGION_WEAPON]		    = "Legion---Extended Magazines"
}


global table< int , string >Passivesnamesconvar = {

	[ePassives.PAS_NORTHSTAR_WEAPON] 		= "northstar1",
    [ePassives.PAS_NORTHSTAR_CLUSTER]		= "northstar2",
    [ePassives.PAS_NORTHSTAR_TRAP]		    = "northstar3",
    [ePassives.PAS_NORTHSTAR_FLIGHTCORE]	= "northstar4",
    [ePassives.PAS_NORTHSTAR_OPTICS]		= "northstar5",

    [ePassives.PAS_VANGUARD_COREMETER]		= "vanguard1",
    [ePassives.PAS_VANGUARD_SHIELD]		    = "vanguard2",
    [ePassives.PAS_VANGUARD_REARM]		    = "vanguard3",
    [ePassives.PAS_VANGUARD_DOOM]		    = "vanguard4",

    [ePassives.PAS_SCORCH_WEAPON]		    = "scorch1",
    [ePassives.PAS_SCORCH_FIREWALL]		    = "scorch2",
    [ePassives.PAS_SCORCH_SHIELD]		    = "scorch3",
    [ePassives.PAS_SCORCH_SELFDMG]		    = "scorch4",
    [ePassives.PAS_SCORCH_FLAMECORE]		= "scorch5",

    [ePassives.PAS_ION_WEAPON]		        = "ion1",
    [ePassives.PAS_ION_TRIPWIRE]	    	= "ion2",
    [ePassives.PAS_ION_VORTEX]		        = "ion3",
    [ePassives.PAS_ION_LASERCANNON]	    	= "ion4",
    [ePassives.PAS_ION_WEAPON_ADS]	    	= "ion5",

    [ePassives.PAS_RONIN_WEAPON]	    	= "ronin1",
    [ePassives.PAS_RONIN_ARCWAVE]	    	= "ronin2",
    [ePassives.PAS_RONIN_PHASE]		        = "ronin3",
    [ePassives.PAS_RONIN_SWORDCORE]	    	= "ronin4",
    [ePassives.PAS_RONIN_AUTOSHIFT]	    	= "ronin5",

    [ePassives.PAS_TONE_WEAPON]	        	= "tone1",
    [ePassives.PAS_TONE_ROCKETS]	    	= "tone2",
    [ePassives.PAS_TONE_SONAR]	        	= "tone3",
    [ePassives.PAS_TONE_WALL]		        = "tone4",
    [ePassives.PAS_TONE_BURST]		        = "tone5",

    [ePassives.PAS_LEGION_CHARGESHOT]		= "legion1",
    [ePassives.PAS_LEGION_GUNSHIELD]		= "legion2",
    [ePassives.PAS_LEGION_SMARTCORE]		= "legion3",
    [ePassives.PAS_LEGION_SPINUP]	    	= "legion4",
    [ePassives.PAS_LEGION_WEAPON]		    = "legion5",




}
global table< string , int >pastimes = {
	["Northstar---Piercing Shot"] = 0,
    ["Northstar---Enhanced Payload"] = 0,
    ["Northstar---Dual Tether Traps"] = 0,
    ["Northstar---Viper Thrusters"] = 0,
    ["Northstar---Threat Optics"] = 0,

    ["Monarch---Energy Thief"] = 0,
    ["Monarch---Shield Amplifier"] = 0,
    ["Monarch---Rapid Rearm"] = 0,
    ["Monarch---Survival of the Fittest"] = 0,

    ["Scorch---Wildfire Launcher"] = 0,
    ["Scorch---Inferno Shield"] = 0,
    ["Scorch---Flame Shield"] = 0,
    ["Scorch---Tempered Plating"] = 0,
    ["Scorch---Flame Core"] = 0,

    ["Ion---Entangled Energy"] = 0,
    ["Ion---Zero-Point Tripwire"] = 0,
    ["Ion---Vortex Amplifier"] = 0,
    ["Ion---Grand Cannon"] = 0,
    ["Ion---Refraction Lens"] = 0,

    ["Ronin---Ricochet Rounds"] = 0,
    ["Ronin---Thunderstorm"] = 0,
    ["Ronin---Temporal Anomaly"] = 0,
    ["Ronin---Highlander"] = 0,
    ["Ronin---Phase Reflex"] = 0,

    ["Tone---Enhanced Tracker Rounds"] = 0,
    ["Tone---Rocket Barrage"] = 0,
    ["Tone---Pulse Echo"] = 0,
    ["Tone---Reinforced Particle Wall"] = 0,
    ["Tone---Burst Loader"] = 0,

    ["Legion---Hidden Compartment"] = 0,
    ["Legion---Bulwark"] = 0,
    ["Legion---Sensor Array"] = 0,
    ["Legion---Lightweight Alloys"] = 0,
    ["Legion---Extended Magazines"] = 0
}


global table< string , int >pastimesglobal = {

		["Northstar---Piercing Shot"] = 0,
    ["Northstar---Enhanced Payload"] = 0,
    ["Northstar---Dual Tether Traps"] = 0,
    ["Northstar---Viper Thrusters"] = 0,
    ["Northstar---Threat Optics"] = 0,

    ["Monarch---Energy Thief"] = 0,
    ["Monarch---Shield Amplifier"] = 0,
    ["Monarch---Rapid Rearm"] = 0,
    ["Monarch---Survival of the Fittest"] = 0,

    ["Scorch---Wildfire Launcher"] = 0,
    ["Scorch---Inferno Shield"] = 0,
    ["Scorch---Flame Shield"] = 0,
    ["Scorch---Tempered Plating"] = 0,
    ["Scorch---Flame Core"] = 0,

    ["Ion---Entangled Energy"] = 0,
    ["Ion---Zero-Point Tripwire"] = 0,
    ["Ion---Vortex Amplifier"] = 0,
    ["Ion---Grand Cannon"] = 0,
    ["Ion---Refraction Lens"] = 0,

    ["Ronin---Ricochet Rounds"] = 0,
    ["Ronin---Thunderstorm"] = 0,
    ["Ronin---Temporal Anomaly"] = 0,
    ["Ronin---Highlander"] = 0,
    ["Ronin---Phase Reflex"] = 0,

    ["Tone---Enhanced Tracker Rounds"] = 0,
    ["Tone---Rocket Barrage"] = 0,
    ["Tone---Pulse Echo"] = 0,
    ["Tone---Reinforced Particle Wall"] = 0,
    ["Tone---Burst Loader"] = 0,

    ["Legion---Hidden Compartment"] = 0,
    ["Legion---Bulwark"] = 0,
    ["Legion---Sensor Array"] = 0,
    ["Legion---Lightweight Alloys"] = 0,
    ["Legion---Extended Magazines"] = 0



}

global array<int> diwang = [
    ePassives.PAS_VANGUARD_CORE1,
    ePassives.PAS_VANGUARD_CORE2,
    ePassives.PAS_VANGUARD_CORE3,
    ePassives.PAS_VANGUARD_CORE4,
    ePassives.PAS_VANGUARD_CORE5,
    ePassives.PAS_VANGUARD_CORE6,
    ePassives.PAS_VANGUARD_CORE7,
    ePassives.PAS_VANGUARD_CORE8,
    ePassives.PAS_VANGUARD_CORE9
]


global table < int, string > passivedescriptions = {

	[ePassives.PAS_NORTHSTAR_WEAPON] 		= "\x1b[92mPiercing Shot:\x1b[0m Plasma Railgun charges instantly with reduced magazine and crit multiplier \x1b[0m",
    [ePassives.PAS_NORTHSTAR_CLUSTER]		= "\x1b[92mEnhanced Payload:\x1b[0m Cluster Missile detonates with a single high-damage explosion \x1b[0m",
    [ePassives.PAS_NORTHSTAR_TRAP]		    = "\x1b[92mDual Tether Traps:\x1b[0m Reduced cooldown with explosive detonation, but lower maximum traps \x1b[0m",
    [ePassives.PAS_NORTHSTAR_FLIGHTCORE]	= "\x1b[92mViper Thrusters:\x1b[0m Increased flight speed and damage resistance while airborne, upgrades \x1b[94m[Flight Core]\x1b[0m to \x1b[94m[Viper Flight Core] \x1b[0m",
    [ePassives.PAS_NORTHSTAR_OPTICS]		= "\x1b[92mThreat Optics:\x1b[0m Increased crit multiplier and enemy scanning while aiming \x1b[0m",

    [ePassives.PAS_VANGUARD_COREMETER]		= "\x1b[92mEnergy Thief:\x1b[0m Execute enemies below 1 bar, gain extra core charge from Energy Siphon \x1b[0m",
    [ePassives.PAS_VANGUARD_SHIELD]		    = "\x1b[92mShield Amplifier:\x1b[0m Energy Siphon restores heavy shields and steals enemy shield capacity \x1b[0m",
    [ePassives.PAS_VANGUARD_REARM]		    = "\x1b[92mRapid Rearm:\x1b[0m Reduced cooldown, replenishes ammo/shields and releases free \x1b[94m[Electric Smoke]\x1b[0m \x1b[0m",
    [ePassives.PAS_VANGUARD_DOOM]		    = "\x1b[92mSurvival of the Fittest:\x1b[0m Health regen and Doom State escape, shares effects with \x1b[94m[Energy Transfer]\x1b[0m \x1b[0m",

    [ePassives.PAS_VANGUARD_CORE1]		    = "\x1b[92mArc Rounds:\x1b[0m Increased Vortex Shield damage and magazine size \x1b[0m",
    [ePassives.PAS_VANGUARD_CORE2]		    = "\x1b[92mMissile Racks:\x1b[0m Increased rocket count and blast radius \x1b[0m",
    [ePassives.PAS_VANGUARD_CORE3]		    = "\x1b[92mEnergy Transfer:\x1b[0m Grants core charge to allies \x1b[0m",
    [ePassives.PAS_VANGUARD_CORE4]		    = "\x1b[92mRapid Rearm:\x1b[0m Faster reload and Rearm speed \x1b[0m",
    [ePassives.PAS_VANGUARD_CORE5]		    = "\x1b[92mVortex Shield:\x1b[0m Grants shields to allies \x1b[0m",
    [ePassives.PAS_VANGUARD_CORE6]		    = "\x1b[92mEnergy Field:\x1b[0m Expanded energy field radius \x1b[0m",
    [ePassives.PAS_VANGUARD_CORE7]		    = "\x1b[92mMulti-Target Missiles:\x1b[0m Increased damage and blast radius with \x1b[94m[Missile Racks]\x1b[0m \x1b[0m",
    [ePassives.PAS_VANGUARD_CORE8]		    = "\x1b[92mSuperior Chassis:\x1b[0m Heals 1 bar on upgrade, full heal with \x1b[94m[Energy Transfer]\x1b[0m \x1b[0m",
    [ePassives.PAS_VANGUARD_CORE9]		    = "\x1b[92mXO-16 Accelerator:\x1b[0m Increased damage and fire rate stacking \x1b[0m",

    [ePassives.PAS_SCORCH_WEAPON]		    = "\x1b[92mWildfire Launcher:\x1b[0m T203 shots deploy thermite traps \x1b[0m",
    [ePassives.PAS_SCORCH_FIREWALL]		    = "\x1b[92mInferno Shield:\x1b[0m Reduced Firewall cooldown, increased burn damage and slow \x1b[0m",
    [ePassives.PAS_SCORCH_SHIELD]		    = "\x1b[92mFlame Shield:\x1b[0m Melee replaced with charge attack, hold sprint for long jump \x1b[0m",
    [ePassives.PAS_SCORCH_SELFDMG]		    = "\x1b[92mTempered Plating:\x1b[0m Immune to self-damage, reduced enemy fire/explosive damage \x1b[0m",
    [ePassives.PAS_SCORCH_FLAMECORE]		= "\x1b[92mFlame Core:\x1b[0m Increased T203 capacity and Flame Core range, upgrades to \x1b[94m[Inferno Core]\x1b[0m \x1b[0m",

    [ePassives.PAS_ION_WEAPON]		        = "\x1b[92mEntangled Energy:\x1b[0m Splitter Rifle hits restore energy and increase crit \x1b[0m",
    [ePassives.PAS_ION_TRIPWIRE]	    	= "\x1b[92mZero-Point Tripwire:\x1b[0m Restores energy and deals increased damage \x1b[0m",
    [ePassives.PAS_ION_VORTEX]		        = "\x1b[92mVortex Amplifier:\x1b[0m Increased Vortex Shield range and reflected damage \x1b[0m",
    [ePassives.PAS_ION_LASERCANNON]	    	= "\x1b[92mGrand Cannon:\x1b[0m Laser Shot knockback, improved Laser Core damage/duration \x1b[0m",
    [ePassives.PAS_ION_WEAPON_ADS]	    	= "\x1b[92mRefraction Lens:\x1b[0m Splitter Rifle fires triple shots, ADS becomes \x1b[94m[Laser Piercer]\x1b[0m \x1b[0m",

    [ePassives.PAS_RONIN_WEAPON]	    	= "\x1b[92mRicochet Rounds:\x1b[0m Leadwall fires slugs, melee creates \x1b[94m[Phantom Slash]\x1b[0m \x1b[0m",
    [ePassives.PAS_RONIN_ARCWAVE]	    	= "\x1b[92mThunderstorm:\x1b[0m +1 Arc Wave charge, leaves surge zones during Sword Core \x1b[0m",
    [ePassives.PAS_RONIN_PHASE]		        = "\x1b[92mTemporal Anomaly:\x1b[0m Reduced Phase Dash cooldown with AoE damage \x1b[0m",
    [ePassives.PAS_RONIN_SWORDCORE]	    	= "\x1b[92mHighlander:\x1b[0m Sword Block boost, Arc Wave resets on kill, enables \x1b[94m[Dimensional Slash]\x1b[0m \x1b[0m",
    [ePassives.PAS_RONIN_AUTOSHIFT]	    	= "\x1b[92mPhase Reflex:\x1b[0m +50% core on survival, constant Arc Field during Sword Core \x1b[0m",

    [ePassives.PAS_TONE_WEAPON]	        	= "\x1b[92mEnhanced Tracker Rounds:\x1b[0m 40mm applies 2 locks (3 on crit), missiles can apply locks \x1b[0m",
    [ePassives.PAS_TONE_ROCKETS]	    	= "\x1b[92mRocket Barrage:\x1b[0m Increased missile count with reduced damage \x1b[0m",
    [ePassives.PAS_TONE_SONAR]	        	= "\x1b[92mPulse Echo:\x1b[0m Triple sonar pulses with damage amplification \x1b[0m",
    [ePassives.PAS_TONE_WALL]		        = "\x1b[92mReinforced Particle Wall:\x1b[0m Dome shield damages enemies, Sonar transfers shields \x1b[0m",
    [ePassives.PAS_TONE_BURST]		        = "\x1b[92mBurst Loader:\x1b[0m Increased damage/crit with 8-round magazine \x1b[0m",

    [ePassives.PAS_LEGION_CHARGESHOT]		= "\x1b[92mHidden Compartment:\x1b[0m Increased Power Shot damage \x1b[0m",
    [ePassives.PAS_LEGION_GUNSHIELD]		= "\x1b[92mBulwark:\x1b[0m Damage resistance, infinite Gun Shield HP with shield regen \x1b[0m",
    [ePassives.PAS_LEGION_SMARTCORE]		= "\x1b[92mSensor Array:\x1b[0m Ammo doubles on swap, Smart Core duration/damage boost \x1b[0m",
    [ePassives.PAS_LEGION_SPINUP]	    	= "\x1b[92mLightweight Alloys:\x1b[0m Increased fire/reload speed and mobility, weaker Gun Shield \x1b[0m",
    [ePassives.PAS_LEGION_WEAPON]		    = "\x1b[92mExtended Magazines:\x1b[0m Larger magazine with damage scaling on low ammo \x1b[0m"
}




void function TitanEquipmentEX()
{
    AddCallback_OnClientConnected( OnClientConnected )

    //AddDamageCallbackSourceID( eDamageSourceId.mp_titanability_laser_trip, lasertriphit  )
    //AddDeathCallback( "npc_titan", OnPilotDeath )
    AddDamageCallback("player" , onroninbehit)
    AddDamageCallback("player" , oncloakbehit)



    AddDeathCallback( "player", OnPilotDeath )

    AddDamageCallback("player" , onnorthstarbehit)
    AddDamageCallback("player" , onlegionhit)
    AddDamageCallback("npc_titan" , onlegionhit)
    //AddSpawnCallback( "npc_titan", titanspawn )

    //AddDamageCallback("npc_titan" , legioncorehit)
    //AddDamageCallback("player" , legioncorehit)

    AddDamageCallback("player" , scorchbehit)
    AddDamageCallback("npc_titan" , scorchbehit)
    AddDamageCallback("player" , onlegionbehit)
    AddDamageCallback("npc_titan" , onlegionbehit)

    AddDamageCallback("player" , scorchhit)
    AddDamageCallback("npc_titan" , scorchhit)
    AddDamageCallback("player" , flamecorehit)

    AddDamageCallback("player" , tonehit)
    AddDamageCallback("npc_titan" , tonehit)

    AddDamageCallback("player" , egghit)
    AddDamageCallback("npc_titan" , egghit)

    AddDamageCallback("player" , egghitsomeone)
    AddDamageCallback("npc_titan" , egghitsomeone)

    RegisterWeaponDamageSource( "swordcut", "Judement_Blade" )
    RegisterWeaponDamageSource( "swordcutburst", "Judement_Cut" )
    RegisterWeaponDamageSource( "spswordcutburst", "Judement_Cut_End" )
 
    RegisterWeaponDamageSource( "bullground", "BullHIT" )
    RegisterWeaponDamageSource( "laserliteex", "Laser_Piercer" )
    AddDamageCallbackSourceID( eDamageSourceId.swordcut , slowent  )
    PrecacheImpactEffectTable( TITAN_EXPLOSION_GROUNDWASH_FX_TABLE )

    TITAN_EXPLOSION_EFFECT = GetParticleSystemIndex( $"xo_exp_death" )
}






void function OnClientConnected( entity player )
{

    //player.s.isskill <- false
    //player.s.Selfdestorytime <- 0
    player.s.hasshoweuipment <- false
    player.s.hasdodge <- false
    player.s.hasemp <- false
    player.s.hasapplyemp <- false
    player.s.nukecount <- 0
    player.s.empcount <- 0

    player.s.cancool <- false

    player.s.hascloak <- false
    player.s.hasapplycloak <- false
    player.s.cancloak <- false
    player.s.isaiming <- false
    player.s.hasshowmessage <- false
    player.s.eggcount <- 0
    player.s.eggonline <- false
    player.s.cannotegg <- false

    player.s.cantrack <- false
    player.s.vipertarget <- null

    AddPlayerMovementEventCallback( player, ePlayerMovementEvents.DODGE, OnPlayerDodge )
    AddButtonPressedPlayerInputCallback( player, IN_DUCK, bullduck )
    AddButtonPressedPlayerInputCallback( player, IN_USE, nukeject )
    //AddButtonPressedPlayerInputCallback( player, IN_USE, coolswordatk )
    //thread givemod(player)
   /* AddButtonPressedPlayerInputCallback( player, IN_OFFHAND0, cancelshield )
    AddButtonPressedPlayerInputCallback( player, IN_OFFHAND1, cancelshield )
    AddButtonPressedPlayerInputCallback( player, IN_OFFHAND2, cancelshield )
    AddButtonPressedPlayerInputCallback( player, IN_OFFHAND3, cancelshield )
    AddButtonPressedPlayerInputCallback( player, IN_OFFHAND4, cancelshield )
    AddButtonPressedPlayerInputCallback( player, IN_ATTACK, cancelshield )
    AddPlayerPressedForwardCallback( player, bMoved )
    AddPlayerPressedBackCallback( player, bMoved )
    AddPlayerPressedLeftCallback( player, bMoved )
    AddPlayerPressedRightCallback( player, bMoved )*/

	//AddButtonPressedPlayerInputCallback( player, IN_CROUCH, Selfdestory )
	//thread Selfdestory(player)

    //AddButtonPressedPlayerInputCallback( player, IN_USE, showmessage )
    thread rebuildsniperammo(player)

    //1011054477291
    



        

    /*
    if(   ){ //|| player.GetUID() == "1014342742952"sph
       // NSDisconnectPlayer(player , "喜欢处决退,那就别进来")
       
    }*/

    if(player.GetUID() == "1016440155876" ){
    // NSDisconnectPlayer(player , "蹲起的")
    ServerCommand("kickid " + player.GetUID())
    }

    if(player.GetUID() == "1009674849626" ){
    // NSDisconnectPlayer(player , "骂人的")
    ServerCommand("kickid " + player.GetUID())
    }

}

void function showmessage(entity player)
{
    if(!player.s.hasshowmessage){
        player.s.hasshowmessage <- true

        int messagechance = RandomIntRange(1,100)

        if(messagechance <=10){
            EmitSoundOnEntityOnlyToPlayer( player, player, "UI_InGame_HalftimeText_Enter" )
            Chat_ServerPrivateMessage( player,  "\x1b[33m<尊老爱幼A>\x1b[0m:你无法对转生等级相差10以上的玩家造成伤害", false, true )
            Chat_ServerPrivateMessage( player,  "真惨，不过这个在隔壁服才生效，这里是配件服", false, true )
        }
    }
}
/*
bool function bMoved( entity player ){
    cancelshield( player )
    return true
}

void function titanspawn(entity titan){
	float duration = 8.0
	//thread CreateGenericBubbleShield( titan, titan.GetOrigin() , <0,0,0> , duration)



	thread CreateParentedBubbleShield( titan, titan.GetOrigin() , <0,0,0> , duration)


}*/

void function OnPlayerDodge(entity player)
{
    if(!IsValid(player) || !IsAlive(player))
        return

    if(player.s.hasdodge)
        return

    entity soul = player.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(SoulHasPassive(soul , ePassives.PAS_SCORCH_SHIELD)){
        //player.SetPowerRegenRateScale( 2 )
        //player.Server_SetDodgePower( 1500.0 )
        //player.s.hasdodge <- true
        thread jumpdodgeprepare(player)
    }


}

void function jumpdodgeprepare(entity player)
{
    wait 0.3
    if(IsValid(player) && IsAlive(player) &&  (player.IsInputCommandHeld(IN_DODGE))){
        thread jumpdodge(player)
    }
}

vector function GetDirectionFromInput( vector playerAngles, float xAxis, float yAxis )
{
	playerAngles.x = 0
	playerAngles.z = 0
	vector forward = AnglesToForward( playerAngles )
	vector right = AnglesToRight( playerAngles )

	vector directionVec = Vector(0,0,0)
	directionVec += right * xAxis
	directionVec += forward * yAxis

	vector directionAngles = VectorToAngles( directionVec )
	vector directionForward = AnglesToForward( directionAngles )

	return directionForward
}


void function SetPlayerVelocityFromInputbull( entity player, float scale, vector baseVel = < 0,0,0 > )
{
	vector angles = player.EyeAngles()
	float xAxis = player.GetInputAxisRight()
	float yAxis = player.GetInputAxisForward()
	vector directionForward = GetDirectionFromInput( angles, xAxis, yAxis )
	entity soul = player.GetTitanSoul()

    if(xAxis == 0 && yAxis == 0)
        player.SetVelocity(player.GetVelocity() + < 0 , 0 , 900>)
    else
        player.SetVelocity(directionForward * scale + baseVel + < 0 , 0 , 520>)


}

void function jumpdodge(entity player)
{
    wait 0.2
    if(IsValid(player) && IsAlive(player)){
        //vector lookv = Normalize(player.GetPlayerOrNPCViewVector())
        //player.SetVelocity(<lookv.x*800 , lookv.y*800 , 550 >)
        SetPlayerVelocityFromInputbull( player, 620, <0,0,200> )

        StatusEffect_AddTimed(player,eStatusEffect.stim_visual_effect ,1,1,1)

        PlayFX( FLIGHT_CORE_IMPACT_FX, player.GetOrigin() )
        array<entity> activeFX
        HoverSounds soundInfo
		soundInfo.liftoff_1p = "titan_flight_liftoff_1p"
		soundInfo.liftoff_3p = "titan_flight_liftoff_3p"
		soundInfo.hover_1p = "titan_flight_hover_1p"
		soundInfo.hover_3p = "titan_flight_hover_3p"
		soundInfo.descent_1p = "titan_flight_descent_1p"
		soundInfo.descent_3p = "titan_flight_descent_3p"
		soundInfo.landing_1p = "core_ability_land_1p"
		soundInfo.landing_3p = "core_ability_land_3p"

        OnThreadEnd(
		function() : ( activeFX, player, soundInfo )
		{
			if ( IsValid( player ) )
			{
				StopSoundOnEntity( player, soundInfo.hover_1p )
				StopSoundOnEntity( player, soundInfo.hover_3p )
				player.SetGroundFrictionScale( 1 )
				if ( player.IsPlayer() )
				{
					player.Server_TurnDodgeDisabledOff()
					player.kv.airSpeed = player.GetPlayerSettingsField( "airSpeed" )
					player.kv.airAcceleration = player.GetPlayerSettingsField( "airAcceleration" )
					player.kv.gravity = player.GetPlayerSettingsField( "gravityScale" )
					if ( player.IsOnGround() )
					{
						EmitSoundOnEntityOnlyToPlayer( player, player, soundInfo.landing_1p )
						EmitSoundOnEntityExceptToPlayer( player, player, soundInfo.landing_3p )
					}
				}
				else
				{
					if ( player.IsOnGround() )
						EmitSoundOnEntity( player, soundInfo.landing_3p )
				}
			}

			foreach ( fx in activeFX )
			{
				if ( IsValid( fx ) )
					fx.Destroy()
			}
		}
	)

        if ( player.LookupAttachment( "FX_L_BOT_THRUST" ) != 0 ) // BT doesn't have this attachment
        {
            activeFX.append( StartParticleEffectOnEntity_ReturnEntity( player, GetParticleSystemIndex( $"P_xo_jet_fly_large" ), FX_PATTACH_POINT_FOLLOW, player.LookupAttachment( "FX_L_BOT_THRUST" ) ) )
            activeFX.append( StartParticleEffectOnEntity_ReturnEntity( player, GetParticleSystemIndex( $"P_xo_jet_fly_large" ), FX_PATTACH_POINT_FOLLOW, player.LookupAttachment( "FX_R_BOT_THRUST" ) ) )
            activeFX.append( StartParticleEffectOnEntity_ReturnEntity( player, GetParticleSystemIndex( $"P_xo_jet_fly_small" ), FX_PATTACH_POINT_FOLLOW, player.LookupAttachment( "FX_L_TOP_THRUST" ) ) )
            activeFX.append( StartParticleEffectOnEntity_ReturnEntity( player, GetParticleSystemIndex( $"P_xo_jet_fly_small" ), FX_PATTACH_POINT_FOLLOW, player.LookupAttachment( "FX_R_TOP_THRUST" ) ) )
        }
        EmitSoundOnEntityOnlyToPlayer( player, player,  soundInfo.liftoff_1p )
	    EmitSoundOnEntityExceptToPlayer( player, player, soundInfo.liftoff_3p )
	    EmitSoundOnEntityOnlyToPlayer( player, player,  soundInfo.hover_1p )
	    EmitSoundOnEntityExceptToPlayer( player, player, soundInfo.hover_3p )
    }
}


void function bullduck(entity player )
{
    if(!IsValid(player) || !IsAlive(player))
        return

    entity soul = player.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!SoulHasPassive(soul , ePassives.PAS_SCORCH_SHIELD))
        return

    entity offhandG = player.GetOffhandWeapon(OFFHAND_TITAN_CENTER)
    if(!IsValid(offhandG))
        return

    if(player.GetVelocity().z <= -1000)
        return

    if(player.IsOnGround())
        return


        //offhandG.SetWeaponPrimaryClipCount(offhandG.GetWeaponPrimaryClipCount() - 45)
        player.SetVelocity(player.GetVelocity() - <0,0,1400>)
        thread waitbullhitthread( player )




}

void function waitbullhitthread(entity player )
{
    WaitFrame()
    if(IsValid(player) && IsAlive(player) && player.IsInputCommandHeld(IN_DUCK)){

        vector traceend = TraceLine(player.GetOrigin(),player.GetOrigin() - <0,0,2000>,player, TRACE_MASK_SHOT  , TRACE_COLLISION_GROUP_NONE).endPos
        float distanceh =  player.GetOrigin().z - traceend.z
        thread bullhitthread(player ,  abs(int(distanceh)))
    }

}

void function bullhitthread(entity player , int addrange)
{
    for(int bulltime = 0 ; bulltime <= 70 ; bulltime++){
        if(!IsValid(player) || !IsAlive(player) || Isfeetsomeone(player) || bulltime == 70){
            vector playerpos = player.GetOrigin()
            CreateShake( playerpos + <0,0,50>, 30 , 12 , 0.5, 800 )
            //EmitSoundAtPosition( TEAM_UNASSIGNED, playerpos, "incendiary_trap_explode_large" )
            //PlayFX(  $"P_sup_spectre_death" ,  playerpos + <0,0,50>)

            Explosion(
            playerpos - <0,0,50>,
            player,
            player,
            500,
            1000 + addrange,
            600 + addrange ,
            800 + addrange ,
            SF_ENVEXPLOSION_NOSOUND_FOR_ALLIES | SF_ENVEXPLOSION_NO_DAMAGEOWNER,
            playerpos,
            1000,
            damageTypes.explosive,
            eDamageSourceId.bullground,
            TITAN_EXPLOSION_GROUNDWASH_FX_TABLE)

            //DeploySlowTrap(player , true)



            break
        }


        WaitFrame()
    }

}

bool function Isfeetsomeone(entity player)
{
    if(IsValid(player) && IsAlive(player)){
        vector traceend = TraceLine(player.GetOrigin(),player.GetOrigin() - <0,0,2000>,player, TRACE_MASK_SHOT  , TRACE_COLLISION_GROUP_NONE).endPos
        float distanceh =  player.GetOrigin().z - traceend.z
        if(distanceh <= 80)
            return true

    }
    return false
}

void function flamecorehit(entity player , var damageInfo)
{
    entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!player.IsPlayer())
        return

    if(!attacker.IsPlayer())
        return

    if(attacker != player)
        return
    entity soul = attacker.GetTitanSoul()
    if(!IsValid(soul))
        return

    if((DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave_secondary) && SoulHasPassive( soul , ePassives.PAS_SCORCH_FLAMECORE ))
        DamageInfo_ScaleDamage(damageInfo , 0)

}

void function onlegionbehit(entity hitent , var damageInfo)
{

    //entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!hitent.IsPlayer())
        return

    entity soul = hitent.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!SoulHasPassive(soul , ePassives.PAS_LEGION_GUNSHIELD))
        return

        DamageInfo_ScaleDamage(damageInfo , 0.9)

}

void function scorchbehit(entity hitent , var damageInfo)
{

    entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!IsValid(attacker))
        return

    if(!hitent.IsPlayer())
        return

    entity soul = hitent.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!SoulHasPassive(soul , ePassives.PAS_SCORCH_SELFDMG))
        return

    if(attacker == hitent){
        if(DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave_secondary || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_flame_wall || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanability_slow_trap || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_meteor|| DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_meteor_thermite || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_heat_shield)
        {
            float hitdamage = DamageInfo_GetDamage(damageInfo)
            DamageInfo_SetDamage(damageInfo , 0)
            hitent.SetHealth(minint((hitent.GetHealth()+ int(hitdamage/2.0)) , hitent.GetMaxHealth()))
        }
    }
    else{
        if(DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave_secondary || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_flame_wall || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanability_slow_trap || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_meteor|| DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_meteor_thermite || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_heat_shield)
        {

            DamageInfo_ScaleDamage(damageInfo , 0.2)

        }
        else if( DamageInfo_GetCustomDamageType( damageInfo ) & ( DF_EXPLOSION) ){

            DamageInfo_ScaleDamage(damageInfo , 0.5)

        }

    }

}




void function onlegionhit(entity hitent , var damageInfo)
{
    entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!attacker.IsPlayer())
        return

    entity soul = attacker.GetTitanSoul()
    if(!IsValid(soul))
        return



    array<entity> mains = attacker.GetMainWeapons()
    if(mains.len() == 0)
        return

    entity maingun = attacker.GetMainWeapons()[0]
    if(!IsValid(maingun))
        return

    if(SoulHasPassive(soul , ePassives.PAS_LEGION_WEAPON)){
        float damageup = 1.6 - 0.6*(float(maingun.GetWeaponPrimaryClipCount())/float(maingun.GetWeaponPrimaryClipCountMax()))
        DamageInfo_ScaleDamage(damageInfo , damageup)
    }
    else if(SoulHasPassive(soul , ePassives.PAS_LEGION_SMARTCORE)  && attacker.GetTeam() != hitent.GetTeam()){
        StatusEffect_AddTimed(hitent , eStatusEffect.sonar_detected ,1,5,0)
    }





}

void function scorchhit(entity player , var damageInfo )
{
    entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!IsValid(attacker))
        return

    if(!attacker.IsPlayer())
        return

    entity soul = attacker.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!SoulHasPassive(soul , ePassives.PAS_SCORCH_FIREWALL))
        return

    if(DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave_secondary || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_flame_wall || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanability_slow_trap || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_meteor|| DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_meteor_thermite || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_heat_shield)
    {
        if(IsValid(player) && IsAlive(player)){
            if(player.IsPlayer() && player != attacker){
                DamageInfo_ScaleDamage(damageInfo , 1.3)
                StatusEffect_AddTimed(player,eStatusEffect.move_slow ,0.55,1.5,0)
            }
        }
    }




}


void function tonehit(entity player , var damageInfo )
{
    entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!IsValid(attacker))
        return

    if(player == attacker)
        return

    if(!attacker.IsPlayer())
        return

    entity soul = attacker.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!SoulHasPassive(soul , ePassives.PAS_TONE_WEAPON))
        return

    if(DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titanweapon_tracker_rockets )
    {
        float trackchance = RandomFloatRange(0,1)
        if(trackchance <= 0.1)
        ApplyTrackerMark( attacker, player )
    }




}


void function OnPilotDeath(entity player , var damageInfo )
{
    //player.s.isskill <- false
    //player.s.Selfdestorytime <- 0
    player.s.hasshoweuipment <- false
    player.s.hasdodge <- false
    player.s.hasemp <- false
    player.s.hasapplyemp <- false
    player.s.nukecount <- 0
    player.s.empcount <- 0

    player.s.cancool <- false



    player.s.hascloak <- false
    player.s.hasapplycloak <- false
    player.s.cancloak <- false

    player.s.isaiming <- false
    player.s.hasshowmessage <- false
    player.s.eggonline <- false


    player.s.cantrack <- false
    player.s.vipertarget <- null

    if(expect int(player.s.eggcount) > 0){
        player.s.eggcount--
    }



    entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!IsValid(attacker))
        return

    if(!attacker.IsPlayer())
        return



    entity soul = attacker.GetTitanSoul()


    if(!IsValid(soul))
        return

    if(SoulHasPassive( soul , ePassives.PAS_RONIN_SWORDCORE ) ){

        entity ordweap = attacker.GetOffhandWeapon( OFFHAND_ORDNANCE )        //Q
        if( IsValid( ordweap ) )
        {
            int weaponMax = ordweap.GetWeaponPrimaryClipCountMax()
            int ammo = ordweap.GetWeaponPrimaryClipCount()
            if ( ammo < weaponMax )
                ordweap.SetWeaponPrimaryClipCount( weaponMax )
        }

    }
    /*
    if((DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave || DamageInfo_GetDamageSourceIdentifier( damageInfo ) == eDamageSourceId.mp_titancore_flame_wave_secondary)&& SoulHasPassive( soul , ePassives.PAS_SCORCH_FLAMECORE )){
        if(IsValid(player))
        Explosion(
            player.GetOrigin()+ <0,0,80>,
            attacker,
            attacker,
            90,
            4500,
            1000,
            1000,
            SF_ENVEXPLOSION_NOSOUND_FOR_ALLIES,
            player.GetOrigin()+ <0,0,100>,
            1000,
            damageTypes.explosive,
            eDamageSourceId.mp_titancore_flame_wave,
            TITAN_EXPLOSION_GROUNDWASH_FX_TABLE)
    }
    */


}

void function onroninbehit(entity ronin , var damageInfo)
{
    if(!IsValid(ronin) || !IsAlive(ronin))
        return

    entity soul = ronin.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!SoulHasPassive(soul , ePassives.PAS_RONIN_AUTOSHIFT))
        return

    if(!ronin.s.hasemp){
        ronin.s.hasemp <- true
        thread empplayer(ronin)
    }


}

void function onshengcunbehit(entity shengcun , var damageInfo)
{
    if(!IsValid(shengcun) || !IsAlive(shengcun))
        return

    entity soul = shengcun.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!SoulHasPassive(soul , ePassives.PAS_VANGUARD_DOOM))
        return

    if(!shengcun.s.hasemp){
        shengcun.s.hasemp <- true
        thread Applysomepassive(shengcun)
    }


}

void function empplayer(entity player)
{
    while(true){
        if(!IsValid(player) || !IsAlive(player))
        break

        if(GetDoomedState(player) && !player.s.hasapplyemp){
            thread EMPMissileThinkConstant(player , player)
            PlayerEarnMeter_AddOwnedFrac(player, 0.5 )
            player.s.hasapplyemp <- true
        }
        wait 0.3
    }
}

void function onnorthstarbehit(entity northstar , var damageInfo)
{
    if(!IsValid(northstar) || !IsAlive(northstar))
        return

    entity soul = northstar.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!SoulHasPassive(soul , ePassives.PAS_NORTHSTAR_FLIGHTCORE))
        return

    if(northstar.IsOnGround())
        return

    entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!IsValid(attacker))
        return

    if(!IsCriticalHit( attacker, northstar, DamageInfo_GetHitBox( damageInfo ), DamageInfo_GetDamage( damageInfo ), DamageInfo_GetDamageType( damageInfo ) )){

        DamageInfo_ScaleDamage(damageInfo ,0.65)
    }
    if(IsCriticalHit( attacker, northstar, DamageInfo_GetHitBox( damageInfo ), DamageInfo_GetDamage( damageInfo ), DamageInfo_GetDamageType( damageInfo ) )){

        DamageInfo_ScaleDamage(damageInfo ,2.0)
    }
    //DamageInfo_ScaleDamage(damageInfo ,0.35)



}

/*
void function cancelshield(entity player)
{
	if(!IsValid(player) || !IsAlive(player))
		return

	entity titan = player
	entity soul = player.GetTitanSoul()
	if(!IsValid(soul))
		return
	entity bbshield = soul.soul.bubbleShield
	if(!IsValid(bbshield))
		return
    if(!player.s.isskill)
	    CleanupTitanBubbleShieldVars(titan,soul,bbshield)
}

void function Selfdestory(entity player)
{
	while(true){

		if(IsValid(player) && IsAlive(player)){
			entity soul = player.GetTitanSoul()

			if(IsValid(soul) && IsAlive(soul) && !player.s.isskill){
				if(IsValid(soul.soul.bubbleShield)){
					if(player.IsInputCommandHeld(IN_DUCK)){
						player.s.Selfdestorytime++
						int Selfdestorytimes = expect int(player.s.Selfdestorytime)
						string message1 = ""
						string message2 = ""
						for(int ms1 = 1 ; ms1 < Selfdestorytimes ; ms1++){
							message1 = message1 + string3
						}
						for(int ms2 = 1 ; ms2 < (11-Selfdestorytimes) ; ms2++){
							message2 = message2 + string4
						}

						SendHudMessage(player, string0 +"\n" +string1 + string2 +  message1 + message1 + message1 + message2+ message2+message2 + string5,-1,0.65,60,196,130,1,0,0.5,0)
					}
					else{
						if(expect int(player.s.Selfdestorytime) > 1){
							player.s.Selfdestorytime--

						}
						int Selfdestorytimes = expect int(player.s.Selfdestorytime)
						string message1 = ""
						string message2 = ""
						for(int ms1 = 1 ; ms1 < Selfdestorytimes ; ms1++){
							message1 = message1 + string3
						}
						for(int ms2 = 1 ; ms2 < (11-Selfdestorytimes) ; ms2++){
							message2 = message2 + string4
						}

						SendHudMessage(player, string0 +"\n" +string1 + string2 +  message1 + message1 + message1 + message2+ message2+message2 + string5,-1,0.65,60,196,130,1,0,0.5,0)

					}
				}


                if(!player.s.hasshoweuipment){
                    player.s.hasshoweuipment <- true
                    foreach(dopassive in allpassive){
                        if(SoulHasPassive(player.GetTitanSoul(), dopassive )){
                            Chat_ServerPrivateMessage( player,  passivedescriptions[dopassive], false, true )

                        }
                    }

                }
			}

		}

		if(IsValid(player) && IsAlive(player)){
			if(expect int(player.s.Selfdestorytime) > 10){
				if(IsValid(player) && IsAlive(player)){
					player.Die(player,null, {damageSourceId = eDamageSourceId.restart})    //直接秒杀
					player.SetPlayerGameStat(PGS_DEATHS , player.GetPlayerGameStat(PGS_DEATHS) - 1)
				}
			}

		}

		wait 0.1
	}
}*/

void function rebuildsniperammo(entity player)
{

    while(true){
        if(!IsValid(player))
        break

        if(IsValid(player.GetTitanSoul())){
            if(IsAlive(player) && SoulHasPassive(player.GetTitanSoul() , ePassives.PAS_NORTHSTAR_WEAPON)){
                if(player.GetMainWeapons().len()>0){
                    entity main = player.GetMainWeapons()[0]
                    if(IsValid(main)){
                        if(main.GetWeaponPrimaryClipCount()>3){
                            main.SetWeaponPrimaryClipCount(3)
                        }
                    }
                }

            }



        }



        wait 1
    }



}



void function Applysomepassive(entity player)
{
    entity soul = player.GetTitanSoul()

    if(!IsValid(soul)  ||   !IsAlive(soul))
        return

    if(SoulHasPassive(soul , ePassives.PAS_VANGUARD_DOOM))
        thread healent(player)

}

void function healent(entity player)
{
    entity soul = player.GetTitanSoul()

    if(!IsValid(soul)  ||   !IsAlive(soul))
        return

    while(true){

        if (!IsValid(player) || !IsAlive(player) || !SoulHasPassive(soul , ePassives.PAS_VANGUARD_DOOM))
        break

        player.SetHealth(minint(   (player.GetHealth() + 13), player.GetMaxHealth()  ))
        //player.Die()

        wait 0.5
    }
}

void function egghit(entity player , var damageInfo)
{
    entity attacker = DamageInfo_GetAttacker(damageInfo)
    if(!player.IsPlayer() || !attacker.IsPlayer())
        return

    if(!IsValid(player) || !IsAlive(player) || !IsValid(attacker) || !IsAlive(attacker) )
        return

    /*if(!GetDoomedState(player))
        return
    */
    entity soul = player.GetTitanSoul()
    if(!IsValid(soul))
        return


    /*if(attacker != player && expect int(player.s.eggcount) != 0)
        player.s.eggcount <- 0
    */
    if(expect int(player.s.eggcount) != 1)
        return


    if(SoulHasPassive(soul , ePassives.PAS_SCORCH_FLAMECORE) && !player.s.cannotegg && attacker == player){
        player.s.eggcount <- 0
        player.SetTitle("界野牛")
        player.GetTitanSoul().SetTitle("界野牛")
        player.s.eggonline <- true
        player.s.cannotegg <- true
        player.SetPowerRegenRateScale( 6.5 )
        //StatusEffect_AddTimed(player,eStatusEffect.damage_reduction ,0.55,999,0)
        foreach( weapon in player.GetMainWeapons() )
            player.TakeWeaponNow( weapon.GetWeaponClassName() )

            //player.GiveWeapon("mp_titanweapon_sticky_40mm")
            player.TakeOffhandWeapon( OFFHAND_ORDNANCE )
            player.TakeOffhandWeapon( OFFHAND_TITAN_CENTER )
            player.TakeOffhandWeapon( OFFHAND_SPECIAL )
            //player.TakeOffhandWeapon( OFFHAND_EQUIPMENT )
            player.TakeOffhandWeapon( OFFHAND_MELEE )
            player.GiveOffhandWeapon( "mp_titanweapon_vortex_shield", OFFHAND_SPECIAL )
            player.GiveOffhandWeapon( "mp_ability_heal", OFFHAND_TITAN_CENTER)
            player.GiveOffhandWeapon( "mp_titanweapon_homing_rockets", OFFHAND_ORDNANCE)
            //player.GiveOffhandWeapon("mp_titancore_shift_core",OFFHAND_EQUIPMENT)
            player.GiveOffhandWeapon( "melee_titan_punch_fighter", OFFHAND_MELEE, [ "berserker2", "allow_as_primary" ] )
            player.SetActiveWeaponByName( "melee_titan_punch_fighter" )

    }
}

void function egghitsomeone(entity player , var damageInfo)
{
    entity attacker = DamageInfo_GetAttacker(damageInfo)

    if(!IsValid(attacker) || !IsAlive(attacker))
        return

    if(!attacker.IsPlayer())
        return

    if(attacker.s.eggonline)
        DamageInfo_ScaleDamage(damageInfo , 1.5)



}


void function nukeject(entity player)
{
    if(!IsValid(player) || !IsAlive(player))
        return

    if(!player.IsTitan())
        return

    if ( player.ContextAction_IsMeleeExecution() ) //Could just check for ContextAction_IsActive() if we need to be more general
		return

    if(!GetDoomedState(player))
        return

    if(!PlayerHasPassive( player, ePassives.PAS_BUILD_UP_NUCLEAR_CORE ))
        return

    if(expect int(player.s.nukecount) >= 0 && expect int(player.s.nukecount) < 3){
        player.s.nukecount++
        EmitSoundOnEntity( player, "titan_eject_xbutton" )
    }

    if(expect int(player.s.nukecount) == 3 && !player.GetTitanSoul().IsEjecting()){
        player.s.nukecount <- 0
        thread TitanEjectPlayer( player )
        thread killplayer(player)
    }


}

void function killplayer(entity player)
{
    while(true){
        if(!IsValid(player) || !IsAlive(player))
            break

        if(!player.IsTitan() && IsAlive(player))
            player.Die(player,null, {damageSourceId = eDamageSourceId.mp_titancore_nuke_core})    //直接秒杀

        WaitFrame()
    }
}


void function oncloakbehit(entity player , var damageInfo)
{
    if(!IsValid(player) || !IsAlive(player))
        return

    entity soul = player.GetTitanSoul()
    if(!IsValid(soul))
        return

    if(!player.s.cancloak)
        return

    if(!player.s.hascloak){
        player.s.hascloak <- true
        thread cloakplayer(player)
    }

}

void function cloakplayer(entity player)
{
    while(true){
        if(!IsValid(player) || !IsAlive(player))
        break

        if(GetDoomedState(player) && !player.s.hasapplycloak){

            EnableCloak(player , 7)
            player.GetTitanSoul().SetShieldHealth( player.GetTitanSoul().GetShieldHealthMax() )
            player.Server_SetDodgePower(100.0)
            player.s.hasapplycloak <- true
        }
        wait 0.3
    }
}

void function coolswordatk(entity player)
{
    vector playerpos = player.GetOrigin()+<0,0,200>
    thread coolswordatkthread1(player , playerpos)


}

void function coolswordatkthread1(entity player , vector playerpos)
{
    array <vector> startpos = []
    array <vector> endpos = []
    for(int atktime = 0 ; atktime < 5 ; atktime++){

        if(IsValid(player)){

            vector addpos = <RandomFloatRange(-400 , 400) , RandomFloatRange(-400 , 400) , 330>
            vector swordlinestratpos = playerpos + addpos
            vector swordlineendpos = playerpos - 2*addpos + <RandomFloatRange(-500 , 500) , RandomFloatRange(-500 , 500)  , 0>
            thread swordline(player , swordlinestratpos , swordlineendpos ,playerpos)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_1P" )
            startpos.append(swordlinestratpos)
            endpos.append(swordlineendpos)

            addpos = <RandomFloatRange(-400 , 400) , RandomFloatRange(-400 , 400) , 330>
            swordlinestratpos = playerpos + addpos
            swordlineendpos = playerpos - 2*addpos + <RandomFloatRange(-500 , 500) , RandomFloatRange(-500 , 500)  , 0>
            thread swordline(player , swordlinestratpos , swordlineendpos ,playerpos)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_1P" )
            startpos.append(swordlinestratpos)
            endpos.append(swordlineendpos)

            addpos = <RandomFloatRange(-400 , 400) , RandomFloatRange(-400 , 400) , 330>
            swordlinestratpos = playerpos + addpos
            swordlineendpos = playerpos - 2*addpos + <RandomFloatRange(-500 , 500) , RandomFloatRange(-500 , 500)  , 0>
            thread swordline(player , swordlinestratpos , swordlineendpos ,playerpos)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_1P" )
            startpos.append(swordlinestratpos)
            endpos.append(swordlineendpos)

            addpos = <RandomFloatRange(-400 , 400) , RandomFloatRange(-400 , 400) , 330>
            swordlinestratpos = playerpos + addpos
            swordlineendpos = playerpos - 2*addpos + <RandomFloatRange(-500 , 500) , RandomFloatRange(-500 , 500)  , 0>
            thread swordline(player , swordlinestratpos , swordlineendpos ,playerpos)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_1P" )
            startpos.append(swordlinestratpos)
            endpos.append(swordlineendpos)
        }
        WaitFrame()
    }
    wait 2.7
    if(IsValid(player))
        thread coolswordatkthread3(player , playerpos , startpos , endpos)

}


void function swordline(entity player , vector stratpos , vector endpos,vector playerpos)
{


    if(!IsValid(player) )
        return

    entity cpEnd = CreateEntity( "info_placement_helper" )
    cpEnd.SetTakeDamageType(DAMAGE_NO)
    SetTargetName( cpEnd, UniqueString( "laser_pylon_cpEnd" ) )
    cpEnd.SetOrigin(endpos)
    WaitFrame();WaitFrame()

    entity mover1 = CreateOwnedScriptMover( cpEnd )
    cpEnd.SetParent( mover1 )
    DispatchSpawn( cpEnd )

    entity beamFXfriendly = CreateEntity( "info_particle_system" )
    beamFXfriendly.kv.cpoint1 = cpEnd.GetTargetName()
    beamFXfriendly.SetValueForEffectNameKey( BEAM1 )
    beamFXfriendly.kv.start_active = 1
    beamFXfriendly.kv.VisibilityFlags = ENTITY_VISIBLE_TO_FRIENDLY
    beamFXfriendly.SetOrigin( stratpos)
    //vector cpEndPoint = endpos
    beamFXfriendly.SetAngles( VectorToAngles( endpos - stratpos))
    entity mover2 = CreateOwnedScriptMover( beamFXfriendly )
    beamFXfriendly.SetParent( mover2 )
    SetTeam( beamFXfriendly,player.GetTeam() )
    DispatchSpawn( beamFXfriendly )

    entity beamFXenemy = CreateEntity( "info_particle_system" )
    beamFXenemy.kv.cpoint1 = cpEnd.GetTargetName()
    beamFXenemy.SetValueForEffectNameKey( BEAM4 )
    beamFXenemy.kv.start_active = 1
    beamFXenemy.kv.VisibilityFlags = ENTITY_VISIBLE_TO_ENEMY
    beamFXenemy.SetOrigin( stratpos)
    //vector cpEndPoint = endpos
    beamFXenemy.SetAngles( VectorToAngles( endpos - stratpos))
    entity mover3 = CreateOwnedScriptMover( beamFXenemy )
    beamFXenemy.SetParent( mover3 )
    SetTeam( beamFXenemy, player.GetTeam()  )
    DispatchSpawn( beamFXenemy )

    OnThreadEnd(
	function() : (beamFXfriendly,cpEnd,player, mover1 , mover2 ,  playerpos,stratpos,endpos , mover3 ,beamFXenemy )
		{

			if(IsValid(player)){
                thread coolswordatkthread2(player ,  stratpos ,  endpos , playerpos,mover1,mover2,beamFXfriendly,cpEnd, mover3 ,beamFXenemy )
            }

		}
	)


    wait 1.5


}

void function coolswordatkthread2(entity player , vector swordlinestratpos , vector swordlineendpos ,vector playerpos,entity mover1,entity mover2,entity beamFX,entity cpEnd ,entity mover3 ,entity beamFXenemy )
{
    if(IsValid(player)){
        thread swordline2(player , swordlinestratpos , swordlineendpos ,playerpos)
        EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_3P" )
    }

    OnThreadEnd(
	function() : (beamFX,cpEnd,mover1 , mover2 , mover3 , beamFXenemy)
		{
			if(IsValid(mover1)){
                mover1.Die()
            }
            if(IsValid(mover2)){
                mover2.Die()
            }
            if(IsValid(beamFX)){
                beamFX.Destroy()
                //player.s.inzizizi <-false
            }
            if(IsValid(mover3)){
                mover3.Die()
            }
            if(IsValid(beamFXenemy)){
                beamFXenemy.Destroy()
                //player.s.inzizizi <-false
            }
            if(IsValid(cpEnd)){
                cpEnd.Destroy()
            }
		}
	)

    wait 0.3
    if(IsValid(mover1)){
        mover1.Die()
    }
    if(IsValid(mover2)){
        mover2.Die()
    }
    if(IsValid(beamFX)){
        beamFX.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(mover3)){
        mover3.Die()
    }
    if(IsValid(beamFXenemy)){
        beamFXenemy.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(cpEnd)){
        cpEnd.Destroy()
    }
}

void function swordline2(entity player , vector stratpos , vector endpos,vector playerpos)
{
    if(!IsValid(player) )
        return

    entity cpEnd = CreateEntity( "info_placement_helper" )
    cpEnd.SetTakeDamageType(DAMAGE_NO)
    SetTargetName( cpEnd, UniqueString( "laser_pylon_cpEnd" ) )
    cpEnd.SetOrigin(endpos)
    WaitFrame();WaitFrame()

    //SendHudMessage(player, "dddd",-1,0.65,60,196,130,1,0,0.5,0)
    entity mover1 = CreateOwnedScriptMover( cpEnd )
    cpEnd.SetParent( mover1 )
    DispatchSpawn( cpEnd )

    entity beamFX = CreateEntity( "info_particle_system" )
    beamFX.kv.cpoint1 = cpEnd.GetTargetName()

    beamFX.SetValueForEffectNameKey( BEAM2 )
    beamFX.kv.start_active = 1
    // SetTeam( beamFX, GetOtherTeam( owner.GetTeam() ) )
    // beamFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_FRIENDLY
    beamFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_EVERYONE

    beamFX.SetOrigin( stratpos)
    vector cpEndPoint = endpos
    beamFX.SetAngles( VectorToAngles( endpos - stratpos))
    //beamFX.SetOrigin(player.EyePosition())
    //beamFX.SetParent( player )

    entity mover2 = CreateOwnedScriptMover( beamFX )
    beamFX.SetParent( mover2 )
    DispatchSpawn( beamFX )
    //player.s.inzizizi <- true

    //NSSendAnnouncementMessageToPlayer(player, "ziziziziz","", <99,15,161>, 12, 6)
    OnThreadEnd(
	function() : (beamFX,cpEnd,player, mover1 , mover2 ,  playerpos,stratpos,endpos)
		{

			EmitSoundAtPosition( TEAM_ANY, playerpos, "ronin_sword_melee_3p" )
            CreateShake( playerpos-<0,0,120>, 4, 12,0.5, 1500 )

			if(IsValid(player)){
                array <entity> targets = Getentinline(player , stratpos , endpos)

                foreach(ent in targets){
                    ent.TakeDamage( 1000 ,player ,null, {damageSourceId = eDamageSourceId.swordcut})
                }


            }

            if(IsValid(mover1)){
                mover1.Die()
            }
            if(IsValid(mover2)){
                mover2.Die()
            }
            if(IsValid(beamFX)){
                beamFX.Destroy()
                //player.s.inzizizi <-false
            }
            if(IsValid(cpEnd)){
                cpEnd.Destroy()
            }
		}
	)
    wait 0.2
    if(IsValid(mover1)){
        mover1.Die()
    }
    if(IsValid(mover2)){
        mover2.Die()
    }
    if(IsValid(beamFX)){
        beamFX.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(cpEnd)){
        cpEnd.Destroy()
    }


}

void function coolswordatkthread3(entity player , vector playerpos ,array<vector> startpos , array<vector>  endpos)
{

    int maxtimes =  minint(minint(startpos.len() , endpos.len()) , 20)
    for(int atktime = 1 ; atktime <= maxtimes ; atktime++){
        if(IsValid(player)){

            vector swordlinestratpos =  startpos[atktime-1]
            vector swordlineendpos =  endpos[atktime-1]
            thread swordline3(player , swordlinestratpos , swordlineendpos ,playerpos, atktime)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_3P" )

        }
    }
    wait 0.3
    if(IsValid(player)){
            RadiusDamage(
                playerpos-<0,0,120>,											// center
                player,											// attacker
                player,										// inflictor
                22,								// damage
                5000,					// damageHeavyArmor
                350,						// innerRadius
                950,						// outerRadius
                SF_ENVEXPLOSION_NO_DAMAGEOWNER,					// flags
                0,												// distanceFromAttacker
                0,												// explosionForce
                DF_ELECTRICAL,									// scriptDamageFlags
                eDamageSourceId.swordcutburst )	// scriptDamageSourceIdentifier
    }
    PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )

    entity fx1 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )
    entity rotator1 = CreateOwnedScriptMover(fx1)
    fx1.SetParent(rotator1)
    rotator1.NonPhysicsRotateTo( <0,90,0>, 0.01, 0, 0 )


    entity fx2 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )
    entity rotator2 = CreateOwnedScriptMover(fx2)
    fx2.SetParent(rotator2)
    rotator2.NonPhysicsRotateTo( <90,0,0>, 0.01, 0, 0 )
    //DispatchSpawn(fx2)

    entity fx3 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )
    entity rotator3 = CreateOwnedScriptMover(fx3)
    fx3.SetParent(rotator3)
    rotator3.NonPhysicsRotateTo( <0,0,90>, 0.01, 0, 0 )
    //DispatchSpawn(fx3)

    entity fx4 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )
    entity rotator4 = CreateOwnedScriptMover(fx4)
    fx4.SetParent(rotator4)
    rotator4.NonPhysicsRotateTo( <0,90,90>, 0.01, 0, 0 )


    entity fx5 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )
    entity rotator5 = CreateOwnedScriptMover(fx5)
    fx5.SetParent(rotator5)
    rotator5.NonPhysicsRotateTo( <90,90,0>, 0.01, 0, 0 )
    //DispatchSpawn(fx2)

    entity fx6 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )
    entity rotator6 = CreateOwnedScriptMover(fx6)
    fx6.SetParent(rotator6)
    rotator6.NonPhysicsRotateTo( <90,0,90>, 0.01, 0, 0 )

    CreateShake( playerpos-<0,0,120>, 45, 12,1, 1500 )
}

void function swordline3(entity player , vector stratpos , vector endpos,vector playerpos,int times)
{
    if(!IsValid(player) )
        return

    entity cpEnd = CreateEntity( "info_placement_helper" )
    cpEnd.SetTakeDamageType(DAMAGE_NO)
    SetTargetName( cpEnd, UniqueString( "laser_pylon_cpEnd" ) )
    cpEnd.SetOrigin(endpos)
    WaitFrame();WaitFrame()

    //SendHudMessage(player, "dddd",-1,0.65,60,196,130,1,0,0.5,0)
    entity mover1 = CreateOwnedScriptMover( cpEnd )
    cpEnd.SetParent( mover1 )
    DispatchSpawn( cpEnd )

    entity beamFX = CreateEntity( "info_particle_system" )
    beamFX.kv.cpoint1 = cpEnd.GetTargetName()

    beamFX.SetValueForEffectNameKey( BEAM3 )
    beamFX.kv.start_active = 1
    // SetTeam( beamFX, GetOtherTeam( owner.GetTeam() ) )
    // beamFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_FRIENDLY
    beamFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_EVERYONE

    beamFX.SetOrigin( stratpos)
    vector cpEndPoint = endpos
    beamFX.SetAngles( VectorToAngles( endpos - stratpos))
    //beamFX.SetOrigin(player.EyePosition())
    //beamFX.SetParent( player )

    entity mover2 = CreateOwnedScriptMover( beamFX )
    beamFX.SetParent( mover2 )
    DispatchSpawn( beamFX )
    //player.s.inzizizi <- true

    //NSSendAnnouncementMessageToPlayer(player, "ziziziziz","", <99,15,161>, 12, 6)
    OnThreadEnd(
	function() : (beamFX,cpEnd,player, mover1 , mover2 ,  playerpos,stratpos,endpos,times)
		{

			EmitSoundAtPosition( TEAM_ANY, playerpos, "ronin_sword_melee_3p" )



            if(IsValid(mover1)){
                mover1.Die()
            }
            if(IsValid(mover2)){
                mover2.Die()
            }
            if(IsValid(beamFX)){
                beamFX.Destroy()
                //player.s.inzizizi <-false
            }
            if(IsValid(cpEnd)){
                cpEnd.Destroy()
            }
		}
	)
    wait 0.2
    if(IsValid(mover1)){
        mover1.Die()
    }
    if(IsValid(mover2)){
        mover2.Die()
    }
    if(IsValid(beamFX)){
        beamFX.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(cpEnd)){
        cpEnd.Destroy()
    }


}


void function slowent(entity hitEnt , var damageInfo)
{
   if(IsValid(hitEnt) && IsAlive(hitEnt)){
        StatusEffect_AddTimed(hitEnt, eStatusEffect.move_slow , 0.8 , 3 , 3)
        //StatusEffect_AddTimed(hitEnt, eStatusEffect.emp, 1,1, 0 )
        StatusEffect_AddTimed(hitEnt, eStatusEffect.turn_slow , 0.5 , 3 , 3)
        StatusEffect_AddTimed(hitEnt, eStatusEffect.gravity_grenade_visual , 0.5 , 1 ,1)

    }
}

void function cooltimer(entity player)
{
    for(int times = 1 ; times < 30 ; times++){
        if(!player.s.cancool){
            SendHudMessage(player, "JudementCut :Engage" ,-1,0.65,210,116,10,1,0,0.5,0)
            break
        }

        int lasttime = 30 - times
        string shu = ""
        string space = ""
        for(int shucount = 0; shucount <= lasttime ; shucount++){
            shu += "|"
        }
        for(int spacecount = 30; spacecount > lasttime ; spacecount--){
            space += " "
        }

        if(IsValid(player) && IsAlive(player)){
            SendHudMessage(player, "["+ space + shu + "-JudementCut-" + shu + space + "]",-1,0.65,31,160,207,1,0,0.2,0)
            if(times == 29){

                if(player.GetHealth() == 1)
                    spcoolswordatk(player)
                else
                    coolswordatk(player)

                player.s.cancool <- false
            }
        }
        wait 0.1

    }



}



void function spcoolswordatk(entity player)
{
    vector playerpos = player.GetOrigin()+<0,0,200>
    thread spcoolswordatkthread1(player , playerpos)
}

void function spcoolswordatkthread1(entity player , vector playerpos)
{
    array <vector> startpos = []
    array <vector> endpos = []
    for(int atktime = 0 ; atktime < 15 ; atktime++){

        if(IsValid(player)){

            vector addpos = <RandomFloatRange(-1000 , 1000) , RandomFloatRange(-1000 , 1000) , 600>
            vector swordlinestratpos = playerpos + addpos
            vector swordlineendpos = playerpos - 2*addpos + <RandomFloatRange(-1500 , 1500) , RandomFloatRange(-1500 , 1500)  , 0>
            thread spswordline(player , swordlinestratpos , swordlineendpos ,playerpos)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_1P" )
            startpos.append(swordlinestratpos)
            endpos.append(swordlineendpos)

            addpos = <RandomFloatRange(-1000 , 1000) , RandomFloatRange(-1000 , 1000) , 600>
            swordlinestratpos = playerpos + addpos
            swordlineendpos = playerpos - 2*addpos + <RandomFloatRange(-1500 , 1500) , RandomFloatRange(-1500 , 1500)  , 0>
            thread spswordline(player , swordlinestratpos , swordlineendpos ,playerpos)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_1P" )
            startpos.append(swordlinestratpos)
            endpos.append(swordlineendpos)

            addpos = <RandomFloatRange(-1000 , 1000) , RandomFloatRange(-1000 , 1000) , 600>
            swordlinestratpos = playerpos + addpos
            swordlineendpos = playerpos - 2*addpos + <RandomFloatRange(-1500 , 1500) , RandomFloatRange(-1500 , 1500)  , 0>
            thread spswordline(player , swordlinestratpos , swordlineendpos ,playerpos)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_1P" )
            startpos.append(swordlinestratpos)
            endpos.append(swordlineendpos)

            addpos = <RandomFloatRange(-1000 , 1000) , RandomFloatRange(-1000 , 1000) , 600>
            swordlinestratpos = playerpos + addpos
            swordlineendpos = playerpos - 2*addpos + <RandomFloatRange(-1500 , 1500) , RandomFloatRange(-1500 , 1500)  , 0>
            thread spswordline(player , swordlinestratpos , swordlineendpos ,playerpos)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_1P" )
            startpos.append(swordlinestratpos)
            endpos.append(swordlineendpos)
        }
        WaitFrame()
    }
    wait 5.4
    if(IsValid(player))
        thread spcoolswordatkthread3(player , playerpos , startpos , endpos)

}

void function spswordline(entity player , vector stratpos , vector endpos,vector playerpos)
{
    if(!IsValid(player) )
        return

    entity cpEnd = CreateEntity( "info_placement_helper" )
    cpEnd.SetTakeDamageType(DAMAGE_NO)
    SetTargetName( cpEnd, UniqueString( "laser_pylon_cpEnd" ) )
    cpEnd.SetOrigin(endpos)
    WaitFrame();WaitFrame()

    entity mover1 = CreateOwnedScriptMover( cpEnd )
    cpEnd.SetParent( mover1 )
    DispatchSpawn( cpEnd )

    entity beamFXfriendly = CreateEntity( "info_particle_system" )
    beamFXfriendly.kv.cpoint1 = cpEnd.GetTargetName()
    beamFXfriendly.SetValueForEffectNameKey( BEAM1 )
    beamFXfriendly.kv.start_active = 1
    beamFXfriendly.kv.VisibilityFlags = ENTITY_VISIBLE_TO_FRIENDLY
    beamFXfriendly.SetOrigin( stratpos)
    //vector cpEndPoint = endpos
    beamFXfriendly.SetAngles( VectorToAngles( endpos - stratpos))
    entity mover2 = CreateOwnedScriptMover( beamFXfriendly )
    beamFXfriendly.SetParent( mover2 )
    SetTeam( beamFXfriendly,player.GetTeam() )
    DispatchSpawn( beamFXfriendly )

    entity beamFXenemy = CreateEntity( "info_particle_system" )
    beamFXenemy.kv.cpoint1 = cpEnd.GetTargetName()
    beamFXenemy.SetValueForEffectNameKey( BEAM4 )
    beamFXenemy.kv.start_active = 1
    beamFXenemy.kv.VisibilityFlags = ENTITY_VISIBLE_TO_ENEMY
    beamFXenemy.SetOrigin( stratpos)
    //vector cpEndPoint = endpos
    beamFXenemy.SetAngles( VectorToAngles( endpos - stratpos))
    entity mover3 = CreateOwnedScriptMover( beamFXenemy )
    beamFXenemy.SetParent( mover3 )
    SetTeam( beamFXenemy, player.GetTeam()  )
    DispatchSpawn( beamFXenemy )

    //NSSendAnnouncementMessageToPlayer(player, "ziziziziz","", <99,15,161>, 12, 6)
    OnThreadEnd(
	function() : (beamFXfriendly,cpEnd,player, mover1 , mover2 ,  playerpos,stratpos,endpos , mover3 , beamFXenemy)
		{

			if(IsValid(player)){
                thread spcoolswordatkthread2(player ,  stratpos ,  endpos , playerpos,mover1,mover2,beamFXfriendly,cpEnd, mover3 , beamFXenemy)
            }

		}
	)


    wait 3

    /*if(IsValid(mover1)){
        mover1.Die()
    }
    if(IsValid(mover2)){
        mover2.Die()
    }
    if(IsValid(beamFX)){
        beamFX.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(cpEnd)){
        cpEnd.Destroy()
    }*/


}

void function spcoolswordatkthread2(entity player , vector swordlinestratpos , vector swordlineendpos ,vector playerpos,entity mover1,entity mover2,entity beamFX,entity cpEnd,entity mover3 ,entity beamFXenemy)
{
    if(IsValid(player)){
        thread spswordline2(player , swordlinestratpos , swordlineendpos ,playerpos)
        EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_3P" )
    }

    OnThreadEnd(
	function() : (beamFX,cpEnd,mover1 , mover2 , mover3 , beamFXenemy)
		{
			if(IsValid(mover1)){
                mover1.Die()
            }
            if(IsValid(mover2)){
                mover2.Die()
            }
            if(IsValid(beamFX)){
                beamFX.Destroy()
                //player.s.inzizizi <-false
            }
            if(IsValid(mover3)){
                mover3.Die()
            }
            if(IsValid(beamFXenemy)){
                beamFXenemy.Destroy()
                //player.s.inzizizi <-false
            }
            if(IsValid(cpEnd)){
                cpEnd.Destroy()
            }
		}
	)

    wait 0.3
    if(IsValid(mover1)){
        mover1.Die()
    }
    if(IsValid(mover2)){
        mover2.Die()
    }
    if(IsValid(beamFX)){
        beamFX.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(mover3)){
        mover3.Die()
    }
    if(IsValid(beamFXenemy)){
        beamFXenemy.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(cpEnd)){
        cpEnd.Destroy()
    }
}

void function spswordline2(entity player , vector stratpos , vector endpos,vector playerpos)
{
    if(!IsValid(player) )
        return

    entity cpEnd = CreateEntity( "info_placement_helper" )
    cpEnd.SetTakeDamageType(DAMAGE_NO)
    SetTargetName( cpEnd, UniqueString( "laser_pylon_cpEnd" ) )
    cpEnd.SetOrigin(endpos)
    WaitFrame();WaitFrame()

    //SendHudMessage(player, "dddd",-1,0.65,60,196,130,1,0,0.5,0)
    entity mover1 = CreateOwnedScriptMover( cpEnd )
    cpEnd.SetParent( mover1 )
    DispatchSpawn( cpEnd )

    entity beamFX = CreateEntity( "info_particle_system" )
    beamFX.kv.cpoint1 = cpEnd.GetTargetName()

    beamFX.SetValueForEffectNameKey( BEAM2 )
    beamFX.kv.start_active = 1
    // SetTeam( beamFX, GetOtherTeam( owner.GetTeam() ) )
    // beamFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_FRIENDLY
    beamFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_EVERYONE

    beamFX.SetOrigin( stratpos)
    vector cpEndPoint = endpos
    beamFX.SetAngles( VectorToAngles( endpos - stratpos))
    //beamFX.SetOrigin(player.EyePosition())
    //beamFX.SetParent( player )

    entity mover2 = CreateOwnedScriptMover( beamFX )
    beamFX.SetParent( mover2 )
    DispatchSpawn( beamFX )
    //player.s.inzizizi <- true

    //NSSendAnnouncementMessageToPlayer(player, "ziziziziz","", <99,15,161>, 12, 6)
    OnThreadEnd(
	function() : (beamFX,cpEnd,player, mover1 , mover2 ,  playerpos,stratpos,endpos)
		{

			EmitSoundAtPosition( TEAM_ANY, playerpos, "ronin_sword_melee_3p" )
            CreateShake( playerpos-<0,0,120>, 5, 12,0.5, 1800 )

			if(IsValid(player)){
                array <entity> targets = Getentinline(player , stratpos , endpos)

                foreach(ent in targets){
                    ent.TakeDamage( 4000 ,player ,null, {damageSourceId = eDamageSourceId.swordcut})
                }


            }

            if(IsValid(mover1)){
                mover1.Die()
            }
            if(IsValid(mover2)){
                mover2.Die()
            }
            if(IsValid(beamFX)){
                beamFX.Destroy()
                //player.s.inzizizi <-false
            }
            if(IsValid(cpEnd)){
                cpEnd.Destroy()
            }
		}
	)
    wait 0.2
    if(IsValid(mover1)){
        mover1.Die()
    }
    if(IsValid(mover2)){
        mover2.Die()
    }
    if(IsValid(beamFX)){
        beamFX.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(cpEnd)){
        cpEnd.Destroy()
    }


}

void function spcoolswordatkthread3(entity player , vector playerpos ,array<vector> startpos , array<vector>  endpos)
{

    int maxtimes =  minint(minint(startpos.len() , endpos.len()) , 60)
    for(int atktime = 1 ; atktime <= maxtimes ; atktime++){
        if(IsValid(player)){

            vector swordlinestratpos =  startpos[atktime-1]
            vector swordlineendpos =  endpos[atktime-1]
            thread spswordline3(player , swordlinestratpos , swordlineendpos ,playerpos, atktime)
            EmitSoundAtPosition( TEAM_ANY, playerpos, "holopilot_end_3P" )

        }
    }
    wait 0.3
    if(IsValid(player)){
            RadiusDamage(
                playerpos-<0,0,120>,											// center
                player,											// attacker
                player,										// inflictor
                22,								// damage
                15000,					// damageHeavyArmor
                1500,						// innerRadius
                1500,						// outerRadius
                SF_ENVEXPLOSION_NO_DAMAGEOWNER,					// flags
                0,												// distanceFromAttacker
                0,												// explosionForce
                DF_ELECTRICAL | DF_BYPASS_SHIELD | DF_SKIPS_DOOMED_STATE | DF_MELEE,									// scriptDamageFlags
                eDamageSourceId.spswordcutburst )	// scriptDamageSourceIdentifier
    }
    PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )

    entity fx1 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> )
    entity rotator1 = CreateOwnedScriptMover(fx1)
    fx1.SetParent(rotator1)
    rotator1.NonPhysicsRotateTo( <0,90,0>, 0.01, 0, 0 )


    entity fx2 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> + <RandomIntRange(-200,200),RandomIntRange(-200,200),RandomIntRange(-200,200)> )
    entity rotator2 = CreateOwnedScriptMover(fx2)
    fx2.SetParent(rotator2)
    rotator2.NonPhysicsRotateTo( <90,0,0>, 0.01, 0, 0 )
    //DispatchSpawn(fx2)

    entity fx3 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> + <RandomIntRange(-200,200),RandomIntRange(-200,200),RandomIntRange(-200,200)> )
    entity rotator3 = CreateOwnedScriptMover(fx3)
    fx3.SetParent(rotator3)
    rotator3.NonPhysicsRotateTo( <0,0,90>, 0.01, 0, 0 )
    //DispatchSpawn(fx3)

    entity fx4 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> + <RandomIntRange(-200,200),RandomIntRange(-200,200),RandomIntRange(-200,200)> )
    entity rotator4 = CreateOwnedScriptMover(fx4)
    fx4.SetParent(rotator4)
    rotator4.NonPhysicsRotateTo( <0,90,90>, 0.01, 0, 0 )


    entity fx5 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> + <RandomIntRange(-200,200),RandomIntRange(-200,200),RandomIntRange(-200,200)> )
    entity rotator5 = CreateOwnedScriptMover(fx5)
    fx5.SetParent(rotator5)
    rotator5.NonPhysicsRotateTo( <90,90,0>, 0.01, 0, 0 )
    //DispatchSpawn(fx2)

    entity fx6 = PlayFX( $"P_xo_EMP"   , playerpos-<0,0,80> + <RandomIntRange(-200,200),RandomIntRange(-200,200),RandomIntRange(-200,200)> )
    entity rotator6 = CreateOwnedScriptMover(fx6)
    fx6.SetParent(rotator6)
    rotator6.NonPhysicsRotateTo( <90,0,90>, 0.01, 0, 0 )

    CreateShake( playerpos-<0,0,120>, 90, 12,1, 3000 )
}

void function spswordline3(entity player , vector stratpos , vector endpos,vector playerpos,int times)
{
    if(!IsValid(player) )
        return

    entity cpEnd = CreateEntity( "info_placement_helper" )
    cpEnd.SetTakeDamageType(DAMAGE_NO)
    SetTargetName( cpEnd, UniqueString( "laser_pylon_cpEnd" ) )
    cpEnd.SetOrigin(endpos)
    WaitFrame();WaitFrame()

    //SendHudMessage(player, "dddd",-1,0.65,60,196,130,1,0,0.5,0)
    entity mover1 = CreateOwnedScriptMover( cpEnd )
    cpEnd.SetParent( mover1 )
    DispatchSpawn( cpEnd )

    entity beamFX = CreateEntity( "info_particle_system" )
    beamFX.kv.cpoint1 = cpEnd.GetTargetName()

    beamFX.SetValueForEffectNameKey( BEAM3 )
    beamFX.kv.start_active = 1
    // SetTeam( beamFX, GetOtherTeam( owner.GetTeam() ) )
    // beamFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_FRIENDLY
    beamFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_EVERYONE

    beamFX.SetOrigin( stratpos)
    vector cpEndPoint = endpos
    beamFX.SetAngles( VectorToAngles( endpos - stratpos))
    //beamFX.SetOrigin(player.EyePosition())
    //beamFX.SetParent( player )

    entity mover2 = CreateOwnedScriptMover( beamFX )
    beamFX.SetParent( mover2 )
    DispatchSpawn( beamFX )
    //player.s.inzizizi <- true

    //NSSendAnnouncementMessageToPlayer(player, "ziziziziz","", <99,15,161>, 12, 6)
    OnThreadEnd(
	function() : (beamFX,cpEnd,player, mover1 , mover2 ,  playerpos,stratpos,endpos,times)
		{

			EmitSoundAtPosition( TEAM_ANY, playerpos, "ronin_sword_melee_3p" )



            if(IsValid(mover1)){
                mover1.Die()
            }
            if(IsValid(mover2)){
                mover2.Die()
            }
            if(IsValid(beamFX)){
                beamFX.Destroy()
                //player.s.inzizizi <-false
            }
            if(IsValid(cpEnd)){
                cpEnd.Destroy()
            }
		}
	)
    wait 0.2
    if(IsValid(mover1)){
        mover1.Die()
    }
    if(IsValid(mover2)){
        mover2.Die()
    }
    if(IsValid(beamFX)){
        beamFX.Destroy()
        //player.s.inzizizi <-false
    }
    if(IsValid(cpEnd)){
        cpEnd.Destroy()
    }


}



array <entity> function Getentinline(entity player , vector startpos , vector endpos)
{
    array <entity> targets = []
    vector goonpos = startpos
    for(int searchtimes = 0 ; searchtimes <= 30 ;searchtimes++){
        if(Distance(goonpos , endpos) < 100){
            /*foreach(player in GetPlayerArray())
                SendHudMessage(player, searchtimes.tostring(),-1,0.65,60,196,130,1,0,3,0)*/  //test
            break
        }
        vector lookforward = Normalize(endpos - startpos)
        entity Hitforward = TraceLine(goonpos,endpos,player, TRACE_MASK_SHOT  , TRACE_COLLISION_GROUP_NONE).hitEnt
        vector Hitpos = TraceLine(goonpos,endpos,player, TRACE_MASK_SHOT  , TRACE_COLLISION_GROUP_NONE).endPos
        entity Hitback = TraceLine(goonpos,startpos,player, TRACE_MASK_SHOT  , TRACE_COLLISION_GROUP_NONE).hitEnt
        goonpos = Hitpos + lookforward*15
        if(IsValid(Hitforward)){
            if(Hitforward.IsPlayer() || Hitforward.IsNPC()){
                if(!targets.contains(Hitforward))
                    targets.append(Hitforward)
            }
        }

        if(IsValid(Hitback)){
            if(Hitback.IsPlayer() || Hitback.IsNPC()){
                if(!targets.contains(Hitback))
                    targets.append(Hitback)
            }
        }
    }
    return targets
}





