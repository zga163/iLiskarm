
global function MpTitanWeaponArcWave_Init
global function OnWeaponPrimaryAttack_titanweapon_arc_wave
global function OnWeaponActivate_titanweapon_arcwave
global function OnWeaponDeactivate_titanweapon_arcwave
global function OnWeaponAttemptOffhandSwitch_titanweapon_arc_wave

#if SERVER
global function OnWeaponNpcPrimaryAttack_titanweapon_arc_wave
global function CreateDamageInflictorHelper
global function CreateOncePerTickDamageInflictorHelper
global function ArcWaveOnDamage
global function AddArcWaveDamageCallback


const BEAM3	= $"P_wpn_charge_tool_beam"


struct
{
	array< void functionref( entity, var ) > arcWaveDamageCallbacks = []
} file

#endif

const asset ARCWAVE_FX_SCREEN = $"P_elec_screen"

void function MpTitanWeaponArcWave_Init()
{
	PrecacheParticleSystem( $"P_arcwave_exp" )
	PrecacheParticleSystem( $"P_arcwave_exp_charged" )
	PrecacheParticleSystem( ARCWAVE_FX_SCREEN )

	#if SERVER
		AddDamageCallbackSourceID( eDamageSourceId.mp_titanweapon_arc_wave, ArcWaveOnDamage )
	#elseif CLIENT
		AddLocalPlayerTookDamageCallback( eDamageSourceId.mp_titanweapon_arc_wave, ClArcWaveOnDamage )
	#endif
}

void function OnWeaponActivate_titanweapon_arcwave( entity weapon )
{
	entity offhandWeapon = weapon.GetWeaponOwner().GetOffhandWeapon( OFFHAND_MELEE )
	if ( IsValid( offhandWeapon ) && offhandWeapon.HasMod( "super_charged" ) )
	{
		if ( weapon.HasMod( "modelset_prime" ) )
			weapon.PlayWeaponEffectNoCull( SWORD_GLOW_PRIME_FP, SWORD_GLOW_PRIME, "sword_edge" )
		else
			weapon.PlayWeaponEffectNoCull( SWORD_GLOW_FP, SWORD_GLOW, "sword_edge" )
	}
}

void function OnWeaponDeactivate_titanweapon_arcwave( entity weapon )
{
	if ( weapon.HasMod( "modelset_prime" ) )
		weapon.StopWeaponEffect( SWORD_GLOW_PRIME_FP, SWORD_GLOW_PRIME )
	else
		weapon.StopWeaponEffect( SWORD_GLOW_FP, SWORD_GLOW )
}

var function OnWeaponPrimaryAttack_titanweapon_arc_wave( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	entity weaponOwner = weapon.GetWeaponOwner()
	if ( weaponOwner.IsPhaseShifted() )
		return 0

	bool shouldPredict = weapon.ShouldPredictProjectiles()
	#if CLIENT
		if ( !shouldPredict )
			return 1
	#endif

	const float FUSE_TIME = 99.0
	entity projectile = weapon.FireWeaponGrenade( attackParams.pos, attackParams.dir, < 0,0,0 >, FUSE_TIME, damageTypes.projectileImpact, damageTypes.explosive, shouldPredict, true, true )
	if ( IsValid( projectile ) )
	{
		entity owner = weapon.GetWeaponOwner()
		if ( owner.IsPlayer() && PlayerHasPassive( owner, ePassives.PAS_SHIFT_CORE ) )
		{
			#if SERVER
				projectile.proj.isChargedShot = true
			#endif
		}

		if ( owner.IsPlayer() )
			PlayerUsedOffhand( owner, weapon )

		#if SERVER
			thread BeginEmpWave( projectile, attackParams )
		#endif
	}

	if(TitanCoreInUse(weaponOwner) && SoulHasPassive(weaponOwner.GetTitanSoul() , ePassives.PAS_RONIN_ARCWAVE)){
		entity soul = weaponOwner.GetTitanSoul()
		
		float curTime = Time()
		float remainingTime = soul.GetCoreChargeExpireTime() - curTime

		if ( remainingTime > 0 )
		{
			const float USE_TIME = 1.5
			

			remainingTime = max( remainingTime - USE_TIME, 0 )
			float startTime = soul.GetCoreChargeStartTime()
			float duration = soul.GetCoreUseDuration()

			soul.SetTitanSoulNetFloat( "coreExpireFrac", remainingTime / duration )
			soul.SetTitanSoulNetFloatOverTime( "coreExpireFrac", 0.0, remainingTime )
			soul.SetCoreChargeExpireTime( remainingTime + curTime )
		}
	}

	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_min_to_fire )
}

#if SERVER
void function AddArcWaveDamageCallback( void functionref( entity, var ) callback )
{
	file.arcWaveDamageCallbacks.append( callback )
}

