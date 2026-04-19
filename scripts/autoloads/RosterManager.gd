extends Node

var units: Array[UnitData] = [
	InformationDB.get_unit(InformationDB.UnitKey.TANK),
	InformationDB.get_unit(InformationDB.UnitKey.TANK),
	InformationDB.get_unit(InformationDB.UnitKey.TANK)
]

func get_team_snapshot():
	return units.duplicate(true)
