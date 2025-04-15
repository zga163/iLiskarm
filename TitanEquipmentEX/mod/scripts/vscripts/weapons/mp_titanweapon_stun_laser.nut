global function MpTitanWeaponStunLaser_Init

global function OnWeaponAttemptOffhandSwitch_titanweapon_stun_laser
global function OnWeaponPrimaryAttack_titanweapon_stun_laser

#if SERVER
global function OnWeaponNPCPrimaryAttack_titanweapon_stun_laser
global function AddStunLaserHealCallback
#endif

const FX_EMP_BODY_HUMAN			= $"P_emp_body_human"
const FX_EMP_BODY_TITAN			= $"P_emp_body_titan"
const FX_SHIELD_GAIN_SCREEN		= $"P_xo_shield_up"
const SHIELD_BODY_FX			= $"P_xo_armor_body_CP"

struct
{
	void functionref(entity,entity,int) stunHealCallback
} file

void function MpTitanWeaponStunLaser_Init()
{

	PrecacheParticleSystem( FX_SHIELD_GAIN_SCREEN )
	PrecacheParticleSystem( SHIELD_BODY_FX )

	#if SERVER
		AddDamageCallbackSourceID( eDamageSourceId.mp_titanweapon_stun_laser, StunLaser_DamagedTarget )
	#endif

	#if CLIENT
		AddEventNotificationCallback( eEventNotifications.VANGUARD_ShieldGain, Vanguard_ShieldGain )
	#endif
}

bool function OnWeaponAttemptOffhandSwitch_titanweapon_stun_laser( entity weapon )
{
	entity owner = weapon.GetWeaponOwner()
	int curCost = weapon.GetWeaponCurrentEnergyCost()
	bool canUse = owner.CanUseSharedEnergy( curCost )

	#if CLIENT
		if ( !canUse )
			FlashEnergyNeeded_Bar( curCost )
	#endif
	return canUse
}

var function OnWeaponPrimaryAttack_titanweapon_stun_laser( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	#if CLIENT
		if ( !weapon.ShouldPredictProjectiles() )
			return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
	#endif

	entity weaponOwner = weapon.GetWeaponOwner()
	if ( weaponOwner.IsPlayer() )
		PlayerUsedOffhand( weaponOwner, weapon )

	ShotgunBlast( weapon, attackParams.pos, attackParams.dir, 1, DF_GIB | DF_EXPLOSION )
	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )
	weapon.SetWeaponChargeFractionForced(1.0)
	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
}
#if SERVER
var function OnWeaponNPCPrimaryAttack_titanweapon_stun_laser( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	return OnWeaponPrimaryAttack_titanweapon_stun_laser( weapon, attackParams )
}