void function BeginEmpWave( entity projectile, WeaponPrimaryAttackParams attackParams )
{
	projectile.EndSignal( "OnDestroy" )
	projectile.SetAbsOrigin( projectile.GetOrigin() )
	projectile.SetAbsAngles( projectile.GetAngles() )
	projectile.SetVelocity( Vector( 0, 0, 0 ) )
	projectile.StopPhysics()
	projectile.SetTakeDamageType( DAMAGE_NO )
	projectile.Hide()
	projectile.NotSolid()
	projectile.e.onlyDamageEntitiesOnce = true
	EmitSoundOnEntity( projectile, "arcwave_tail_3p" )
	waitthread WeaponAttackWave( projectile, 0, projectile, attackParams.pos, attackParams.dir, CreateEmpWaveSegment )
	StopSoundOnEntity( projectile, "arcwave_tail_3p" )
	projectile.Destroy()
}

var function OnWeaponNpcPrimaryAttack_titanweapon_arc_wave( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	const float FUSE_TIME = 99.0
	entity projectile = weapon.FireWeaponGrenade( attackParams.pos, attackParams.dir, < 0,0,0 >, FUSE_TIME, damageTypes.projectileImpact, damageTypes.explosive, false, true, true )
	if ( IsValid( projectile ) )
		thread BeginEmpWave( projectile, attackParams )

	return 1
}
#endif

#if SERVER
bool function CreateEmpWaveSegment( entity projectile, int projectileCount, entity inflictor, entity movingGeo, vector pos, vector angles, int waveCount )
{
	projectile.SetOrigin( pos )
	entity player = projectile.GetOwner()
	entity soul = player.GetTitanSoul()

	float damageScalar
	int fxId
	int fxId2
	if ( !projectile.proj.isChargedShot )
	{
		if(IsValid(soul) && SoulHasPassive(soul , ePassives.PAS_RONIN_ARCWAVE)){
			damageScalar = 1.0			
			fxId = GetParticleSystemIndex( $"P_arcwave_exp_charged" )
			
			StartParticleEffectInWorld( fxId, pos, angles )
			
		}
		else{
			damageScalar = 1.0
			fxId = GetParticleSystemIndex( $"P_arcwave_exp" )
			StartParticleEffectInWorld( fxId, pos, angles )
		}
	}
	else
	{	
		if(IsValid(soul) && SoulHasPassive(soul , ePassives.PAS_RONIN_ARCWAVE)){
			damageScalar = 1.8		
			
			fxId2 = GetParticleSystemIndex( $"impact_arc_cannon_titan" )
			
			StartParticleEffectInWorld( fxId2, pos, angles )
			thread arcwaveandcoredamage(player , pos , angles)
			thread swordline3arc(player , pos , pos + <0,0,1300> ,pos + <0,0,100>, 1)  
		}
		else{
			damageScalar = 1.5
			fxId = GetParticleSystemIndex( $"P_arcwave_exp_charged" )
			StartParticleEffectInWorld( fxId, pos, angles )
		}
	}
	
	int pilotDamage = int( float( projectile.GetProjectileWeaponSettingInt( eWeaponVar.damage_near_value ) ) * damageScalar )
	int titanDamage = int( float( projectile.GetProjectileWeaponSettingInt( eWeaponVar.damage_near_value_titanarmor ) ) * damageScalar )

	RadiusDamage(
		pos,
		projectile.GetOwner(), //attacker
		inflictor, //inflictor
		pilotDamage,
		titanDamage,
		112, // inner radius
		112, // outer radius
		SF_ENVEXPLOSION_NO_DAMAGEOWNER | SF_ENVEXPLOSION_MASK_BRUSHONLY | SF_ENVEXPLOSION_NO_NPC_SOUND_EVENT,
		0, // distanceFromAttacker
		0, // explosionForce
		DF_ELECTRICAL | DF_STOPS_TITAN_REGEN,
		eDamageSourceId.mp_titanweapon_arc_wave )

	return true
}

const FX_EMP_BODY_HUMAN			= $"P_emp_body_human"
const FX_EMP_BODY_TITAN			= $"P_emp_body_titan"

