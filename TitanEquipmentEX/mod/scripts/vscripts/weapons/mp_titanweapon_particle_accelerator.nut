untyped

global function MpTitanWeaponParticleAccelerator_Init

global function OnWeaponPrimaryAttack_titanweapon_particle_accelerator
global function OnWeaponActivate_titanweapon_particle_accelerator
global function OnWeaponCooldown_titanweapon_particle_accelerator
global function OnWeaponStartZoomIn_titanweapon_particle_accelerator
global function OnWeaponStartZoomOut_titanweapon_particle_accelerator

global function OnProjectileCollision_titanweapon_ac

global function PROTO_GetHeatMeterCharge


#if SERVER
global function OnWeaponNpcPrimaryAttack_titanweapon_particle_accelerator
#endif

const ADS_SHOT_COUNT_NORMAL = 3
const ADS_SHOT_COUNT_UPGRADE = 5
const TPAC_PROJECTILE_SPEED = 8000
const TPAC_PROJECTILE_SPEED_NPC = 5000
const LSTAR_LOW_AMMO_WARNING_FRAC = 0.25
const LSTAR_COOLDOWN_EFFECT_1P = $"wpn_mflash_snp_hmn_smokepuff_side_FP"
const LSTAR_COOLDOWN_EFFECT_3P = $"wpn_mflash_snp_hmn_smokepuff_side"
const LSTAR_BURNOUT_EFFECT_1P = $"xo_spark_med"
const LSTAR_BURNOUT_EFFECT_3P = $"xo_spark_med"

const BEAM2	= $"P_wpn_lasercannon_aim"

//const epgexplosion = $"xo_exp_death"

const TPA_ADS_EFFECT_1P = $"P_TPA_electricity_FP"
const TPA_ADS_EFFECT_3P = $"P_TPA_electricity"

const CRITICAL_ENERGY_RESTORE_AMOUNT = 30
const SPLIT_SHOT_CRITICAL_ENERGY_RESTORE_AMOUNT = 8

struct {
	float[ADS_SHOT_COUNT_UPGRADE] boltOffsets = [
		0.0,
		0.022,
		-0.022,
		0.044,
		-0.044,
	]
} file


function MpTitanWeaponParticleAccelerator_Init()
{
	PrecacheParticleSystem( LSTAR_COOLDOWN_EFFECT_1P )
	PrecacheParticleSystem( LSTAR_COOLDOWN_EFFECT_3P )
	PrecacheParticleSystem( LSTAR_BURNOUT_EFFECT_1P )
	PrecacheParticleSystem( LSTAR_BURNOUT_EFFECT_3P )
	PrecacheParticleSystem( TPA_ADS_EFFECT_1P )
	PrecacheParticleSystem( TPA_ADS_EFFECT_3P )
	//PrecacheParticleSystem( epgexplosion )

	#if SERVER
	AddDamageCallbackSourceID( eDamageSourceId.mp_titanweapon_particle_accelerator, OnHit_TitanWeaponParticleAccelerator )
	#endif
}

void function OnWeaponStartZoomIn_titanweapon_particle_accelerator( entity weapon )
{
	array<string> mods = weapon.GetMods()
	if ( weapon.HasMod( "fd_split_shot_cost") )
	{
		if ( weapon.HasMod( "pas_ion_weapon_ads" ) )
			mods.append( "fd_upgraded_proto_particle_accelerator_pas" )
		else
			mods.append( "fd_upgraded_proto_particle_accelerator" )
	}
	else
	{
		if ( weapon.HasMod( "pas_ion_weapon_ads" ) )
			mods.append( "proto_particle_accelerator_pas" )
		else
			mods.append( "proto_particle_accelerator" )
	}

	weapon.SetMods( mods )

	#if CLIENT
		entity weaponOwner = weapon.GetWeaponOwner()
		if ( weaponOwner == GetLocalViewPlayer() )
			EmitSoundOnEntity( weaponOwner, "Weapon_Particle_Accelerator_WindUp_1P" )
	#endif
	weapon.PlayWeaponEffectNoCull( TPA_ADS_EFFECT_1P, TPA_ADS_EFFECT_3P, "muzzle_flash" )
	//weapon.PlayWeaponEffectNoCull( $"wpn_arc_cannon_charge_fp", $"wpn_arc_cannon_charge", "muzzle_flash" )
	weapon.EmitWeaponSound( "arc_cannon_charged_loop" )
}

