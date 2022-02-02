extends Character

class_name Enemy

var path: PoolVector2Array

export(int) var chase_speed: int = 1

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Level")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var PathTimer: Timer = $PathTimer

func chase() -> void:
	if path:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		if distance_to_next_point < chase_speed:
			path.remove(0)
			if not path:
				return
		if vector_to_next_point.x > 0 and mov_direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and mov_direction.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true
		mov_direction = vector_to_next_point
		state_machine.set_state(state_machine.states.chase)
	else:
		state_machine.set_state(state_machine.states.idle)


func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		_get_path_to_player()
	else:
		PathTimer.stop()
		path = []
		mov_direction = Vector2.ZERO

func _get_path_to_player() -> void:
	path = navigation.get_simple_path(global_position, player.global_position)
