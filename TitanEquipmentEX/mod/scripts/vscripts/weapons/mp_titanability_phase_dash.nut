untyped
global function OnWeaponPrimaryAttack_titanability_phase_dash

#if SERVER
global function OnWeaponNPCPrimaryAttack_titanability_phase_dash
global function SetPlayerVelocityFromInput
#endif

const PHASE_DASH_SPEED = 1000

var function OnWeaponPrimaryAttack_titanability_phase_dash( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	//PlayWeaponSound( "fire" )
	entity player = weapon.GetWeaponOwner()
	entity soul = player.GetTitanSoul()

	float shiftTime =  1.0

	if ( IsAlive( player ) )
	{
		if ( PhaseShift( player, 0, shiftTime ) )
		{
			if ( player.IsPlayer() )
			{
				PlayerUsedOffhand( player, weapon )

				#if SERVER
					EmitSoundOnEntityExceptToPlayer( player, player, "Stryder.Dash" )
					thread PhaseDash( weapon, player )
					if(IsValid(soul)){
						if(SoulHasPassive(soul , ePassives.PAS_RONIN_PHASE)){
							thread phaseboom(player)
							Explosion(
								attackParams.pos,
								player,
								player, 
								90, 
								500,
								200,
								500, 
								SF_ENVEXPLOSION_NO_DAMAGEOWNER |SF_ENVEXPLOSION_NOSOUND_FOR_ALLIES, 
								attackParams.pos,
								200,
								damageTypes.explosive, 
								eDamageSourceId.phase_shift,
								ARC_CANNON_FX_TABLE)
						}
						
						
					}
					

					entity soul = player.GetTitanSoul()
					if ( soul == null )
						soul = player

					float fade = 0.5
					StatusEffect_AddTimed( soul, eStatusEffect.move_slow, 0.6, shiftTime + fade, fade )
				#elseif CLIENT
					float xAxis = InputGetAxis( ANALOG_LEFT_X )
					float yAxis = InputGetAxis( ANALOG_LEFT_Y ) * -1
					vector angles = player.EyeAngles()
					vector directionForward = GetDirectionFromInput( angles, xAxis, yAxis )
					if ( IsFirstTimePredicted() )
					{
						EmitSoundOnEntity( player, "Stryder.Dash" )
					}
				#endif
			}
		}

	}
	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
}

#if SERVER
var function OnWeaponNPCPrimaryAttack_titanability_phase_dash( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	return OnWeaponPrimaryAttack_titanability_phase_dash( weapon, attackParams )
}

void function PhaseDash( entity weapon, entity player )
{
	float movestunEffect = 1.0 - StatusEffect_Get( player, eStatusEffect.dodge_speed_slow )
	float moveSpeed
	if ( weapon.HasMod( "fd_phase_distance" ) )
		moveSpeed = PHASE_DASH_SPEED * movestunEffect * 1.5
	else
		moveSpeed = PHASE_DASH_SPEED * movestunEffect
	SetPlayerVelocityFromInput( player, moveSpeed, <0,0,200> )
}

void function SetPlayerVelocityFromInput( entity player, float scale, vector baseVel = < 0,0,0 > )
{
	vector angles = player.EyeAngles()
	float xAxis = player.GetInputAxisRight()
	float yAxis = player.GetInputAxisForward()
	vector directionForward = GetDirectionFromInput( angles, xAxis, yAxis )
	entity soul = player.GetTitanSoul()

	if (yAxis < 0 && SoulHasPassive(soul , ePassives.PAS_RONIN_SWORDCORE) && PlayerHasPassive( player, ePassives.PAS_SHIFT_CORE )){

        player.SetVelocity(directionForward * scale + baseVel)

		float curTime = Time()
		float remainingTime = soul.GetCoreChargeExpireTime() - curTime

		if ( remainingTime > 0  && player.s.cancool)
		{
			const float USE_TIME = 6
			player.s.cancool <- false
			remainingTime = max( remainingTime - USE_TIME, 0 )
			float startTime = soul.GetCoreChargeStartTime()
			float duration = soul.GetCoreUseDuration()

			soul.SetTitanSoulNetFloat( "coreExpireFrac", remainingTime / duration )
			soul.SetTitanSoulNetFloatOverTime( "coreExpireFrac", 0.0, remainingTime )
			soul.SetCoreChargeExpireTime( remainingTime + curTime )

			
			vector speed = player.GetVelocity()
			player.SetVelocity(<0,0,0>)
			CreateHolo( player, 1)
			player.SetVelocity(speed)	

			if(player.GetHealth() == 1)
				spcoolswordatk(player)
			else
				coolswordatk(player)
		}
    }
	else{
        // 其他输入情况
        player.SetVelocity(directionForward * scale + baseVel)
    }
	//player.SetVelocity( directionForward * scale + baseVel )
}
#endif

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


void function phaseboom(entity player)
{
	wait 1.0
	if(IsValid(player) && IsAlive(player)){
		Explosion(
			player.GetOrigin()+<0,0,60>,
			player,
			player, 
			100, 
			7500,
			23,
			33, 
			SF_ENVEXPLOSION_NO_DAMAGEOWNER | SF_ENVEXPLOSION_NOSOUND_FOR_ALLIES, 
			player.GetOrigin()+<0,0,60>,
			23,
			DF_EXPLOSION | DF_STOPS_TITAN_REGEN | DF_DOOM_FATALITY | DF_SKIPS_DOOMED_STATE, 
			eDamageSourceId.phase_shift,
			ARC_CANNON_FX_TABLE)
	}




}


void function CreateHolo( entity player, int numberOfDecoysToMake = 1 )
{
	Assert( numberOfDecoysToMake > 0  )
	Assert( player )

	float displacementDistance = 30.0

	bool setOriginAndAngles = numberOfDecoysToMake > 1

	float stickPercentToRun = 0.65
	if ( setOriginAndAngles )
		stickPercentToRun = 0.0

	for( int i = 0; i < numberOfDecoysToMake; ++i )
	{
		entity decoy = player.CreatePlayerDecoy( stickPercentToRun )
		decoy.SetMaxHealth( 50 )
        //decoy.kv.modelscale = 3
		decoy.SetHealth( 50 )
		//decoy.Freeze()
		decoy.EnableAttackableByAI( 50, 0, AI_AP_FLAG_NONE )
		SetObjectCanBeMeleed( decoy, true )
		decoy.SetTimeout( 0.2 )


		if ( setOriginAndAngles )
		{
			
			vector normalizedAngle = player.GetAngles() 
			normalizedAngle.y = AngleNormalize( normalizedAngle.y ) //Only care about changing the yaw
			decoy.SetAngles( normalizedAngle )

			vector forwardVector = AnglesToForward( normalizedAngle )
			forwardVector *= displacementDistance
			decoy.SetOrigin( player.GetOrigin()-<0,0,30>) //Using player origin instead of decoy origin as defensive fix, see bug 223066
			PutEntityInSafeSpot( decoy, player, null, player.GetOrigin(), decoy.GetOrigin()  )
		}

		SetupDecoy_Common( player, decoy )
        //decoy.Freeze()


	}


}