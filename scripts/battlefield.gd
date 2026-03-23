extends Node2D

@onready var unit_scene = preload("res://scenes/unit.tscn")

signal battle_over(result)

var player_units = []
var enemy_units = []

func setup(player_team, enemy_team):
	_spawn_units(player_team, enemy_team)
	_start_battle_loop()

func _spawn_units(player_team, enemy_team):
	print("Spawning Units.")
	for u in player_team:
		var inst = unit_scene.instantiate()
		inst.set_from_data(u)
		inst.connect("died", _on_unit_died)
		player_units.append(inst)
	
	for e in enemy_team:
		var inst = unit_scene.instantiate()
		inst.set_from_data(e)
		inst.connect("died", _on_unit_died)
		enemy_units.append(inst)

func _start_battle_loop():
	print("Starting Battle Loop.")
	await get_tree().create_timer(0.3).timeout
	while player_units.size() > 0 and enemy_units.size() > 0:
		print("Player Attacks.")
		_tick(player_units, enemy_units)
		print("Enemy Attacks.")
		_tick(enemy_units, player_units)
		await  get_tree().create_timer(0.3).timeout
	
	print("Battle Over.")
	emit_signal("battle_over", {
		"victory": enemy_units.is_empty()
	})

func _tick(attacking, defending):
	for unit in attacking:
		if unit.is_alive():
			print(" - Attack: %s" % unit.attack)
			print(" - Health: %s" % unit.current_hp)
			unit.perform_attack(defending)

func _on_unit_died(unit):
	player_units.erase(unit)
	enemy_units.erase(unit)
