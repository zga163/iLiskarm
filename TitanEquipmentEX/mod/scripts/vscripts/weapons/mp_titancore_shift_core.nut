untyped
global function OnWeaponPrimaryAttack_DoNothing

global function Shift_Core_Init
#if SERVER
global function Shift_Core_UseMeter
#endif

global function OnCoreCharge_Shift_Core
global function OnCoreChargeEnd_Shift_Core
global function OnAbilityStart_Shift_Core
const BEAM3	= $"P_wpn_charge_tool_beam"
void function Shift_Core_Init()
{
	RegisterSignal( "RestoreWeapon" )
	#if SERVER
	AddCallback_OnPlayerKilled( SwordCore_OnPlayedOrNPCKilled )
	AddCallback_OnNPCKilled( SwordCore_OnPlayedOrNPCKilled )
	#endif
}

#if SERVER
void function SwordCore_OnPlayedOrNPCKilled( entity victim, entity attacker, var damageInfo )
{
	if ( !victim.IsTitan() )
		return

	if ( !attacker.IsPlayer() || !PlayerHasPassive( attacker, ePassives.PAS_SHIFT_CORE ) )
		return

	entity soul = attacker.GetTitanSoul()
	if ( !IsValid( soul ) || !SoulHasPassive( soul, ePassives.PAS_RONIN_SWORDCORE ) )
		return

	float curTime = Time()
	float highlanderBonus = 8.0
	float remainingTime = highlanderBonus + soul.GetCoreChargeExpireTime() - curTime
	float duration = soul.GetCoreUseDuration()
	float coreFrac = min( 1.0, remainingTime / duration )
	//Defensive fix for this sometimes resulting in a negative value.
	if ( coreFrac > 0.0 )
	{
		soul.SetTitanSoulNetFloat( "coreExpireFrac", coreFrac )
		soul.SetTitanSoulNetFloatOverTime( "coreExpireFrac", 0.0, remainingTime )
		soul.SetCoreChargeExpireTime( remainingTime + curTime )
	}
}
#endif

var function OnWeaponPrimaryAttack_DoNothing( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	return 0
}

bool function OnCoreCharge_Shift_Core( entity weapon )
{
	if ( !OnAbilityCharge_TitanCore( weapon ) )
		return false

#if SERVER
	entity owner = weapon.GetWeaponOwner()
	string swordCoreSound_1p
	string swordCoreSound_3p
	if ( weapon.HasMod( "fd_duration" ) )
	{
		swordCoreSound_1p = "Titan_Ronin_Sword_Core_Activated_Upgraded_1P"
		swordCoreSound_3p = "Titan_Ronin_Sword_Core_Activated_Upgraded_3P"
	}
	else
	{
		swordCoreSound_1p = "Titan_Ronin_Sword_Core_Activated_1P"
		swordCoreSound_3p = "Titan_Ronin_Sword_Core_Activated_3P"
	}
	if ( owner.IsPlayer() )
	{
		owner.HolsterWeapon() //TODO: Look into rewriting this so it works with HolsterAndDisableWeapons()
		thread RestoreWeapon( owner, weapon )
		EmitSoundOnEntityOnlyToPlayer( owner, owner, swordCoreSound_1p )
		EmitSoundOnEntityExceptToPlayer( owner, owner, swordCoreSound_3p )
	}
	else
	{
		EmitSoundOnEntity( weapon, swordCoreSound_3p )
	}
#endif

	return true
}

void function OnCoreChargeEnd_Shift_Core( entity weapon )
{
	#if SERVER
	entity owner = weapon.GetWeaponOwner()
	OnAbilityChargeEnd_TitanCore( weapon )
	if ( IsValid( owner ) && owner.IsPlayer() )
		owner.DeployWeapon() //TODO: Look into rewriting this so it works with HolsterAndDisableWeapons()
	else if ( !IsValid( owner ) )
		Signal( weapon, "RestoreWeapon" )
	#endif
}

#if SERVER
void function RestoreWeapon( entity owner, entity weapon )
{
	owner.EndSignal( "OnDestroy" )
	owner.EndSignal( "CoreBegin" )

	WaitSignal( weapon, "RestoreWeapon", "OnDestroy" )

	if ( IsValid( owner ) && owner.IsPlayer() )
	{
		owner.DeployWeapon() //TODO: Look into rewriting this so it works with DeployAndEnableWeapons()
	}
}
#endif

