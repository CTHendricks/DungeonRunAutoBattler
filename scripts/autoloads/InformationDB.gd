extends Node

var units: Dictionary = {
	"tank": preload("res://data/units/tank.tres")
}

var enemies: Dictionary = {
	"slime": preload("res://data/enemies/slime.tres")
}

var bosses: Dictionary = {
	"base_boss": preload("res://data/bosses/base_boss.tres")
}

func get_battle_config(stage):
	if stage == "boss":
		return {
			"enemy_team": bosses["base_boss"].enemy_team
		}
	else:
		return {
			"enemy_team": [ enemies["slime"] ]
		}
