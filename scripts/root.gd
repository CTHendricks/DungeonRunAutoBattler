extends Node

func _ready():
	GameManager.connect("battle_requested", BattleManager.start_battle)
	BattleManager.connect("battle_finished", GameManager.on_battle_finished)
	GameManager.start_new_run()
