extends Hitbox

onready var animation_player: AnimationPlayer = $Sprite/AnimationPlayer
onready var proximity_attack_timer: Timer = $ProximityAttackTimer
onready var sprite: AnimatedSprite = $Sprite
export(int) var proximity_attack_cast_time: int = 1000

var can_trigger: bool = true

func _ready() -> void:
	assert(collision_shape != null)
	sprite.visible = false
	proximity_attack_timer.wait_time = proximity_attack_cast_time/100
	
func trigger_attack(player_pos: Vector2) -> void:
	knockback_direction = (player_pos - global_position).normalized()
	if can_trigger:
		can_trigger = false
		animation_player.play("attack")
		proximity_attack_timer.start()

func _on_ProximityAttackTimer_timeout():
	can_trigger = true
