//TODO: FIX REARM WHILE FIRING SALVO ROCKETS

global function OnWeaponPrimaryAttack_titanability_rearm
global function OnWeaponAttemptOffhandSwitch_titanability_rearm

global function SonarSmoke
#if SERVER
global function OnWeaponNPCPrimaryAttack_titanability_rearm
#endif

var function OnWeaponPrimaryAttack_titanability_rearm( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	entity weaponOwner = weapon.GetWeaponOwner()
	entity soul = weaponOwner.GetTitanSoul()
	if ( weaponOwner.IsPlayer() )
		PlayerUsedOffhand( weaponOwner, weapon )

	entity ordnance = weaponOwner.GetOffhandWeapon( OFFHAND_RIGHT )
	if ( IsValid( ordnance ) )
	{
		ordnance.SetWeaponPrimaryClipCount( ordnance.GetWeaponPrimaryClipCountMax() )
		#if SERVER
		if ( ordnance.IsChargeWeapon() )
			ordnance.SetWeaponChargeFractionForced( 0 )
		#endif
	}
	entity main = weaponOwner.GetMainWeapons()[0]
	if ( IsValid( main ) && SoulHasPassive( soul, ePassives.PAS_VANGUARD_REARM ) )
	{
		main.SetWeaponPrimaryClipCount( main.GetWeaponPrimaryClipCountMax() )
		weaponOwner.GetTitanSoul().SetShieldHealth(weaponOwner.GetTitanSoul().GetShieldHealthMax())
		#if SERVER
		if ( main.IsChargeWeapon() )
		main.SetWeaponChargeFractionForced( 0 )
		thread SonarSmoke( weaponOwner, weaponOwner )
		
		#endif
	}
	entity defensive = weaponOwner.GetOffhandWeapon( OFFHAND_LEFT )
	if ( IsValid( defensive ) )
		defensive.SetWeaponPrimaryClipCount( defensive.GetWeaponPrimaryClipCountMax() )
	#if SERVER
	if ( weaponOwner.IsPlayer() )//weapon.HasMod( "rapid_rearm" ) &&  )
			weaponOwner.Server_SetDodgePower( 100.0 )
	#endif
	weapon.SetWeaponPrimaryClipCount( 0 )//used to skip the fire animation
	
	return 0
}

void function SonarSmoke( entity weaponOwner, entity owner )
{
	entity inflictor = CreateScriptMover( weaponOwner.GetOrigin() )
	SetTeam( inflictor, weaponOwner.GetTeam() )
	inflictor.SetOwner( owner )
	thread TitanSonarSmokescreen( inflictor, owner )
	wait 5
	inflictor.Destroy()
}

void function TitanSonarSmokescreen( entity ent, entity owner )
{	
	entity soul = owner.GetTitanSoul()
	SmokescreenStruct smokescreen
	smokescreen.isElectric = true
	smokescreen.ownerTeam = ent.GetTeam()
	smokescreen.attacker = owner
	smokescreen.inflictor = ent
	smokescreen.weaponOrProjectile = ent
	smokescreen.damageInnerRadius = 320.0
	smokescreen.damageOuterRadius = 375.0
	smokescreen.dpsPilot = 50
	smokescreen.dpsTitan = 450
	if(SoulHasPassive(soul , ePassives.PAS_VANGUARD_CORE5))
		smokescreen.dpsTitan = 1350
	

	smokescreen.damageDelay = 1.0
	smokescreen.deploySound1p = SFX_SMOKE_DEPLOY_BURN_1P
	smokescreen.deploySound3p = SFX_SMOKE_DEPLOY_BURN_3P

	vector eyeAngles = <0.0, ent.EyeAngles().y, 0.0>
	smokescreen.angles = eyeAngles

	vector forward = AnglesToForward( eyeAngles )
	vector testPos = ent.GetOrigin() + forward * 240.0
	vector basePos = testPos

	float trace = TraceLineSimple( ent.EyePosition(), testPos, ent )
	if ( trace != 1.0 )
		basePos = ent.GetOrigin()

	float fxOffset = 200.0
	float fxHeightOffset = 148.0

	smokescreen.origin = basePos

	smokescreen.fxOffsets = [ < -fxOffset, 0.0, 20.0>,
							  <0.0, fxOffset, 20.0>,
							  <0.0, -fxOffset, 20.0>,
							  <0.0, 0.0, fxHeightOffset>,
							  < -fxOffset, 0.0, fxHeightOffset> ]

	Smokescreen( smokescreen )
}

#if SERVER
var function OnWeaponNPCPrimaryAttack_titanability_rearm( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	return OnWeaponPrimaryAttack_titanability_rearm( weapon, attackParams )
}
#endif

bool function OnWeaponAttemptOffhandSwitch_titanability_rearm( entity weapon )
{

	bool allowSwitch = true
	entity weaponOwner = weapon.GetWeaponOwner()

	entity ordnance = weaponOwner.GetOffhandWeapon( OFFHAND_RIGHT )
	entity defensive = weaponOwner.GetOffhandWeapon( OFFHAND_LEFT )

	if ( ordnance.GetWeaponPrimaryClipCount() == ordnance.GetWeaponPrimaryClipCountMax() && defensive.GetWeaponPrimaryClipCount() == defensive.GetWeaponPrimaryClipCountMax() )
		allowSwitch = false

	if ( ordnance.IsBurstFireInProgress() )
		allowSwitch = false

	if ( ordnance.IsChargeWeapon() && ordnance.GetWeaponChargeFraction() > 0.0 )
		allowSwitch = true

	//if ( weapon.HasMod( "rapid_rearm" ) )
	//{
		if ( weaponOwner.GetDodgePower() < 100 )
			allowSwitch = true
	//}

	if( !allowSwitch && IsFirstTimePredicted() )
	{
		// Play SFX and show some HUD feedback here...
		#if CLIENT
			AddPlayerHint( 1.0, 0.25, $"rui/titan_loadout/tactical/titan_tactical_rearm", "#WPN_TITANABILITY_REARM_ERROR_HINT" )
			if ( weaponOwner == GetLocalViewPlayer() )
				EmitSoundOnEntity( weapon, "titan_dryfire" )
		#endif
	}

	return allowSwitch
}

//UPDATE TO RESTORE CHARGE FOR THE MTMS