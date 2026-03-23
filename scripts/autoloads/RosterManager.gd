extends Node

var units: Array[UnitData] = [
	InformationDB.units["tank"]
]

func get_team_snapshot():
	return units.duplicate(true)