void function OnWeaponStartZoomOut_titanweapon_particle_accelerator( entity weapon )
{
	array<string> mods = weapon.GetMods()
	mods.fastremovebyvalue( "proto_particle_accelerator" )
	mods.fastremovebyvalue( "proto_particle_accelerator_pas" )
	weapon.SetMods( mods )
	//weapon.StopWeaponEffect( $"wpn_arc_cannon_charge_fp", $"wpn_arc_cannon_charge" )
	weapon.StopWeaponEffect( TPA_ADS_EFFECT_1P, TPA_ADS_EFFECT_3P )
	weapon.StopWeaponSound( "arc_cannon_charged_loop" )
}

void function OnWeaponActivate_titanweapon_particle_accelerator( entity weapon )
{
	if ( !( "initialized" in weapon.s ) )
	{
		weapon.s.initialized <- true
	}
	#if SERVER
	entity owner = weapon.GetWeaponOwner()
	owner.SetSharedEnergyRegenDelay( 0.5 )
	#endif
}

function OnWeaponPrimaryAttack_titanweapon_particle_accelerator( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	entity owner = weapon.GetWeaponOwner()
	float zoomFrac = owner.GetZoomFrac()
	if ( zoomFrac < 1 && zoomFrac > 0)
		return 0

	array<string> mods = weapon.GetMods()
	bool inADS = weapon.IsWeaponInAds()
	if(inADS){
		array<string> mods = weapon.GetMods()	
		if(!(mods.contains("proto_particle_accelerator_pas") || mods.contains("proto_particle_accelerator") )){
			string pas = " "
			entity soul = owner.GetTitanSoul()
			if(IsValid(soul)){
				if(SoulHasPassive(soul , ePassives.PAS_ION_WEAPON)){
					pas = "，用的纠缠"
				}
				else if(SoulHasPassive(soul , ePassives.PAS_ION_WEAPON_ADS)){
					pas = "，用的棱镜"
				}
				else if(SoulHasPassive(soul , ePassives.PAS_ION_TRIPWIRE)){
					pas = "，用的零点"
				}
				else if(SoulHasPassive(soul , ePassives.PAS_ION_LASERCANNON)){
					pas = "，用的大炮"
				}
				else if(SoulHasPassive(soul , ePassives.PAS_ION_VORTEX)){
					pas = "，用的135"
				}
			}

			print(owner.GetPlayerName() + "尝试卡了一次离子bug" + pas)
			
		}
			

		if ( weapon.HasMod( "pas_ion_weapon_ads" ) )
			mods.append( "proto_particle_accelerator_pas" )
		else
			mods.append( "proto_particle_accelerator" )
		weapon.SetMods( mods )
	}

	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )
	return FireWeaponPlayerAndNPC( weapon, attackParams, true )
}

#if SERVER
var function OnWeaponNpcPrimaryAttack_titanweapon_particle_accelerator( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )
	return FireWeaponPlayerAndNPC( weapon, attackParams, false )
}
#endif // #if SERVER


