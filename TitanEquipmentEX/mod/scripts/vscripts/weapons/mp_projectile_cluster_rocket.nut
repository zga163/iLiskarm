
global function OnProjectileCollision_ClusterRocket

void function OnProjectileCollision_ClusterRocket( entity projectile, vector pos, vector normal, entity hitEnt, int hitbox, bool isCritical )
{
	array<string> mods = projectile.ProjectileGetMods()
	entity player = projectile.GetOwner()

	if(!mods.contains( "pas_northstar_cluster" )){
		float duration = CLUSTER_ROCKET_DURATION
		#if SERVER
		float explosionDelay = expect float( projectile.ProjectileGetWeaponInfoFileKeyField( "projectile_explosion_delay" ) )

		ClusterRocket_Detonate( projectile, normal )
		CreateNoSpawnArea( TEAM_INVALID, TEAM_INVALID, pos, ( duration + explosionDelay ) * 0.5 + 1.0, CLUSTER_ROCKET_BURST_RANGE + 100 )
		#endif
	}
	else{
		PlayFX( $"exp_flak_s2s", pos, normal)
		//PlayFXOnEntity( $"exp_flak_s2s", projectile )
		Explosion(
		pos + <0,0,50>,
		null,
		player, 
		90, 
		2700,
		150,
		740, 
		SF_ENVEXPLOSION_NOSOUND_FOR_ALLIES, 
		pos,
		150,
		damageTypes.explosive, 
		eDamageSourceId.mp_titanweapon_dumbfire_rockets,
		ARC_CANNON_FX_TABLE)
	}
	

	
}
