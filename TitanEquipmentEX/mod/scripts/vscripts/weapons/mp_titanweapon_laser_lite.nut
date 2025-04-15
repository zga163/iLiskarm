global function MpTitanWeaponLaserLite_Init

global function OnWeaponAttemptOffhandSwitch_titanweapon_laser_lite
global function OnWeaponPrimaryAttack_titanweapon_laser_lite

#if SERVER
global function OnWeaponNPCPrimaryAttack_titanweapon_laser_lite
#endif

void function MpTitanWeaponLaserLite_Init()
{
	#if SERVER
		AddDamageCallbackSourceID( eDamageSourceId.mp_titanweapon_laser_lite, LaserLite_DamagedTarget )
	#endif
}

bool function OnWeaponAttemptOffhandSwitch_titanweapon_laser_lite( entity weapon )
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

var function OnWeaponPrimaryAttack_titanweapon_laser_lite( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	#if CLIENT
		if ( !weapon.ShouldPredictProjectiles() )
			return 1
	#endif

	entity weaponOwner = weapon.GetWeaponOwner()
	if ( weaponOwner.IsPlayer() )
		PlayerUsedOffhand( weaponOwner, weapon )

	ShotgunBlast( weapon, attackParams.pos, attackParams.dir, 1, DF_GIB | DF_EXPLOSION )
	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )
	weapon.SetWeaponChargeFractionForced(1.0)
	return 1
}
#if SERVER
var function OnWeaponNPCPrimaryAttack_titanweapon_laser_lite( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	return OnWeaponPrimaryAttack_titanweapon_laser_lite( weapon, attackParams )
}

void function LaserLite_DamagedTarget( entity target, var damageInfo )
{
	entity weapon = DamageInfo_GetWeapon( damageInfo )
	entity attacker = DamageInfo_GetAttacker( damageInfo )
	entity soul = attacker.GetTitanSoul()

	if(IsValid(soul)){
		if(SoulHasPassive(soul , ePassives.PAS_ION_LASERCANNON)){
			if(IsValid(target) && IsValid(attacker)){
				vector targetpos = target.GetOrigin()
				vector mepos = attacker.GetOrigin()
				vector speedvector = targetpos - mepos
				vector speedvectorsize = Normalize(speedvector)
				if(IsCriticalHit( attacker, target, DamageInfo_GetHitBox( damageInfo ), DamageInfo_GetDamage( damageInfo ), DamageInfo_GetDamageType( damageInfo ) )){

					
					if (IsValid(target)){
						vector speedorgin = target.GetVelocity()
						target.SetVelocity(1050*speedvectorsize + speedorgin + <0, 0 , 80>)   
					}
				}
				else{
					if (IsValid(target)){
						vector speedorgin = target.GetVelocity()
						target.SetVelocity(650*speedvectorsize + speedorgin + <0, 0 , 80>)   
					}
				}
							
			}
		}
	}
	if ( attacker == target )
	{
		DamageInfo_SetDamage( damageInfo, 0 )
		return
	}
}

#endif