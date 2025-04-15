untyped

global function MpTitanweaponRocketeetRocketStream_Init

global function OnWeaponPrimaryAttack_TitanWeapon_Rocketeer_RocketStream
global function OnWeaponOwnerChanged_TitanWeapon_Rocketeer_RocketStream
global function OnWeaponDeactivate_TitanWeapon_Rocketeer_RocketStream

global function OnWeaponStartZoomIn_TitanWeapon_Rocketeer_RocketStream
global function OnWeaponStartZoomOut_TitanWeapon_Rocketeer_RocketStream
global function EMPMissileThinkConstant
#if SERVER
global function OnWeaponNpcPrimaryAttack_TitanWeapon_Rocketeer_RocketStream
#endif // #if SERVER

#if CLIENT
global function OnClientAnimEvent_TitanWeapon_Rocketeer_RocketStream
#endif // #if CLIENT


const DRAW_DEBUG = 0
const DEBUG_FAIL = 0
const MERGEDEBUG = 0
const DEBUG_TIME = 5
const MIN_HEIGHT = 70
const POINT_FROM = 0
const POINT_TO = 1
const POINT_NEXT = 2
const POINT_FUTURE = 3
const TRACE_DIST_PER_SECTION = 800
const WALL_BUFFER = 74
const STEEPNESS_DOT = 0.6
const MISSILE_LOOKAHEAD = 150 // 150
const MATCHSLOPERISE = 40 // 32
const MISSILE_LIFETIME = 8.0
const FUDGEPOINT_RIGHT = 100
const FUDGEPOINT_UP = 150
const PROX_MISSILE_RANGE = 160
const BURN_CLUSTER_EXPLOSION_INNER_RADIUS = 150
const BURN_CLUSTER_EXPLOSION_RADIUS = 220
const BURN_CLUSTER_EXPLOSION_DAMAGE = 66
const BURN_CLUSTER_EXPLOSION_DAMAGE_HEAVY_ARMOR = 100
const BURN_CLUSTER_NPC_EXPLOSION_DAMAGE = 66
const BURN_CLUSTER_NPC_EXPLOSION_DAMAGE_HEAVY_ARMOR = 100

const asset AMPED_SHOT_PROJECTILE = $"models/weapons/bullets/temp_triple_threat_projectile_large.mdl"


function MpTitanweaponRocketeetRocketStream_Init()
{
	RegisterSignal( "FiredWeapon" )

	PrecacheParticleSystem( $"wpn_muzzleflash_xo_rocket_FP" )
	PrecacheParticleSystem( $"wpn_muzzleflash_xo_rocket" )
	PrecacheParticleSystem( $"wpn_muzzleflash_xo_fp" )
	PrecacheParticleSystem( $"P_muzzleflash_xo_mortar" )

#if SERVER
	PrecacheModel( AMPED_SHOT_PROJECTILE )
#endif // #if SERVER
}

void function OnWeaponStartZoomIn_TitanWeapon_Rocketeer_RocketStream( entity weapon )
{
#if SERVER
	array<string> mods = weapon.GetMods()
	mods.append( "rocketstream_fast" )
	weapon.SetMods( mods )
#else
	entity weaponOwner = weapon.GetWeaponOwner()
	if ( weaponOwner == GetLocalViewPlayer() )
		EmitSoundOnEntity( weaponOwner, "Weapon_Particle_Accelerator_WindUp_1P" )
#endif
	//weapon.PlayWeaponEffectNoCull( $"wpn_arc_cannon_electricity_fp", $"wpn_arc_cannon_electricity", "muzzle_flash" )
	//weapon.PlayWeaponEffectNoCull( $"wpn_arc_cannon_charge_fp", $"wpn_arc_cannon_charge", "muzzle_flash" )
	//weapon.EmitWeaponSound( "arc_cannon_charged_loop" )
}

void function OnWeaponStartZoomOut_TitanWeapon_Rocketeer_RocketStream( entity weapon )
{
#if SERVER
	array<string> mods = weapon.GetMods()
	mods.fastremovebyvalue( "rocketstream_fast" )
	weapon.SetMods( mods )
#endif
	//weapon.StopWeaponEffect( $"wpn_arc_cannon_charge_fp", $"wpn_arc_cannon_charge" )
	//weapon.StopWeaponEffect( $"wpn_arc_cannon_electricity_fp", $"wpn_arc_cannon_electricity" )
	//weapon.StopWeaponSound( "arc_cannon_charged_loop" )
}


