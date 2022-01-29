extends KinematicBody2D

class_name Character

const FRICTION: float = 0.15

export(int) var acceleration: int = 20
export(int) var max_speed: int = 100
export(int) var hp: int = 10

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var state_machine: Node = $StateMachine

var mov_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
		velocity = move_and_slide(velocity)
		velocity = lerp(velocity, Vector2.ZERO, FRICTION)
		
func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * acceleration
	velocity = velocity.clamped(max_speed)
	
func take_damage(dmg: int, dir: Vector2, force: int ) -> void:
	if state_machine.state != state_machine.states.hit:
		hp -= dmg
		if hp > 0:
			velocity += dir * force
			state_machine.set_state(state_machine.states.hit)
		else:
			velocity += dir * force * 2
			state_machine.set_state(state_machine.states.die)
