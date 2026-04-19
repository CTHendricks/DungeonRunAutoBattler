extends Node
class_name MapGenerator

const X_DIST = 50
const Y_DIST = 50
const FLOORS = 10
const MAP_WIDTH = 3

var new_map = [
	[Room.Type.BATTLE],
	[Room.Type.BATTLE],
	[Room.Type.MINI, Room.Type.MINI, Room.Type.MINI],
	[Room.Type.SHOP],
	[Room.Type.BATTLE],
	[Room.Type.BATTLE],
	[Room.Type.MINI, Room.Type.MINI, Room.Type.MINI],
	[Room.Type.SHOP],
	[Room.Type.BATTLE],
	[Room.Type.BOSS]
]

var map_data: Array[Array]

func generate_map() -> Array[Array]:
	map_data = _generate_initial_grid()
	
	set_up_next_rooms()
	
	return map_data

func _generate_initial_grid() -> Array[Array]:
	var result: Array[Array]
	
	var count: int = 0
	for i in new_map:
		var adjacent_rooms: Array[Room] = []
		
		var column_count: int = 0
		for j in i:
			var current_room = Room.new()
			current_room.type = j
			
			if i.size() > 1:
				current_room.position = Vector2(column_count * X_DIST, count * -Y_DIST)
			else:
				current_room.position = Vector2(50, count * -Y_DIST)
			
			current_room.row = count
			#current_room.column = count
			current_room.next_rooms = [] as Array[Room]
			
			if count == 9:
				current_room.position.y = (count + 1) * -Y_DIST
			
			adjacent_rooms.append(current_room)
			
			column_count += 1
		
		result.append(adjacent_rooms)
		count += 1
	
	return result

func set_up_next_rooms():
	var count = 0
	for x in map_data:
		if count < 9:
			for y in x:
				for i in map_data[count+1]:
					y.next_rooms.append(i)
		count += 1
