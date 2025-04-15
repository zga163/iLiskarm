global function GamemodeTTDM_Init

const float TTDMIntroLength = 15.0

void function GamemodeTTDM_Init()
{
	Riff_ForceSetSpawnAsTitan( eSpawnAsTitan.Always )
	Riff_ForceTitanExitEnabled( eTitanExitEnabled.Never )
	TrackTitanDamageInPlayerGameStat( PGS_ASSAULT_SCORE )
	ScoreEvent_SetupEarnMeterValuesForMixedModes()
	SetLoadoutGracePeriodEnabled( false )

	ClassicMP_SetCustomIntro( TTDMIntroSetup, TTDMIntroLength )
	ClassicMP_ForceDisableEpilogue( true )
	SetTimeoutWinnerDecisionFunc( CheckScoreForDraw )

	AddCallback_OnPlayerKilled( AddTeamScoreForPlayerKilled ) // dont have to track autotitan kills since you cant leave your titan in this mode

	// probably needs scoreevent earnmeter values
}

void function TTDMIntroSetup()
{
	// this should show intermission cam for 15 sec in prematch, before spawning players as titans
	AddCallback_GameStateEnter( eGameState.Prematch, TTDMIntroStart )
	AddCallback_OnClientConnected( TTDMIntroShowIntermissionCam )
	AddCallback_GameStateEnter( eGameState.Postmatch, Displaypassivetable)
}

void function Displaypassivetable()
{	
	print("=====================================全局配件使用统计============================================")
	int all = 0 
	foreach(passive in allpassive){
		passivetableglobal[passive] = GetConVarInt(Passivesnamesconvar[passive])
		all = all + GetConVarInt(Passivesnamesconvar[passive])
		
	}

	foreach(passive in allpassive){
		print(Passivesnames[passive]+":  "+passivetableglobal[passive] +"次  /" + 100*float(passivetableglobal[passive])/float(all) + "%")
	}
	print("=======================================================================================")

	print("=====================================全局配件使用前三============================================")
	
	int maxKey = -11111;
	int maxValue = -11111; // 假设所有值都是非负数
	int secondMaxKey = -11111;
	int secondMaxValue = -11111;
	int thirdMaxKey = -11111;
	int thirdMaxValue = -11111;
	foreach (key, value in passivetableglobal) {
		if(value != 0){
			if (value >= maxValue) {
				// 更新第三大值
				thirdMaxValue = secondMaxValue;
				thirdMaxKey = secondMaxKey;
		
				// 更新第二大值
				secondMaxValue = maxValue;
				secondMaxKey = maxKey;
		
				// 更新最大值
				maxValue = value;
				maxKey = key;
			} else if (value >= secondMaxValue && value < maxValue) {
				// 更新第三大值
				thirdMaxValue = secondMaxValue;
				thirdMaxKey = secondMaxKey;
		
				// 更新第二大值
				secondMaxValue = value;
				secondMaxKey = key;
			} else if (value >= thirdMaxValue && value < secondMaxValue) {
				// 更新第三大值
				thirdMaxValue = value;
				thirdMaxKey = key;
			}
		}
	}
	if(maxKey != -11111)
		print("1."+Passivesnames[maxKey] +":  "+passivetableglobal[maxKey] +"次   /" + 100*float(passivetableglobal[maxKey])/float(all) + "%")
	if(secondMaxKey != -11111)
		print("2."+Passivesnames[secondMaxKey] +":  "+passivetableglobal[secondMaxKey] +"次   /" + 100*float(passivetableglobal[secondMaxKey])/float(all) + "%")
	if(thirdMaxKey != -11111)
		print("3."+Passivesnames[thirdMaxKey] +":  "+passivetableglobal[thirdMaxKey] +"次   /" + 100*float(passivetableglobal[thirdMaxKey])/float(all) + "%")

	print("=================================================================================")


	print("=====================================配件使用统计============================================")
	foreach(passive in allpassive){
		print(Passivesnames[passive]+":  "+passivetable[passive] +"次")
	}
	
	print("=====================================配件使用前三============================================")
	
	maxKey = -11111;
	maxValue = -11111; // 假设所有值都是非负数
	secondMaxKey = -11111;
	secondMaxValue = -11111;
	thirdMaxKey = -11111;
	thirdMaxValue = -11111;
	foreach (key, value in passivetable) {
		if(value != 0){
			if (value >= maxValue) {
				// 更新第三大值
				thirdMaxValue = secondMaxValue;
				thirdMaxKey = secondMaxKey;
		
				// 更新第二大值
				secondMaxValue = maxValue;
				secondMaxKey = maxKey;
		
				// 更新最大值
				maxValue = value;
				maxKey = key;
			} else if (value >= secondMaxValue && value < maxValue) {
				// 更新第三大值
				thirdMaxValue = secondMaxValue;
				thirdMaxKey = secondMaxKey;
		
				// 更新第二大值
				secondMaxValue = value;
				secondMaxKey = key;
			} else if (value >= thirdMaxValue && value < secondMaxValue) {
				// 更新第三大值
				thirdMaxValue = value;
				thirdMaxKey = key;
			}
		}
	}
	if(maxKey != -11111)
		print("1."+Passivesnames[maxKey] +":  "+passivetable[maxKey] +"次")
	if(secondMaxKey != -11111)
		print("2."+Passivesnames[secondMaxKey] +":  "+passivetable[secondMaxKey] +"次")
	if(thirdMaxKey != -11111)
		print("3."+Passivesnames[thirdMaxKey] +":  "+passivetable[thirdMaxKey] +"次")

	print("=================================================================================")
	

	foreach(player in GetPlayerArray()){
		Chat_ServerPrivateMessage( player,  "=======================================================", false, true )
		Chat_ServerPrivateMessage( player,  "\x1b[34m配件使用统计：", false, true )


		if(maxKey != -11111)
			Chat_ServerPrivateMessage( player,  "\x1b[31m1."+Passivesnames[maxKey] +"\x1b[0m："+passivetable[maxKey] +"次", false, true )

		if(secondMaxKey != -11111)
			Chat_ServerPrivateMessage( player,  "\x1b[33m2."+Passivesnames[secondMaxKey] +"\x1b[0m："+passivetable[secondMaxKey] +"次", false, true )
			
		if(thirdMaxKey != -11111)
			Chat_ServerPrivateMessage( player,  "\x1b[36m3."+Passivesnames[thirdMaxKey] +"\x1b[0m："+passivetable[thirdMaxKey] +"次", false, true )
			
			Chat_ServerPrivateMessage( player,  "=======================================================", false, true )
	}
	
	
}

