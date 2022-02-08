extends Character

class_name Enemy

var path: PoolVector2Array

export(int) var chase_speed: int = 3

var max_steering: float = 3
var avoid_force: int = 2000

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Level")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var PathTimer: Timer = $PathTimer
onready var raycasts: Node2D = $Raycasts

func chase() -> void:
	_move_to_target(player)

func _move_to_target(target: Node2D) -> void:
	if path:
		_steer(target)
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

func _steer(target: Node2D) -> void:
	if is_instance_valid(target):
		var steering: Vector2 = Vector2.ZERO
		steering += (target.position - position)*max_speed
		steering += _avoid_obstacles_steer()
		steering = steering.clamped(max_steering)
		velocity += steering

func _avoid_obstacles_steer() -> Vector2:
	raycasts.rotation = velocity.angle()
	for raycast in raycasts.get_children():
		raycast.cast_to.x = velocity.length()
		if raycast.is_colliding():
			var obstacle = raycast.get_collider()
			return (position + velocity - obstacle.position).normalized() * avoid_force
	return Vector2.ZERO

func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		_get_path_to_player()
	else:
		PathTimer.stop()
		path = []
		mov_direction = Vector2.ZERO


func _get_path_to_player() -> void:
	path = navigation.get_simple_path(global_position, player.global_position)

func player_detected() -> void:
	pass

func player_exited_detection_area() -> void:
	pass