var function OnAbilityStart_Shift_Core( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	OnAbilityStart_TitanCore( weapon )

	entity owner = weapon.GetWeaponOwner()

	if ( !owner.IsTitan() )
		return 0

	if ( !IsValid( owner ) )
		return

	entity offhandWeapon = owner.GetOffhandWeapon( OFFHAND_MELEE )
	if ( !IsValid( offhandWeapon ) )
		return 0

	if ( offhandWeapon.GetWeaponClassName() != "melee_titan_sword" )
		return 0

#if SERVER
	if ( owner.IsPlayer() )
	{
		owner.Server_SetDodgePower( 100.0 )
		owner.SetPowerRegenRateScale( 6.5 )
		GivePassive( owner, ePassives.PAS_FUSION_CORE )
		GivePassive( owner, ePassives.PAS_SHIFT_CORE )
		owner.s.cancool <- true
		AddAnimEvent( owner, "shift_core_use_meter", Shift_Core_UseMeter )
	}

	entity soul = owner.GetTitanSoul()
	if ( soul != null )
	{	
		if(SoulHasPassive(soul , ePassives.PAS_RONIN_SWORDCORE)){
			thread cooltimer(owner)
		}
		entity titan = soul.GetTitan()

		if ( titan.IsNPC() )
		{
			titan.SetAISettings( "npc_titan_stryder_leadwall_shift_core" )
			titan.EnableNPCMoveFlag( NPCMF_PREFER_SPRINT )
			titan.SetCapabilityFlag( bits_CAP_MOVE_SHOOT, false )
			AddAnimEvent( titan, "shift_core_use_meter", Shift_Core_UseMeter_NPC )
		}

		titan.GetOffhandWeapon( OFFHAND_MELEE ).AddMod( "super_charged" )

		if ( IsSingleplayer() )
		{
			titan.GetOffhandWeapon( OFFHAND_MELEE ).AddMod( "super_charged_SP" )
		}

		titan.SetActiveWeaponByName( "melee_titan_sword" )

		entity mainWeapon = titan.GetMainWeapons()[0]
		mainWeapon.AllowUse( false )
	}

	float delay = weapon.GetWeaponSettingFloat( eWeaponVar.charge_cooldown_delay )
	thread Shift_Core_End( weapon, owner, delay )
#endif

	return 1
}

#if SERVER
void function Shift_Core_End( entity weapon, entity player, float delay )
{
	weapon.EndSignal( "OnDestroy" )

	if ( player.IsNPC() && !IsAlive( player ) )
		return

	player.EndSignal( "OnDestroy" )
	if ( IsAlive( player ) )
		player.EndSignal( "OnDeath" )
	player.EndSignal( "TitanEjectionStarted" )
	player.EndSignal( "DisembarkingTitan" )
	player.EndSignal( "OnSyncedMelee" )
	player.EndSignal( "InventoryChanged" )

	OnThreadEnd(
	function() : ( weapon, player )
		{
			OnAbilityEnd_Shift_Core( weapon, player )

			if ( IsValid( player ) )
			{
				entity soul = player.GetTitanSoul()
				if ( soul != null )
					CleanupCoreEffect( soul )
			}
		}
	)

	entity soul = player.GetTitanSoul()
	if ( soul == null )
		return

	while ( 1 )
	{
		if ( soul.GetCoreChargeExpireTime() <= Time() )
			break;
		wait 0.1
	}
}

void function OnAbilityEnd_Shift_Core( entity weapon, entity player )
{
	OnAbilityEnd_TitanCore( weapon )

	if ( player.IsPlayer() )
	{
		player.SetPowerRegenRateScale( 1.0 )
		EmitSoundOnEntityOnlyToPlayer( player, player, "Titan_Ronin_Sword_Core_Deactivated_1P" )
		EmitSoundOnEntityExceptToPlayer( player, player, "Titan_Ronin_Sword_Core_Deactivated_3P" )
		int conversationID = GetConversationIndex( "swordCoreOffline" )
		Remote_CallFunction_Replay( player, "ServerCallback_PlayTitanConversation", conversationID )
	}
	else
	{
		DeleteAnimEvent( player, "shift_core_use_meter" )
		EmitSoundOnEntity( player, "Titan_Ronin_Sword_Core_Deactivated_3P" )
	}

	RestorePlayerWeapons( player )
}

void function RestorePlayerWeapons( entity player )
{
	if ( !IsValid( player ) )
		return

	if ( player.IsNPC() && !IsAlive( player ) )
		return // no need to fix up dead NPCs

	entity soul = player.GetTitanSoul()

	if ( player.IsPlayer() )
	{
		TakePassive( player, ePassives.PAS_FUSION_CORE )
		TakePassive( player, ePassives.PAS_SHIFT_CORE )

		soul = GetSoulFromPlayer( player )
	}

	if ( soul != null )
	{
		entity titan = soul.GetTitan()

		entity meleeWeapon = titan.GetOffhandWeapon( OFFHAND_MELEE )
		if ( IsValid( meleeWeapon ) )
		{
			meleeWeapon.RemoveMod( "super_charged" )
			if ( IsSingleplayer() )
			{
				meleeWeapon.RemoveMod( "super_charged_SP" )
			}
		}

		array<entity> mainWeapons = titan.GetMainWeapons()
		if ( mainWeapons.len() > 0 )
		{
			entity mainWeapon = titan.GetMainWeapons()[0]
			mainWeapon.AllowUse( true )
		}

		if ( titan.IsNPC() )
		{
			string settings = GetSpawnAISettings( titan )
			if ( settings != "" )
				titan.SetAISettings( settings )

			titan.DisableNPCMoveFlag( NPCMF_PREFER_SPRINT )
			titan.SetCapabilityFlag( bits_CAP_MOVE_SHOOT, true )
		}
	}
}

