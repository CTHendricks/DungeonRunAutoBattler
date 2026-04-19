extends Node

@onready var map: Map = $Map

func _ready():
	#GameManager.connect("battle_requested", BattleManager.start_battle)
	#BattleManager.connect("battle_finished", GameManager.on_battle_finished)
	EventBus.map_room_selected.connect(_on_map_room_selected)
	EventBus.battle_finished.connect(_on_battle_finished)
	#GameManager.start_new_run()

func _on_map_room_selected(room: Room) -> void:
	print(room.type)
	match room.type:
		Room.Type.BATTLE:
			var config = InformationDB.get_battle_config("battle")
			map.hide_map()
			EventBus.battle_requested.emit(config)
		Room.Type.MINI:
			var config = InformationDB.get_battle_config("boss")
			map.hide_map()
			EventBus.battle_requested.emit(config)
		_:
			map.unlock_next_rooms()

func _on_battle_finished(result) -> void:
	if not result.get("victory", false):
		EventBus.run_ended.emit({"victory": false})
		return
	
	var run_complete: bool = (
		map.last_room == null or map.last_room.next_rooms.is_empty()
	)
	
	if run_complete:
		EventBus.run_ended.emit({"victory": true})
		return
	
	map.show_map()
	map.unlock_next_rooms()
