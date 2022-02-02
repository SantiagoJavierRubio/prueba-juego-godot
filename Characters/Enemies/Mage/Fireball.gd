extends Hitbox

onready var animation_player: AnimationPlayer = $AnimationPlayer

var enemy_exited: bool = false

var direction: Vector2 = Vector2.ZERO
var fireball_speed: float = 0

func _ready():
	animation_player.play("flying")

func launch(initial_pos: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_pos
	direction = dir
	knockback_direction = dir
	fireball_speed = speed
	rotation += dir.angle()
	
func _physics_process(delta: float) -> void:
	position += direction * fireball_speed * delta


func _on_Fireball_body_exited(body: KinematicBody) -> void:
	if not enemy_exited:
		enemy_exited = true
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)

func _collide(body: KinematicBody2D) -> void:
	if 	enemy_exited:
		if body != null:
			body.take_damage(damage, knockback_direction, knockback_force)
		fireball_speed = fireball_speed/10
		rotation = 0
		animation_player.play("explode")
