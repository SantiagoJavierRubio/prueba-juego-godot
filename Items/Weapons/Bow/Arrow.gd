extends Hitbox

var direction: Vector2 = Vector2.ZERO
var arrow_speed: float = 0

func launch(initial_pos: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_pos
	direction = dir
	knockback_direction = dir
	arrow_speed = speed
	rotation += dir.angle()
	
func _physics_process(delta: float) -> void:
	position += direction * arrow_speed * delta

func _collide(body: KinematicBody2D) -> void:
	if body != null:
		body.take_damage(damage, knockback_direction, knockback_force)
	queue_free()
