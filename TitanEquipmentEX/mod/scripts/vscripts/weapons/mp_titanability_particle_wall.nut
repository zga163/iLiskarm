untyped

global function MpTitanabilityBubbleShield_Init

global function OnWeaponPrimaryAttack_particle_wall

#if SERVER
global function OnWeaponNpcPrimaryAttack_particle_wall
#endif // #if SERVER

global const SP_PARTICLE_WALL_DURATION = 8.0
global const MP_PARTICLE_WALL_DURATION = 6.0

function MpTitanabilityBubbleShield_Init()
{
	RegisterSignal( "RegenAmmo" )

    #if CLIENT
	    PrecacheHUDMaterial( $"vgui/hud/dpad_bubble_shield_charge_0" )
	    PrecacheHUDMaterial( $"vgui/hud/dpad_bubble_shield_charge_1" )
	    PrecacheHUDMaterial( $"vgui/hud/dpad_bubble_shield_charge_2" )
    #endif
}

var function OnWeaponPrimaryAttack_particle_wall( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	entity weaponOwner = weapon.GetWeaponOwner()
	if ( weaponOwner.IsPlayer() )
		PlayerUsedOffhand( weaponOwner, weapon )

#if SERVER
	float duration
	if ( IsSingleplayer() )
		duration = SP_PARTICLE_WALL_DURATION
	else
		duration = MP_PARTICLE_WALL_DURATION

	entity soul = weapon.GetWeaponOwner().GetTitanSoul()
	if( SoulHasPassive( soul, ePassives.PAS_TONE_WALL) )
	{	
		weaponOwner.s.isskill <- true
		//soul.nextRegenTime = Time()
		thread CreateParentedBubbleShield(weaponOwner,attackParams.pos - <0,0,150>, attackParams.dir ,6)

	}
	else
		CreateParticleWallFromOwner( weapon.GetWeaponOwner(), duration, attackParams )

#endif

	return weapon.GetWeaponInfoFileKeyField( "ammo_per_shot" )
}

#if SERVER
var function OnWeaponNpcPrimaryAttack_particle_wall( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	float duration
	if ( IsSingleplayer() )
		duration = SP_PARTICLE_WALL_DURATION
	else
		duration = MP_PARTICLE_WALL_DURATION
		


		CreateParticleWallFromOwner( weapon.GetWeaponOwner(), duration, attackParams )
		return weapon.GetWeaponInfoFileKeyField( "ammo_per_shot" )
	

}
#endif // #if SERVER


void function TitanPersonalShield_Threaded( entity owner, int vortexHealth, float duration )
{
	owner.EndSignal( "OnDestroy" )
	owner.EndSignal( "OnDeath" )
	owner.EndSignal( "DisembarkingTitan" )
	owner.EndSignal( "TitanEjectionStarted" )


	if ( duration <= 0 )
		return
	//------------------------------
	// Shield vars
	//------------------------------
	vector origin = owner.GetOrigin()
	vector angles = VectorToAngles( owner.GetPlayerOrNPCViewVector() )
	angles.x = 0
	angles.z = 0

	float shieldWallRadius = SHIELD_WALL_RADIUS // 90
	asset shieldFx = SHIELD_WALL_FX
	float wallFOV = SHIELD_WALL_FOV
	float shieldWallHeight = SHIELD_WALL_RADIUS * 2

	//------------------------------
	// Vortex to block the actual bullets
	//------------------------------
	entity vortexSphere = CreateShieldWithSettings( origin + < 0, 0, -64 >, angles, SHIELD_WALL_RADIUS, SHIELD_WALL_RADIUS * 2, SHIELD_WALL_FOV, duration, vortexHealth, SHIELD_WALL_FX )
	thread DrainHealthOverTime( vortexSphere, vortexSphere.e.shieldWallFX, duration )

	//vortexSphere.SetAngles( angles ) // viewvec?
	//vortexSphere.SetOrigin( origin + Vector( 0, 0, shieldWallRadius - 64 ) )

	// update fx origin
	//vortexSphere.e.shieldWallFX.SetOrigin( Vector( 0, 0, shieldWallHeight ) )

	//-----------------------
	// Attach shield to owner
	//------------------------
	entity mover = CreateScriptMover()
	mover.SetOrigin( origin )
	mover.SetAngles( angles )

	vortexSphere.SetParent( mover )

	vortexSphere.EndSignal( "OnDestroy" )
	Assert( IsAlive( owner ) )
	owner.EndSignal( "ArcStunned" )
	mover.EndSignal( "OnDestroy" )
	#if MP
	vortexSphere.e.shieldWallFX.EndSignal( "OnDestroy" )
	#endif

	OnThreadEnd(
	function() : ( owner, mover, vortexSphere )
		{
			if ( IsValid( owner ) )
			{
				owner.kv.defenseActive = false
			}

			StopShieldWallFX( vortexSphere )

			if ( IsValid( vortexSphere ) )
				vortexSphere.Destroy()

			if ( IsValid( mover ) )
			{
				//PlayFX( SHIELD_BREAK_FX, mover.GetOrigin(), mover.GetAngles() )
				mover.Destroy()
			}
		}
	)

	owner.kv.defenseActive = true

	for ( ;; )
	{
		Assert( IsAlive( owner ) )
		UpdateShieldPosition( mover, owner )

		#if MP
		if ( IsCloaked( owner ) )
			EntFireByHandle( vortexSphere.e.shieldWallFX, "Stop", "", 0, null, null )
		else
			EntFireByHandle( vortexSphere.e.shieldWallFX, "Start", "", 0, null, null )
		#endif
	}
}

void function UpdateShieldPosition( entity mover, entity owner )
{	
	vector lookforvec = Normalize(owner.GetViewVector())
	vector newangle = VectorToAngles(lookforvec)

	mover.NonPhysicsMoveTo( owner.GetOrigin(), 0.2, 0.0, 0.0 )
	mover.SetAngles(newangle)
	WaitFrame()
}