void function ArcWaveOnDamage( entity ent, var damageInfo )
{
	vector pos = DamageInfo_GetDamagePosition( damageInfo )
	entity attacker = DamageInfo_GetAttacker( damageInfo )

	EmitSoundOnEntity( ent, ARC_CANNON_TITAN_SCREEN_SFX )

	if ( ent.IsPlayer() || ent.IsNPC() )
	{
		//Run any custom callbacks for arc wave damage.
		foreach ( callback in file.arcWaveDamageCallbacks )
		{
			callback( ent, damageInfo )
		}

		entity entToSlow = ent
		entity soul = ent.GetTitanSoul()

		if ( soul != null )
			entToSlow = soul

		StatusEffect_AddTimed( entToSlow, eStatusEffect.move_slow, 0.5, 2.0, 1.0 )
		StatusEffect_AddTimed( entToSlow, eStatusEffect.dodge_speed_slow, 0.5, 2.0, 1.0 )
	}

	string tag = ""
	asset effect

	if ( ent.IsTitan() )
	{
		tag = "exp_torso_front"
		effect = FX_EMP_BODY_TITAN
	}
	else if ( ChestFocusTarget( ent ) )
	{
		tag = "CHESTFOCUS"
		effect = FX_EMP_BODY_HUMAN
	}
	else if ( IsAirDrone( ent ) )
	{
		tag = "HEADSHOT"
		effect = FX_EMP_BODY_HUMAN
	}
	else if ( IsGunship( ent ) )
	{
		tag = "ORIGIN"
		effect = FX_EMP_BODY_TITAN
	}

	if ( tag != "" )
	{
		float duration = 2.0
		thread EMP_FX( effect, ent, tag, duration )
	}

	if ( ent.IsTitan() )
	{
		if ( ent.IsPlayer() )
		{
		 	EmitSoundOnEntityOnlyToPlayer( ent, ent, "titan_energy_bulletimpact_3p_vs_1p" )
			EmitSoundOnEntityExceptToPlayer( ent, ent, "titan_energy_bulletimpact_3p_vs_3p" )
		}
		else
		{
		 	EmitSoundOnEntity( ent, "titan_energy_bulletimpact_3p_vs_3p" )
		}
	}
	else
	{
		if ( ent.IsPlayer() )
		{
		 	EmitSoundOnEntityOnlyToPlayer( ent, ent, "flesh_lavafog_deathzap_3p" )
			EmitSoundOnEntityExceptToPlayer( ent, ent, "flesh_lavafog_deathzap_1p" )
		}
		else
		{
		 	EmitSoundOnEntity( ent, "flesh_lavafog_deathzap_1p" )
		}
	}
}

bool function ChestFocusTarget( entity ent )
{
	if ( IsSpectre( ent ) )
		return true
	if ( IsStalker( ent ) )
		return true
	if ( IsSuperSpectre( ent ) )
		return true
	if ( IsGrunt( ent ) )
		return true
	if ( IsPilot( ent ) )
		return true

	return false
}

entity function CreateDamageInflictorHelper( float lifetime )
{
	entity inflictor = CreateEntity( "info_target" )
	DispatchSpawn( inflictor )
	inflictor.e.onlyDamageEntitiesOnce = true
	if ( lifetime > 0.0 )
		thread DelayedDestroyDamageInflictorHelper( inflictor, lifetime )
	return inflictor
}

entity function CreateOncePerTickDamageInflictorHelper( float lifetime )
{
	entity inflictor = CreateEntity( "info_target" )
	DispatchSpawn( inflictor )
	inflictor.e.onlyDamageEntitiesOncePerTick = true
	if ( lifetime > 0.0 )
		thread DelayedDestroyDamageInflictorHelper( inflictor, lifetime )
	return inflictor
}


void function DelayedDestroyDamageInflictorHelper( entity inflictor, float lifetime )
{
	inflictor.EndSignal( "OnDestroy" )
	wait lifetime
	inflictor.Destroy()
}
#endif

#if CLIENT
void function ClArcWaveOnDamage( float damage, vector damageOrigin, int damageType, int damageSourceId, entity attacker )
{
	entity player = GetLocalViewPlayer()
	entity cockpit = player.GetCockpit()
	if ( IsValid( cockpit ) )
		StartParticleEffectOnEntity( cockpit, GetParticleSystemIndex( ARCWAVE_FX_SCREEN ), FX_PATTACH_ABSORIGIN_FOLLOW, -1 )
}
#endif

bool function OnWeaponAttemptOffhandSwitch_titanweapon_arc_wave( entity weapon )
{
	entity weaponOwner = weapon.GetWeaponOwner()
	if ( weaponOwner.IsPhaseShifted() )
		return false

	return true
}

void function arcwaveandcoredamage(entity player , vector pos , vector angles)
{
	for(int i = 1 ;i <= 20 ;i++)
	{	
		if(IsValid(player) && IsAlive(player)){
			RadiusDamage(
			pos,
			player, //attacker
			null, //inflictor
			10,
			35,
			105, // inner radius
			105, // outer radius
			SF_ENVEXPLOSION_NO_DAMAGEOWNER | SF_ENVEXPLOSION_MASK_BRUSHONLY | SF_ENVEXPLOSION_NO_NPC_SOUND_EVENT,
			0, // distanceFromAttacker
			0, // explosionForce
			DF_ELECTRICAL | DF_STOPS_TITAN_REGEN,
			eDamageSourceId.mp_titanweapon_arc_wave )
		}
		wait 0.1
	}



}



void function swordline3arc(entity player , vector stratpos , vector endpos,vector playerpos,int times)
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
			
			//EmitSoundAtPosition( TEAM_ANY, playerpos, "ronin_sword_melee_3p" )

			
           
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