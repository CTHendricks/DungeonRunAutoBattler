extends Node

@onready var battlefield_scene = preload("res://scenes/battlefield.tscn")

func _ready() -> void:
	EventBus.battle_requested.connect(start_battle)

func start_battle(config):
	var battlefield = battlefield_scene.instantiate()
	add_child(battlefield)
	
	battlefield.setup(
		RosterManager.get_team_snapshot(),
		config.enemy_team
	)
	
	battlefield.connect("battle_over", _on_battle_over)

func _on_battle_over(result):
	print("Battle Finished.")
	EventBus.battle_finished.emit(result)
	print(get_child(0))
	get_child(0).queue_free()