void function StunLaser_DamagedTarget( entity target, var damageInfo )
{
	entity attacker = DamageInfo_GetAttacker( damageInfo )
	if ( attacker == target )
	{
		DamageInfo_SetDamage( damageInfo, 0 )
		return
	}

	if ( attacker.GetTeam() == target.GetTeam() )
	{
		DamageInfo_SetDamage( damageInfo, 0 )
		entity attackerSoul = attacker.GetTitanSoul()
		entity weapon = attacker.GetOffhandWeapon( OFFHAND_LEFT )
		if ( !IsValid( weapon ) )
			return
		bool hasEnergyTransfer = weapon.HasMod( "energy_transfer" ) || weapon.HasMod( "energy_field_energy_transfer" )
		if ( target.IsTitan() && IsValid( attackerSoul ) && hasEnergyTransfer )
		{	
			PlayerEarnMeter_AddOwnedFrac( target, 0.1 )
			attacker.SetPlayerGameStat(PGS_ASSAULT_SCORE, (attacker.GetPlayerGameStat( PGS_ASSAULT_SCORE ) + 1000))
			entity soul = target.GetTitanSoul()
			if ( IsValid( soul ) )
			{
				int shieldRestoreAmount = 750
				if ( SoulHasPassive( attackerSoul, ePassives.PAS_VANGUARD_SHIELD ))
					shieldRestoreAmount = 1250    //int( 1.25 * shieldRestoreAmount )
					

				float shieldAmount = min( soul.GetShieldHealth() + shieldRestoreAmount, soul.GetShieldHealthMax() )
				shieldRestoreAmount = soul.GetShieldHealthMax() - int( shieldAmount )

				soul.SetShieldHealth( shieldAmount )
				attacker.SetPlayerGameStat(PGS_ASSAULT_SCORE, (attacker.GetPlayerGameStat( PGS_ASSAULT_SCORE ) + shieldRestoreAmount/2))

				if ( SoulHasPassive( attackerSoul, ePassives.PAS_VANGUARD_SHIELD ))
					soul.SetShieldHealthMax(min(soul.GetShieldHealthMax()+250 , 5000   ))

				if (SoulHasPassive( attackerSoul, ePassives.PAS_VANGUARD_DOOM ) ){
					attacker.SetPlayerGameStat(PGS_ASSAULT_SCORE, (attacker.GetPlayerGameStat( PGS_ASSAULT_SCORE ) + 750))
					if(GetDoomedState(target)){
						if(target.GetHealth()>2000 ){
							int overhealth = target.GetHealth() - 2000
							UndoomTitan(target,1)
							target.SetHealth(overhealth)
						}
						else{
							target.SetHealth(target.GetHealth()+500   ) 
							thread healtarget(target)
						}
					}
					else{
						target.SetHealth(min(target.GetHealth()+500,target.GetMaxHealth())) 
					}
				}
				else if(SoulHasPassive( soul, ePassives.PAS_VANGUARD_SHIELD )){
					target.GetTitanSoul().SetShieldHealthMax(min(target.GetTitanSoul().GetShieldHealthMax()+250 , 5000   ))
					target.GetTitanSoul().SetShieldHealth(min(target.GetHealth()+1500,target.GetTitanSoul().GetShieldHealthMax()))
				}

				if ( file.stunHealCallback != null && shieldRestoreAmount > 0 )
					file.stunHealCallback( attacker, target, shieldRestoreAmount )
			}
			if ( target.IsPlayer() )
				MessageToPlayer( target, eEventNotifications.VANGUARD_ShieldGain, target )

			if ( attacker.IsPlayer() )
				EmitSoundOnEntityOnlyToPlayer( target, attacker, "EnergySyphon_ShieldGive" )

			float shieldHealthFrac = GetShieldHealthFrac( target )
			if ( shieldHealthFrac < 1.0 )
			{
				int shieldbodyFX = GetParticleSystemIndex( SHIELD_BODY_FX )
				int attachID
				if ( target.IsTitan() )
					attachID = target.LookupAttachment( "exp_torso_main" )
				else
					attachID = target.LookupAttachment( "ref" )

				entity shieldFXEnt = StartParticleEffectOnEntity_ReturnEntity( target, shieldbodyFX, FX_PATTACH_POINT_FOLLOW, attachID )
				EffectSetControlPointVector( shieldFXEnt, 1, < 115, 247, 255 > )
			}
		}
	}
	else if ( target.IsNPC() || target.IsPlayer() )
	{
		int shieldRestoreAmount = target.GetArmorType() == ARMOR_TYPE_HEAVY ? 750 : 250
		entity soul = attacker.GetTitanSoul()
		if ( IsValid( soul ) )
		{
			if ( SoulHasPassive( soul, ePassives.PAS_VANGUARD_SHIELD ) ){
				shieldRestoreAmount = 2500 //int( 1.25 * shieldRestoreAmount )
				soul.SetShieldHealth( min( soul.GetShieldHealth() + shieldRestoreAmount, soul.GetShieldHealthMax() ) )
				soul.SetShieldHealthMax(min(soul.GetShieldHealthMax()+250 , 5000))
				target.GetTitanSoul().SetShieldHealth(max(0,target.GetTitanSoul().GetShieldHealth()-250))
			}
			else{
				shieldRestoreAmount = 750 //int( 1.25 * shieldRestoreAmount )
				soul.SetShieldHealth( min( soul.GetShieldHealth() + shieldRestoreAmount, soul.GetShieldHealthMax() ) )
			}

			if ( SoulHasPassive( soul, ePassives.PAS_VANGUARD_COREMETER ) ){
				if(TitanCoreInUse(target)){
            
					PlayerEarnMeter_AddOwnedFrac( attacker, 0.25 )

				}
				
			}

			if ( SoulHasPassive( soul, ePassives.PAS_VANGUARD_DOOM ) ){
				if(GetDoomedState(attacker)){
					if(attacker.GetHealth()>2000 ){
						int overhealth = attacker.GetHealth() - 2000
						UndoomTitan(attacker,1)
						attacker.SetHealth(overhealth)
					}
					else{
						attacker.SetHealth(attacker.GetHealth()+500)  
					}
				}
				else{
					attacker.SetHealth(min(attacker.GetHealth()+500,attacker.GetMaxHealth())) 
				}
			}
		}
		if ( attacker.IsPlayer() )
			MessageToPlayer( attacker, eEventNotifications.VANGUARD_ShieldGain, attacker )
	}
}

void function healtarget(entity titan)
{
	for(int healtimes = 0 ; healtimes < 20 ; healtimes++){
		if (!IsValid(titan) || !IsAlive(titan) )
        break

        titan.SetHealth(minint(   (titan.GetHealth() + 13), titan.GetMaxHealth()  ))
        //player.Die()

        wait 0.5
	}
}

void function AddStunLaserHealCallback( void functionref(entity,entity,int) func )
{
	file.stunHealCallback = func
}
#endif


#if CLIENT
void function Vanguard_ShieldGain( entity attacker, var eventVal )
{
	if ( attacker.IsPlayer() )
	{
		//FlashCockpitHealthGreen()
		EmitSoundOnEntity( attacker, "EnergySyphon_ShieldRecieved"  )
		entity cockpit = attacker.GetCockpit()
		if ( IsValid( cockpit ) )
			StartParticleEffectOnEntity( cockpit, GetParticleSystemIndex( FX_SHIELD_GAIN_SCREEN	), FX_PATTACH_ABSORIGIN_FOLLOW, -1 )
		Rumble_Play( "rumble_titan_battery_pickup", { position = attacker.GetOrigin() } )
	}

}
#endif
