global function OnWeaponActivate_titanweapon_sword
global function OnWeaponDeactivate_titanweapon_sword
global function MpTitanWeaponSword_Init

global const asset SWORD_GLOW_FP = $"P_xo_sword_core_hld_FP"
global const asset SWORD_GLOW = $"P_xo_sword_core_hld"

global const asset SWORD_GLOW_PRIME_FP = $"P_xo_sword_core_PRM_FP"
global const asset SWORD_GLOW_PRIME = $"P_xo_sword_core_PRM"

const BEAM2	= $"wpn_arc_cannon_beam"
const BEAM3	= $"P_wpn_charge_tool_beam"
void function MpTitanWeaponSword_Init()
{
	PrecacheParticleSystem( SWORD_GLOW_FP )
	PrecacheParticleSystem( SWORD_GLOW )

	PrecacheParticleSystem( SWORD_GLOW_PRIME_FP )
	PrecacheParticleSystem( SWORD_GLOW_PRIME )

	RegisterWeaponDamageSource( "wuxing", "無形斬" )

	#if SERVER
		AddDamageCallbackSourceID( eDamageSourceId.mp_titancore_shift_core, Sword_DamagedTarget )
	#endif
}
/*
void function OnWeaponActivate_titanweapon_sword( entity weapon )
{
	if ( weapon.HasMod( "super_charged" ) )
	{
		if ( weapon.HasMod( "modelset_prime" ) )
			weapon.PlayWeaponEffectNoCull( SWORD_GLOW_PRIME_FP, SWORD_GLOW_PRIME, "sword_edge" )
		else
			weapon.PlayWeaponEffectNoCull( SWORD_GLOW_FP, SWORD_GLOW, "sword_edge" )
	}

	//thread DelayedSwordCoreFX( weapon )
}
*/
/*void function DelayedSwordCoreFX( entity weapon )
{
	weapon.EndSignal( "WeaponDeactivateEvent" )
	weapon.EndSignal( "OnDestroy" )

	WaitFrame()

	weapon.PlayWeaponEffectNoCull( SWORD_GLOW_FP, SWORD_GLOW, "sword_edge" )
}*/

void function OnWeaponDeactivate_titanweapon_sword( entity weapon )
{
	if ( weapon.HasMod( "modelset_prime" ) )
		weapon.StopWeaponEffect( SWORD_GLOW_PRIME_FP, SWORD_GLOW_PRIME )
	else
		weapon.StopWeaponEffect( SWORD_GLOW_FP, SWORD_GLOW )
}

#if SERVER
void function Sword_DamagedTarget( entity target, var damageInfo )
{
	entity attacker = DamageInfo_GetAttacker( damageInfo )
	entity soul = attacker.GetTitanSoul()
	entity coreWeapon = attacker.GetOffhandWeapon( OFFHAND_EQUIPMENT )
	if ( !IsValid( coreWeapon ) )
		return

	if ( coreWeapon.HasMod( "fd_duration" ) && IsValid( soul ) )
	{
		int shieldRestoreAmount = target.GetArmorType() == ARMOR_TYPE_HEAVY ? 500 : 250
		soul.SetShieldHealth( min( soul.GetShieldHealth() + shieldRestoreAmount, soul.GetShieldHealthMax() ) )
	}
}
#endif





void function OnWeaponActivate_titanweapon_sword( entity weapon )
{
	if ( weapon.HasMod( "super_charged" ) )
	{
		if ( weapon.HasMod( "modelset_prime" ) )
			weapon.PlayWeaponEffectNoCull( SWORD_GLOW_PRIME_FP, SWORD_GLOW_PRIME, "sword_edge" )
		else
			weapon.PlayWeaponEffectNoCull( SWORD_GLOW_FP, SWORD_GLOW, "sword_edge" )
	}


	if ( weapon.HasMod( "wuxing" ) ){
		entity player = weapon.GetWeaponOwner()
		if(IsValid(player) && StatusEffect_Get( player, eStatusEffect.stim_visual_effect ) == 0 ){
			StatusEffect_AddTimed(player , eStatusEffect.stim_visual_effect , 0.01,0.75,0)
			vector traceStart = player.EyePosition()
			vector prevViewVec = player.GetPlayerOrNPCViewVector()
			vector preforce = Normalize(prevViewVec)
			vector traceEnd = traceStart + ( preforce*500 )
			vector tararea = TraceLine(traceStart,traceEnd,player, TRACE_MASK_SHOT  , TRACE_COLLISION_GROUP_NONE).endPos - 10*preforce

			thread linetest(player , tararea)

			//vector tararea = player.GetOrigin() + < 0,0,80> + 500*Normalize(player.GetPlayerOrNPCViewVector())
			entity trigger = CreateEntity( "trigger_cylinder" )
			trigger.SetRadius( 350 )
			trigger.SetAboveHeight( 350 ) //Still not quite a sphere, will see if close enough
			trigger.SetBelowHeight( 350 )
			trigger.SetOrigin( tararea )
			//trigger.SetParent( decoy )
			DispatchSpawn( trigger )

			trigger.SearchForNewTouchingEntity()

			array <entity>touchingEnts = trigger.GetTouchingEntities()
			int damageincut = weapon.HasMod( "super_charged" )?770:280
			foreach(ent in touchingEnts){
				if(ent.IsPlayer() && ent.GetTeam() != player.GetTeam()){
					//ent.TakeDamage( damageincut ,player ,null, {damageSourceId = eDamageSourceId.wuxing})
					thread takeentdamage(ent ,player,damageincut)
					thread linetest(player , ent.GetOrigin())
				}
			}

			if(IsValid(trigger)){
				trigger.Destroy()
			}
		}
			
	}
		
	

	//thread DelayedSwordCoreFX( weapon )
}

void function takeentdamage(entity ent ,entity player,int damageincut)
{
	wait 0.5
	if(IsValid(ent) && IsAlive(ent) && IsValid(player))
		ent.TakeDamage( damageincut ,player ,null, {damageSourceId = eDamageSourceId.wuxing})
}


void function linetest(entity player , vector pos)
{       
    
    thread spswordline2teste(player ,pos)

}

void function spswordline2teste(entity player , vector atkpos)
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