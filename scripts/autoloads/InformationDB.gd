extends Node

const UnitKey = {
	TANK = "tank"
}

const EnemyKey = {
	SLIME = "slime"
}

const BossKey = {
	BASE_BOSS = "base_boss"
}

var _units: Dictionary = {
	UnitKey.TANK: preload("res://data/units/tank.tres")
}

var _enemies: Dictionary = {
	EnemyKey.SLIME: preload("res://data/enemies/slime.tres")
}

var _bosses: Dictionary = {
	BossKey.BASE_BOSS: preload("res://data/bosses/base_boss.tres")
}

func get_unit(key: String) -> UnitData:
	return _units.get(key)

func get_enemy(key: String) -> UnitData:
	return _enemies.get(key)

func get_boss(key: String) -> BossData:
	return _bosses.get(key)

func get_battle_config(stage):
	if stage == "boss":
		return {
			"enemy_team": get_boss(BossKey.BASE_BOSS).enemy_team
		}
	else:
		return {
			"enemy_team": [ get_enemy(EnemyKey.SLIME) ]
		}
