extends Node2D

@onready var unit_scene = preload("res://scenes/unit.tscn")

signal battle_over(result)

var player_units = []
var enemy_units = []

func setup(player_team, enemy_team):
	_spawn_units(player_team, enemy_team)
	_start_battle_loop()

func _spawn_units(player_team, enemy_team):
	var count = 0
	for u in player_team:
		var inst = unit_scene.instantiate()
		inst.set_from_data(u)
		inst.connect("died", _on_unit_died)
		inst.position = Vector2(100 - (count*40), 100)
		add_child(inst)
		player_units.append(inst)
		count += 1
	
	count = 0
	for e in enemy_team:
		var inst = unit_scene.instantiate()
		inst.set_from_data(e)
		inst.connect("died", _on_unit_died)
		inst.position = Vector2(150 + (count*40), 100)
		add_child(inst)
		enemy_units.append(inst)
		count += 1

func _start_battle_loop():
	await get_tree().create_timer(2.0).timeout
	while player_units.size() > 0 and enemy_units.size() > 0:
		#_tick(player_units, enemy_units)
		for u in player_units:
			if u.is_alive():
				u.perform_attack(enemy_units)
				await get_tree().create_timer(1.0).timeout
		
		#_tick(enemy_units, player_units)
		for e in enemy_units:
			if e.is_alive():
				e.perform_attack(player_units)
				await get_tree().create_timer(1.0).timeout
	
	emit_signal("battle_over", {
		"victory": enemy_units.is_empty()
	})

# Leaving this here for now, took it out since await does not fully block. It kicks you back to calling function so I was getting weird activity.
# Moved to just having the awaits all in start_new_loop as it can't kick back out to a meaningful function.
func _tick(attacking, defending):
	for unit in attacking:
		if unit.is_alive():
			unit.perform_attack(defending)

func _on_unit_died(unit):
	var count = 0
	if player_units.has(unit) and not player_units.is_empty():
		player_units.erase(unit)
		for u in player_units:
			u.position = Vector2(100 + (count*40), 100)
			count += 1
	count = 0
	if enemy_units.has(unit) and not enemy_units.is_empty():
		enemy_units.erase(unit)
		for e in enemy_units:
			e.position = Vector2(150 + (count*40), 100)
			count += 1
