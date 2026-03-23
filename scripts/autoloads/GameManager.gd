extends Node

signal battle_requested(config)
signal stage_changed(stage)
signal run_ended(result)

var stages: Array = ["normal", "normal", "boss"]
var stage_index: int = 0

func start_new_run():
	stage_index = 0
	_request_next_battle()

func _request_next_battle():
	var stage = stages[stage_index]
	print("Stage Changed.")
	emit_signal("stage_changed", stage)
	
	var config = InformationDB.get_battle_config(stage)
	print("Battle Requested.")
	emit_signal("battle_requested", config)

func on_battle_finished(result):
	if not result.victory:
		emit_signal("run_ended", false)
		return
	
	stage_index += 1
	
	if stage_index >= stages.size():
		emit_signal("run_ended", true)
	else:
		_request_next_battle()
