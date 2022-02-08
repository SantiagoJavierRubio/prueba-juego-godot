extends Area2D
class_name Hitbox

var damage: int
var knockback_direction: Vector2 = Vector2.ZERO
export(int) var knockback_force: int = 250
var body_inside: bool = false

onready var collision_shape: CollisionShape2D = get_child(0)
onready var timer: Timer = Timer.new()

func _init() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")
	__ = connect("body_exited", self, "_on_body_exited")
	
func _ready() -> void:
#	assert(collision_shape != null)
	timer.wait_time = 1
	add_child(timer)
	if collision_shape:
		collision_shape.disabled = true

func _on_body_entered(body: PhysicsBody2D) -> void:
	body_inside = true
	timer.start()
	while body_inside:
		_collide(body)
		yield(timer, "timeout")

func _on_body_exited(body: KinematicBody2D) -> void:
	body_inside = false
	timer.stop()
	
func _collide(body: KinematicBody2D) -> void:
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		body.take_damage(damage, knockback_direction, knockback_force)