void function Shift_Core_UseMeter( entity player )
{
	//if ( IsMultiplayer() )
		//return

	entity soul = player.GetTitanSoul()
	entity weapon = player.GetOffhandWeapon(OFFHAND_MELEE)
	if(IsValid(player) && IsValid(weapon)){
		if ( weapon.HasMod( "wuxing" ) ){
			entity player = weapon.GetWeaponOwner()
			if(IsValid(player) && StatusEffect_Get( player, eStatusEffect.stim_visual_effect ) == 0 ){
				StatusEffect_AddTimed(player , eStatusEffect.stim_visual_effect , 0.01,0.75,0)
				vector traceStart = player.EyePosition()
				vector prevViewVec = player.GetPlayerOrNPCViewVector()
				vector preforce = Normalize(prevViewVec)
				vector traceEnd = traceStart + ( preforce*500 )
				vector tararea = TraceLine(traceStart,traceEnd,player, TRACE_MASK_SHOT  , TRACE_COLLISION_GROUP_NONE).endPos - 10*preforce
				thread linetestsp(player , tararea)
				//vector tararea = player.GetOrigin() + < 0,0,80> + 500*Normalize(player.GetPlayerOrNPCViewVector())
				entity trigger = CreateEntity( "trigger_cylinder" )
				trigger.SetRadius( 650 )
				trigger.SetAboveHeight( 650 ) //Still not quite a sphere, will see if close enough
				trigger.SetBelowHeight( 650 )
				trigger.SetOrigin( tararea )
				//trigger.SetParent( decoy )
				DispatchSpawn( trigger )
	
				trigger.SearchForNewTouchingEntity()
	
				array <entity>touchingEnts = trigger.GetTouchingEntities()
				int damageincut = weapon.HasMod( "super_charged" )?560:280
				foreach(ent in touchingEnts){
					if(ent.IsNPC() && ent.GetTeam() != player.GetTeam()){
						//ent.TakeDamage( damageincut ,player ,null, {damageSourceId = eDamageSourceId.wuxing})
						thread takeentdamage(ent ,player,damageincut)
						thread linetestsp(player , ent.GetOrigin())
					}
				}
	
				if(IsValid(trigger)){
					trigger.Destroy()
				}
			}
				
		}
	}
	

	if(!SoulHasPassive(soul , ePassives.PAS_RONIN_AUTOSHIFT))
		return

	float curTime = Time()
	float remainingTime = soul.GetCoreChargeExpireTime() - curTime

	if ( remainingTime > 0 )
	{
		const float USE_TIME = 4
		if(expect int(player.s.empcount) < 5)
			player.s.empcount++

		remainingTime = max( remainingTime - USE_TIME, 0 )
		float startTime = soul.GetCoreChargeStartTime()
		float duration = soul.GetCoreUseDuration()

		soul.SetTitanSoulNetFloat( "coreExpireFrac", remainingTime / duration )
		soul.SetTitanSoulNetFloatOverTime( "coreExpireFrac", 0.0, remainingTime )
		soul.SetCoreChargeExpireTime( remainingTime + curTime )
	}
}

void function Shift_Core_UseMeter_NPC( entity npc )
{
	Shift_Core_UseMeter( npc )
}
#endif



void function linetestsp(entity player , vector pos)
{       
    
    thread spswordline2testesp(player ,pos)

}

void function spswordline2testesp(entity player , vector atkpos)
{
    if(!IsValid(player) )
        return

    vector stratpos = atkpos + < RandomIntRange( -500 , 500) , RandomIntRange( -500 , 500) , RandomIntRange( -600 ,600)>
    vector endpos = 2*atkpos - stratpos
    wait 0.3
    //thread cutdelay(player , atkpos , stratpos , endpos)
   

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
	function() : (beamFX,cpEnd,player, mover1 , mover2 ,  atkpos,stratpos,endpos)
		{
			
			EmitSoundAtPosition( TEAM_ANY, atkpos, "ronin_sword_melee_3p" )
            CreateShake( atkpos-<0,0,120>, 5, 12,0.5, 1200 )
           
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

void function takeentdamage(entity ent ,entity player,int damageincut)
{
	wait 0.5
	if(IsValid(ent) && IsAlive(ent) && IsValid(player))
		ent.TakeDamage( damageincut ,player ,null, {damageSourceId = eDamageSourceId.wuxing})
}