extends Enemy

const PROXIMITY_ATTACK_DISTANCE: int = 25

const FIREBALL_SCENE: PackedScene = preload("res://Characters/Enemies/Mage/Fireball.tscn") 

var distance_to_player: int
export(int) var cast_time: int = 100
export(int) var projectile_speed: int = 150
export(int) var fireball_damage: int = 10
export(int) var proximity_damage: int = 5
export(int) var max_range:int = 80
export(int) var min_range:int = 60

onready var attack_timer: Timer = $AttackTimer
onready var proximity_attack: Area2D = $ProximityAttack
var can_attack: bool = true

func _ready():
	proximity_attack.damage = proximity_damage
	attack_timer.wait_time = cast_time/100
	
func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		distance_to_player = (player.position - global_position).length()
		if distance_to_player <= PROXIMITY_ATTACK_DISTANCE and can_attack:
			proximity_attack.trigger_attack(player.position)
		if distance_to_player > max_range:
			_get_path_to_player()
		elif distance_to_player < min_range:
			_get_path_away_from_player()
		else:
			if can_attack:
				can_attack = false
				_throw_fireball()
				attack_timer.start()
	else:
		PathTimer.stop()
		path = []
		mov_direction = Vector2.ZERO

func _get_path_away_from_player() -> void:
	var dir: Vector2 = (global_position - player.position).normalized()
	path = navigation.get_simple_path(global_position, global_position + dir * 100)

func _throw_fireball() -> void:
	var fireball: Area2D = FIREBALL_SCENE.instance()
	fireball.damage = fireball_damage
	fireball.launch(global_position, (player.position - global_position).normalized(), projectile_speed)
	get_tree().current_scene.add_child(fireball)
	
func _on_AttackTimer_timeout():
	can_attack = true
