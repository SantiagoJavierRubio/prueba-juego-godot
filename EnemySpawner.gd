extends Node2D

var available_positions: Array
onready var positions: Node2D = $Positions
onready var base_position: Position2D = $BasePosition

func _ready():
	if is_instance_valid(positions):
		available_positions = positions.get_children()

func get_roaming_position() -> Position2D:
	randomize()
	if available_positions.size() > 0:
		var rand_index: int = randi() % available_positions.size()
		return available_positions[rand_index]
	else:
		return base_position