function FireWeaponPlayerAndNPC( entity weapon, WeaponPrimaryAttackParams attackParams, bool playerFired )
{
	bool shouldCreateProjectile = false
	if ( IsServer() || weapon.ShouldPredictProjectiles() )
		shouldCreateProjectile = true

	#if CLIENT
		if ( !playerFired )
			shouldCreateProjectile = false
	#endif

	entity owner = weapon.GetWeaponOwner()
    bool inADS = weapon.IsWeaponInAds()
	if(!inADS){
		array<string> mods = weapon.GetMods()
		mods.fastremovebyvalue( "proto_particle_accelerator" )
		mods.fastremovebyvalue( "proto_particle_accelerator_pas" )
		weapon.SetMods( mods )
	}
	int ADS_SHOT_COUNT = weapon.HasMod( "pas_ion_weapon_ads" ) ? 1 : ADS_SHOT_COUNT_NORMAL

	if ( shouldCreateProjectile )
	{
	    int shotCount = inADS ? ADS_SHOT_COUNT : 1
		if(weapon.HasMod( "pas_ion_weapon_ads" )){
			int shotCount = inADS ? 1 : 3
		}

		weapon.ResetWeaponToDefaultEnergyCost()
		int cost = weapon.GetWeaponCurrentEnergyCost()
		int currentEnergy = owner.GetSharedEnergyCount()
		bool outOfEnergy = (currentEnergy < cost) || (currentEnergy == 0)
		if ( !inADS )
		{
			weapon.SetWeaponEnergyCost( 0 )
			shotCount = 1
			if(weapon.HasMod( "pas_ion_weapon_ads" )){
				shotCount = 3
			}

			#if CLIENT
				if ( outOfEnergy )
					FlashEnergyNeeded_Bar( cost )
			#endif
			//Single Shots
			weapon.EmitWeaponSound_1p3p( "Weapon_Particle_Accelerator_Fire_1P", "Weapon_Particle_Accelerator_SecondShot_3P" )
		}
		else if(outOfEnergy){
			weapon.SetWeaponEnergyCost( 0 )
			shotCount = 1
			if(weapon.HasMod( "pas_ion_weapon_ads" )){
				shotCount = 1
				entity player = weapon.GetWeaponOwner()
				if(IsValid(player) && IsAlive(player) && player.IsPlayer()){
					SendHudMessage(player, "能量枯竭！",-1,0.65,255,122,166,1,0,1,0) 
				}
			}

			#if CLIENT
				if ( outOfEnergy )
					FlashEnergyNeeded_Bar( cost )
			#endif
			//Single Shots
			weapon.EmitWeaponSound_1p3p( "Weapon_Particle_Accelerator_Fire_1P", "Weapon_Particle_Accelerator_SecondShot_3P" )
		
		}
		else
		{
			shotCount = ADS_SHOT_COUNT
			if(weapon.HasMod( "pas_ion_weapon_ads" )){

				shotCount = 0
				entity player = weapon.GetWeaponOwner()
				weapon.SetWeaponPrimaryClipCount( max( 0 , weapon.GetWeaponPrimaryClipCount() - 4 ))
				if(IsValid(player))
					thread laserline(player)
			}
			//Split Shots
			weapon.EmitWeaponSound_1p3p( "Weapon_Particle_Accelerator_AltFire_1P", "Weapon_Particle_Accelerator_AltFire_SecondShot_3P" )
		}

		vector attackAngles = VectorToAngles( attackParams.dir )
		vector baseRightVec = AnglesToRight( attackAngles )
		for ( int index = 0; index < shotCount; index++ )
		{	
	
				vector attackVec = attackParams.dir + baseRightVec * file.boltOffsets[index]
				int damageType = damageTypes.largeCaliber | DF_STOPS_TITAN_REGEN
	
				float speed = TPAC_PROJECTILE_SPEED
				if ( owner.IsNPC() )
					speed = TPAC_PROJECTILE_SPEED_NPC
	
				if(weapon.IsWeaponInAds()){
					speed = 20000
				}
	
				entity bolt = weapon.FireWeaponBolt( attackParams.pos, attackVec, speed, damageType, damageType, playerFired, 0 )
				if ( bolt != null )
				{
					//bolt.kv.gravity = -0.1
					bolt.kv.rendercolor = "0 0 0"
					if(weapon.HasMod( "pas_ion_weapon_ads" )){
						string color1 = "54 192 241"
						string color2 = "252 60 73"
	
						bolt.kv.rendercolor = inADS ? color2 : color1
					}
					bolt.kv.renderamt = 0
					bolt.kv.fadedist = 1
				}
			
		}


	}
	return 1
}

void function OnWeaponCooldown_titanweapon_particle_accelerator( entity weapon )
{
	weapon.PlayWeaponEffect( LSTAR_COOLDOWN_EFFECT_1P, LSTAR_COOLDOWN_EFFECT_3P, "SPINNING_KNOB" ) //"DWAY_ROTATE"
	weapon.EmitWeaponSound_1p3p( "LSTAR_VentCooldown", "LSTAR_VentCooldown" )
}