#if CLIENT
void function OnClientAnimEvent_TitanWeapon_Rocketeer_RocketStream( entity weapon, string name )
{
	if ( name == "muzzle_flash" )
	{
		weapon.PlayWeaponEffect( $"wpn_muzzleflash_xo_fp", $"wpn_muzzleflash_xo_rocket", "muzzle_flash" )
	}
}
#endif // #if CLIENT

var function OnWeaponPrimaryAttack_TitanWeapon_Rocketeer_RocketStream( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	#if CLIENT
		if ( !weapon.ShouldPredictProjectiles() )
			return 1
	#endif

	return FireMissileStream( weapon, attackParams, PROJECTILE_PREDICTED )
}

#if SERVER
var function OnWeaponNpcPrimaryAttack_TitanWeapon_Rocketeer_RocketStream( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	return FireMissileStream( weapon, attackParams, PROJECTILE_NOT_PREDICTED )
}
#endif // #if SERVER

int function FireMissileStream( entity weapon, WeaponPrimaryAttackParams attackParams, bool predicted )
{
	if( weapon.IsWeaponInAds() && !weapon.HasMod( "rocketstream_fast" ) )
		weapon.AddMod( "rocketstream_fast" )
    if( !weapon.IsWeaponInAds() && weapon.HasMod( "rocketstream_fast" ) )
        weapon.RemoveMod( "rocketstream_fast" )

	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )

	if ( weapon.IsWeaponAdsButtonPressed() )
		weapon.EmitWeaponSound_1p3p( "Weapon_Titan_Rocket_Launcher_Amped_Fire_1P", "Weapon_Titan_Rocket_Launcher_Amped_Fire_3P" )
	else
		weapon.EmitWeaponSound_1p3p( "Weapon_Titan_Rocket_Launcher.RapidFire_1P", "Weapon_Titan_Rocket_Launcher.RapidFire_3P" )

	entity weaponOwner = weapon.GetWeaponOwner()
	if ( !IsValid( weaponOwner ) )
		return 0
	bool adsPressed = weapon.IsWeaponAdsButtonPressed()
	bool hasBurnMod = weapon.HasMod( "burn_mod_titan_rocket_launcher" )
	bool has_s2s_npcMod = weapon.HasMod( "sp_s2s_settings_npc" )
	bool has_mortar_mod = weapon.HasMod( "coop_mortar_titan" )
	if ( !adsPressed && !hasBurnMod && !has_s2s_npcMod && !has_mortar_mod )
	{
		int shots = minint( weapon.GetProjectilesPerShot(), weapon.GetWeaponPrimaryClipCount() )
		if (weapon.HasMod("kk_amped"))
			FireMissileStream_Emp(weapon, attackParams, predicted, shots)
		else
			FireMissileStream_Spiral( weapon, attackParams, predicted, shots )
		return shots
	}
	else
	{
		//attackParams.pos = attackParams.pos + Vector( 0, 0, -20 )
		// float missileSpeed = 2800
		float missileSpeed = 6000
		if ( has_s2s_npcMod || has_mortar_mod )
			missileSpeed = 2500

		int impactFlags = (DF_IMPACT | DF_GIB | DF_KNOCK_BACK)
		entity missile = weapon.FireWeaponMissile( attackParams.pos, attackParams.dir, missileSpeed, impactFlags, damageTypes.explosive | DF_KNOCK_BACK, false, predicted )
		if (weapon.HasMod("kk_amped"))
			thread EMPMissileThinkConstant(missile, missile.GetOwner())
		if ( missile )
		{
			SetTeam( missile, weaponOwner.GetTeam() )
#if SERVER
			string whizBySound = "Weapon_Sidwinder_Projectile"
			EmitSoundOnEntity( missile, whizBySound )
			if ( weapon.w.missileFiredCallback != null )
			{
				weapon.w.missileFiredCallback( missile, weaponOwner )
	        }
#endif // #if SERVER
		}

		return 1
	}

	unreachable
}


int function FindIdealMissileConfiguration( int numMissiles, int i )
{
	//We're locked into 4 missiles from passing in 0-3, and in the case of 2 we want to fire the horizontal missiles for aesthetic reasons.
	int idealMissile
	if ( numMissiles == 2 )
	{
		if ( i == 0 )
			idealMissile = 1
		else
			idealMissile = 3
	}
	else
	{
		idealMissile = i
	}

	return idealMissile
}

