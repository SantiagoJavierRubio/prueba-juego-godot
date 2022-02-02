extends Node2D
class_name Weapon

export(int) var damage: int = 1
export(float) var agility: float = 1.0

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var hitbox: Area2D = $Sprite/Hitbox
onready var agility_timer: Timer = $AgilityTimer

var can_attack: bool = true

func _ready():
	hitbox.get_child(0).disabled = true
	hitbox.damage = damage
	agility_timer.wait_time = (1.0/agility) + 0.075
	animation_player.playback_speed = 1.0 * agility

func aim(mouse_direction) -> void:
	self.rotation = mouse_direction.angle()
	if self.scale.y == 1 and mouse_direction.x < 0:
		self.scale.y = -1
	elif self.scale.y == -1 and mouse_direction.x > 0:
		self.scale.y = 1
	hitbox.knockback_direction = mouse_direction
	
func attack() -> void:
	if can_attack:
		can_attack = false
		agility_timer.start()
		animation_player.play("attack")

func _on_AgilityTimer_timeout():
	can_attack = true