int function PROTO_GetHeatMeterCharge( entity weapon )
{
	if ( !IsValid( weapon ) )
		return 0

	entity owner = weapon.GetWeaponOwner()
	if ( !IsValid( owner ) )
		return 0

	if ( weapon.IsReloading() )
		return 8

	float max = float ( owner.GetWeaponAmmoMaxLoaded( weapon ) )
	float currentAmmo = float ( owner.GetWeaponAmmoLoaded( weapon ) )

	float crosshairSegments = 8.0
	return int ( GraphCapped( currentAmmo, max, 0.0, 0.0, crosshairSegments ) )
}

#if SERVER
void function OnHit_TitanWeaponParticleAccelerator( entity victim, var damageInfo )
{
	entity inflictor = DamageInfo_GetInflictor( damageInfo )
	if ( !IsValid( inflictor ) )
		return
	if ( !inflictor.IsProjectile() )
		return

	entity attacker = DamageInfo_GetAttacker( damageInfo )

	if ( !IsValid( attacker ) || attacker.IsProjectile() ) //Is projectile check is necessary for when the original attacker is no longer valid it becomes the projectile.
		return

	if ( attacker.GetSharedEnergyTotal() <= 0 )
		return

	if ( attacker.GetTeam() == victim.GetTeam() )
		return

	entity soul = attacker.GetTitanSoul()
	if ( !IsValid( soul ) )
		return

	if ( ( IsSingleplayer() || SoulHasPassive( soul, ePassives.PAS_ION_WEAPON ) )  )			//ION equipment1
	{
			array<string> mods = inflictor.ProjectileGetMods()
			if ( mods.contains( "proto_particle_accelerator" ) )
				attacker.AddSharedEnergy( 2*SPLIT_SHOT_CRITICAL_ENERGY_RESTORE_AMOUNT )
			else
				attacker.AddSharedEnergy( 2*CRITICAL_ENERGY_RESTORE_AMOUNT )

			if(IsCriticalHit( attacker, victim, DamageInfo_GetHitBox( damageInfo ), DamageInfo_GetDamage( damageInfo ), DamageInfo_GetDamageType( damageInfo ) )){
				DamageInfo_ScaleDamage(damageInfo , 3)
			}
	}



}
#endif

void function OnProjectileCollision_titanweapon_ac( entity projectile, vector pos, vector normal, entity hitEnt, int hitbox, bool isCritical )
{
	#if SERVER
		entity player = projectile.GetOwner()
		if(!IsValid(player))
			return

		entity soul = player.GetTitanSoul()
		if(!IsValid(soul))
			return
			
		/*if(SoulHasPassive(soul , ePassives.PAS_ION_WEAPON_ADS) && projectile.GetProjectileWeaponSettingBool( eWeaponVar.is_burn_mod )){
			Explosion(
				pos ,
				null,
				projectile.GetOwner(), 
				90, 
				650,
				100,
				250, 
				SF_ENVEXPLOSION_NOSOUND_FOR_ALLIES, 
				pos,
				100,
				damageTypes.explosive, 
				eDamageSourceId.mp_titanweapon_particle_accelerator,
				ARC_CANNON_FX_TABLE)
		}*/
			
				
	#endif
}


/*
void function CreateSplashDamage(vector startpos ,vector distancelimit ,entity owner) 
{

		//vector startpos = expect vector (startpos)
	vector distancelimit = startpos + distancelimit //should be smth like shootdirection*1000

	vector traceend = TraceLine(startpos,distancelimit,null, TRACE_MASK_SHOT, TRACE_COLLISION_GROUP_NONE).endPos

	float distance = pow((pow(startpos.x - traceend.x,2))+(pow(startpos.y - traceend.y,2))+(pow(startpos.z - traceend.z,2)),0.5)
	float waittime = distance /1000 //aproximate time of impact based on distance
	wait waittime

	entity ExplosionEnt = CreatePhysExplosion(traceend,200, PHYS_EXPLOSION_LARGE, 11 )
	if(owner != null){
		Explosion(
		traceend,
		owner,
		ExplosionEnt,
		50, //pilot damage
		100, //titan damage
		200, //radius
		200, //radius (needs to be same)
		SF_ENVEXPLOSION_NOSOUND_FOR_ALLIES,
		traceend,
		100,
		damageTypes.explosive,
		eDamageSourceId.mp_weapon_epg,
		BALL_LIGHTNING_FX_TABLE) //its just an epmty effect i think , wich is good , because the epg already has an explosion effect
	}

}*/



