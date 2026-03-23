extends Node2D

signal died(unit)

var data
var current_hp: int
var attack: int

func set_from_data(unit_data):
	data = unit_data
	current_hp = unit_data.base_health
	attack = unit_data.base_attack

func is_alive():
	return current_hp > 0

func take_damage(amount):
	current_hp -= amount
	
	if current_hp <= 0:
		emit_signal("died", self)
		queue_free()

func perform_attack(target_side):
	if target_side.is_empty():
		return
	
	target_side[0].take_damage(attack)
