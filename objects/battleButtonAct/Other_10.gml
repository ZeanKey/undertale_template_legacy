///@desc Button Confirm Call
if (not (IsChosen() && battle.TurnPhase == TURN_PHASE.PLAYER_BUTTON)) then exit;

switch (_phase)
{
	case 0:
	var MULTI_CHOICE	= CreateMultiChoices();
	var TYPER_INFOS		= battle.Encounter.TyperPosition;
	var CHOICE_X, CHOICE_Y, CHOICE_TXT, CUR_ENEMY, PREFIX;
		
	CHOICE_X = TYPER_INFOS.Dialog.X + 48;
	
	MULTI_CHOICE.Init();
	for (var INDEX = 0; INDEX < 2; INDEX ++) {
		CUR_ENEMY	= battle.Enemies.Find(INDEX);
		CHOICE_Y	= TYPER_INFOS.Dialog.Y + 32 * INDEX;
		PREFIX		= (battle.Enemies.Find(INDEX).Info.Spareable) ? battle.Encounter.Mercy.Color : "";
		CHOICE_TXT	= PREFIX + "* " + CUR_ENEMY.Info.Name;
		
		MULTI_CHOICE.Add(CHOICE_X, CHOICE_Y, CHOICE_TXT);
	}
	MULTI_CHOICE.Generate();
	
	audio_play_sound(sndMenuConfirm, 0, 0);
	
	_choice = MULTI_CHOICE;
	_phase ++;
	break;
	
	case 1:
	var RESULT			= _choice.Submit();
	var MULTI_CHOICE	= CreateMultiChoices();
	var TYPER_INFOS		= battle.Encounter.TyperPosition;
	var CHOICE_X, CHOICE_Y, CHOICE_TXT;
	
	MULTI_CHOICE.Init();
	for (var INDEX = 0; INDEX < 2; INDEX ++) {
		
		CHOICE_X	= TYPER_INFOS.Dialog.X + 48 + ((INDEX) mod 2) * TYPER_INFOS.Space;
		CHOICE_Y	= TYPER_INFOS.Dialog.Y + ((INDEX) div 2) * 32;
		CHOICE_TXT	= "* " + battle.Enemies.Find(RESULT).ActChoices.Find(INDEX);
		
		MULTI_CHOICE.Add(CHOICE_X, CHOICE_Y, CHOICE_TXT);
	}
	MULTI_CHOICE.Generate();
	
	audio_play_sound(sndMenuConfirm, 0, 0);
	
	_enemyIndex = RESULT;
	_choice		= MULTI_CHOICE;
	_phase ++;
	break;
	
	case 2:
	var RESULT			= _choice.Submit();
	var ENEMY_CHOSEN	= battle.Enemies.Find(_enemyIndex);
	
	battle.Soul.RemoveUI();
	ENEMY_CHOSEN.ButtonCall(BATTLE_BUTTON.ACT, RESULT);

	audio_play_sound(sndMenuConfirm,0,0);
	
	_phase ++;
	break;
	
	case 3:
	break;
	
	case 4:
	with (battleButton) Reset();
	battle.SetTurnPhase(TURN_PHASE.PLAYER_END);
	break;
	
}