void function laserline(entity player)
{
	vector traceStart = player.EyePosition()
	vector prevViewVec = player.GetPlayerOrNPCViewVector()
	vector preforce = Normalize(prevViewVec)
	vector atkpos = traceStart + 30*preforce
	vector traceEnd = traceStart + ( preforce*5000 )
    
	thread spswordline2laser(player ,atkpos ,traceEnd )
}

void function spswordline2laser(entity player , vector atkpos , vector traceEnd)
{
    if(!IsValid(player) )
        return

    vector stratpos = atkpos - < 0,0,10>
    vector endpos = traceEnd

    thread cutdelay(player , stratpos , endpos)
   

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
	function() : (beamFX,cpEnd,player, mover1 , mover2 ,  atkpos,stratpos,endpos)
		{
			
			EmitSoundAtPosition( TEAM_ANY, atkpos, "Wpn_LaserTripMine_FirstConnect" )
            CreateShake( atkpos, 5, 12,0.2, 300 )
           
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

void function cutdelay(entity player ,vector stratpos ,vector endpos)
{
    if(IsValid(player)){
       	vector p1Org = stratpos
		vector p2Org = endpos

		float pylonDist = Length( p2Org - p1Org )
		vector laserOBBOrigin = ( p1Org + p2Org ) / 2.0
		vector laserOOBAngles = VectorToAngles( p2Org - p1Org )
		vector laserOOBMins = < pylonDist * -0.5, -10.0, -10.0 >
		vector laserOOBMaxs = < pylonDist * 0.5, 10.0, 10.0 >
		array<entity> enemies = GetPlayerArrayOfEnemies( player.GetTeam() )
		enemies.extend( GetNPCArrayOfEnemies( player.GetTeam() ) )

		foreach ( enemy in enemies )
		{
			if ( !IsAlive( enemy ) )
				continue

			if ( OBBIntersectsOBB( laserOBBOrigin, laserOOBAngles, laserOOBMins, laserOOBMaxs, enemy.GetOrigin(), <0.0,0.0,0.0>, enemy.GetBoundingMins(), enemy.GetBoundingMaxs(), 0.0 ) )
			{
				enemy.TakeDamage( 1000 ,player ,null, {damageSourceId = eDamageSourceId.laserliteex})				
			}
		}
    }
}

void function cutdelay1(entity player ,vector stratpos ,vector endpos)
{
    if(IsValid(player)){
        array <entity> targets = Getentinline1(player , stratpos , endpos)
        foreach(ent in targets){
			if(ent.GetTeam() != player.GetTeam())
            	ent.TakeDamage( 1200 ,player ,null, {damageSourceId = eDamageSourceId.mp_titanweapon_particle_accelerator})
				RadiusDamage(
				ent.GetOrigin(),											// center
				player,											// attacker
				player,										// inflictor
				100,								// damage
				800,					// damageHeavyArmor
				100,						// innerRadius
				200,						// outerRadius
				SF_ENVEXPLOSION_NO_DAMAGEOWNER,					// flags
				0,												// distanceFromAttacker
				0,												// explosionForce
				DF_ELECTRICAL,									// scriptDamageFlags
				eDamageSourceId.mp_titanweapon_particle_accelerator )	// scriptDamageSourceIdentifier
        }     
    }
}



array <entity> function Getentinline1(entity player , vector startpos , vector endpos)
{
    array <entity> targets = []
    vector goonpos = startpos
    for(int searchtimes = 0 ; searchtimes <= 100 ;searchtimes++){
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