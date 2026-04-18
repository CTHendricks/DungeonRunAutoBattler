extends HBoxContainer

var health: int = 0
var attack: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$attack_label.text = str(attack)
	$health_label.text = str(health)

func update_health(new_health: int) -> void:
	$health_label.text = str(new_health)