void function FireMissileStream_Spiral( entity weapon, WeaponPrimaryAttackParams attackParams, bool predicted, int numMissiles = 4 )
{
	//attackParams.pos = attackParams.pos + Vector( 0, 0, -20 )
	array<entity> missiles
	float missileSpeed = 1200

	entity weaponOwner = weapon.GetWeaponOwner()
	if ( IsSingleplayer() && weaponOwner.IsPlayer() )
		missileSpeed = 2000

	for ( int i = 0; i < numMissiles; i++ )
	{
		int impactFlags = (DF_IMPACT | DF_GIB | DF_KNOCK_BACK)

		entity missile = weapon.FireWeaponMissile( attackParams.pos, attackParams.dir, missileSpeed, impactFlags, damageTypes.explosive | DF_KNOCK_BACK, false, predicted )
		if ( missile )
		{
			//Spreading out the missiles
			int missileNumber = FindIdealMissileConfiguration( numMissiles, i )
			missile.InitMissileSpiral( attackParams.pos, attackParams.dir, missileNumber, false, false )

			//missile.s.launchTime <- Time()
			// each missile knows about the other missiles, so they can all blow up together
			//missile.e.projectileGroup = missiles
			missile.kv.lifetime = MISSILE_LIFETIME
			missile.SetSpeed( missileSpeed );
			SetTeam( missile, weapon.GetWeaponOwner().GetTeam() )

			missiles.append( missile )

#if SERVER
			EmitSoundOnEntity( missile, "Weapon_Sidwinder_Projectile" )
#endif // #if SERVER
		}
	}
}

void function FireMissileStream_Emp( entity weapon, WeaponPrimaryAttackParams attackParams, bool predicted, int numMissiles = 4 )
{
	//attackParams.pos = attackParams.pos + Vector( 0, 0, -20 )
	array<entity> missiles
	float missileSpeed = 1200

	entity weaponOwner = weapon.GetWeaponOwner()
	if ( IsSingleplayer() && weaponOwner.IsPlayer() )
		missileSpeed = 2000

	for ( int i = 0; i < numMissiles; i++ )
	{
		int impactFlags = (DF_IMPACT | DF_GIB | DF_KNOCK_BACK)

		entity missile = weapon.FireWeaponMissile( attackParams.pos, attackParams.dir, missileSpeed, impactFlags, damageTypes.explosive | DF_KNOCK_BACK, false, predicted )
		if ( missile )
		{
			//Spreading out the missiles
			int missileNumber = FindIdealMissileConfiguration( numMissiles, i )
			missile.InitMissileSpiral( attackParams.pos, attackParams.dir, missileNumber, false, false )

			//missile.s.launchTime <- Time()
			// each missile knows about the other missiles, so they can all blow up together
			//missile.e.projectileGroup = missiles
			missile.kv.lifetime = MISSILE_LIFETIME
			missile.SetSpeed( missileSpeed );
			SetTeam( missile, weapon.GetWeaponOwner().GetTeam() )

			missiles.append( missile )

#if SERVER
			EmitSoundOnEntity( missile, "Weapon_Sidwinder_Projectile" )
#endif // #if SERVER
		}
		thread EMPMissileThinkConstant(missile, missile.GetOwner())
	}
}

void function OnWeaponOwnerChanged_TitanWeapon_Rocketeer_RocketStream( entity weapon, WeaponOwnerChangedParams changeParams )
{
	#if SERVER
	weapon.w.missileFiredCallback = null
	#endif
}

void function OnWeaponDeactivate_TitanWeapon_Rocketeer_RocketStream( entity weapon )
{
}

void function ClusterMissileThink(entity think, entity owner) {

}

// emp
const DAMAGE_AGAINST_TITANS 			= 60
const DAMAGE_AGAINST_PILOTS 			= 20

const EMP_DAMAGE_TICK_RATE = 0.1
const FX_EMP_FIELD						= $"P_xo_emp_field"
const FX_EMP_FIELD_1P					= $"P_body_emp_1P"

struct
{
	array<entity> empTitans
} file