void function TTDMIntroStart()
{
	thread TTDMIntroStartThreaded()
}

void function TTDMIntroStartThreaded()
{
	ClassicMP_OnIntroStarted()

	foreach ( entity player in GetPlayerArray() )
	{
		if ( !IsPrivateMatchSpectator( player ) )
			TTDMIntroShowIntermissionCam( player )
		else
			RespawnPrivateMatchSpectator( player )
	}

	wait TTDMIntroLength

	ClassicMP_OnIntroFinished()
}

void function TTDMIntroShowIntermissionCam( entity player )
{
	if ( GetGameState() != eGameState.Prematch )
		return

	thread PlayerWatchesTTDMIntroIntermissionCam( player )
}

void function PlayerWatchesTTDMIntroIntermissionCam( entity player )
{
	player.EndSignal( "OnDestroy" )
	ScreenFadeFromBlack( player )

	entity intermissionCam = GetEntArrayByClass_Expensive( "info_intermission" )[ 0 ]

	// the angle set here seems sorta inconsistent as to whether it actually works or just stays at 0 for some reason
	player.SetObserverModeStaticPosition( intermissionCam.GetOrigin() )
	player.SetObserverModeStaticAngles( intermissionCam.GetAngles() )
	player.StartObserverMode( OBS_MODE_STATIC_LOCKED )

	wait TTDMIntroLength

	RespawnAsTitan( player, false )
	TryGameModeAnnouncement( player )
}

void function AddTeamScoreForPlayerKilled( entity victim, entity attacker, var damageInfo )
{
	if ( victim == attacker || !victim.IsPlayer() || !attacker.IsPlayer() && GetGameState() == eGameState.Playing )
		return

	AddTeamScore( GetOtherTeam( victim.GetTeam() ), 1 )
}

int function CheckScoreForDraw()
{	
	if (GameRules_GetTeamScore(TEAM_IMC) > GameRules_GetTeamScore(TEAM_MILITIA))
		return TEAM_IMC
	else if (GameRules_GetTeamScore(TEAM_MILITIA) > GameRules_GetTeamScore(TEAM_IMC))
		return TEAM_MILITIA

	return TEAM_UNASSIGNED
}