void function EMPMissileThinkConstant( entity titan, entity owner )
{
	RegisterSignal( "empistimeout" )

	titan.EndSignal( "empistimeout" )
	//titan.EndSignal( "OnDeath" )
	//titan.EndSignal( "OnDestroy" )
	//titan.EndSignal( "Doomed" )
	//titan.EndSignal( "StopEMPField" )

	//We don't want pilots accidently rodeoing an electrified titan.
	//DisableTitanRodeo( titan )

	//Used to identify this titan as an arc titan
	// SetTargetName( titan, "empTitan" ) // unable to do this due to FD reasons
	file.empTitans.append( titan )

	//Wait for titan to stand up and exit bubble shield before deploying arc ability.
	WaitTillHotDropComplete( titan )

	/*if ( HasSoul( titan ) )
	{
		entity soul = titan.GetTitanSoul()
		soul.EndSignal( "StopEMPField" )
	}*/

	local attachment = "hijack"

	local attachID = titan.LookupAttachment( attachment )

	EmitSoundOnEntity( titan, "EMP_Titan_Electrical_Field" )

	array<entity> particles = []

	//emp field fx
	vector origin = titan.GetOrigin()
	if ( titan.IsPlayer() )
	{
		entity particleSystem = CreateEntity( "info_particle_system" )
		particleSystem.kv.start_active = 1
		particleSystem.kv.VisibilityFlags = ENTITY_VISIBLE_TO_OWNER
		particleSystem.SetValueForEffectNameKey( FX_EMP_FIELD_1P )

		particleSystem.SetOrigin( origin )
		particleSystem.SetOwner( owner )
		particleSystem.SetParent( titan )
		DispatchSpawn( particleSystem )
		//particleSystem.SetParent( titan, "" )
		particles.append( particleSystem )
	}

	entity particleSystem = CreateEntity( "info_particle_system" )
	particleSystem.kv.start_active = 1
	if ( titan.IsPlayer() )
		particleSystem.kv.VisibilityFlags = (ENTITY_VISIBLE_TO_FRIENDLY | ENTITY_VISIBLE_TO_ENEMY)	// everyone but owner
	else
		particleSystem.kv.VisibilityFlags = ENTITY_VISIBLE_TO_EVERYONE
		particleSystem.SetValueForEffectNameKey( FX_EMP_FIELD )
		particleSystem.SetOwner( owner )
		particleSystem.SetOrigin( origin )
		if(titan.IsTitan()){
			particleSystem.SetOrigin( origin + <0,0,70> )
		}
		
		particleSystem.SetParent( titan )
		DispatchSpawn( particleSystem )
		//particleSystem.SetParent( titan, "" )
		particles.append( particleSystem )

	//titan.SetDangerousAreaRadius( ARC_TITAN_EMP_FIELD_RADIUS )

	OnThreadEnd(
		function () : ( titan, particles )
		{
			if ( IsValid( titan ) )
			{
				StopSoundOnEntity( titan, "EMP_Titan_Electrical_Field" )
				//EnableTitanRodeo( titan ) //Make the arc titan rodeoable now that it is no longer electrified.
				if (file.empTitans.find( titan ) )
					file.empTitans.remove( file.empTitans.find( titan ) )
			}

			foreach ( particleSystem in particles )
			{
				if ( IsValid_ThisFrame( particleSystem ) )
				{
					particleSystem.ClearParent()
					particleSystem.Fire( "StopPlayEndCap" )
					particleSystem.Kill_Deprecated_UseDestroyInstead( 1.0 )
				}
			}
		}
	)


		wait RandomFloat( EMP_DAMAGE_TICK_RATE )

	for(int damagetime = 0 ; damagetime < 10000 ; damagetime++)
	{	
		int ronindamageupcount = expect int(owner.s.empcount) + 1
		origin = titan.GetOrigin()
		RadiusDamage(
			origin,									// center
			owner,									// attacker
			titan,									// inflictor
			DAMAGE_AGAINST_PILOTS*ronindamageupcount,					// damage
			DAMAGE_AGAINST_TITANS*ronindamageupcount,					// damageHeavyArmor
			ARC_TITAN_EMP_FIELD_INNER_RADIUS,		// innerRadius
			ARC_TITAN_EMP_FIELD_RADIUS,				// outerRadius
			SF_ENVEXPLOSION_NO_DAMAGEOWNER,			// flags
			0,										// distanceFromAttacker
			DAMAGE_AGAINST_PILOTS,					// explosionForce
			DF_ELECTRICAL | DF_STOPS_TITAN_REGEN,	// scriptDamageFlags
   			eDamageSourceId.mp_titancore_emp )			// scriptDamageSourceIdentifier
		wait EMP_DAMAGE_TICK_RATE
		if(damagetime == 10000){
			//printt("shut up")
			break
		}
		

	}
	//printt("haha , go on")
	if ( IsValid( titan ) )			//clear
		{	//print("got u")
			StopSoundOnEntity( titan, "EMP_Titan_Electrical_Field" )
			//EnableTitanRodeo( titan ) //Make the arc titan rodeoable now that it is no longer electrified.
			//if (file.empTitans.find( titan ) )
				//file.empTitans.remove( file.empTitans.find( titan ) )
		}

	foreach ( particleSystem in particles )
	{
		if ( IsValid_ThisFrame( particleSystem ) )
		{
			particleSystem.ClearParent()
			particleSystem.Fire( "StopPlayEndCap" )
			particleSystem.Kill_Deprecated_UseDestroyInstead( 1.0 )
		}
	}


}