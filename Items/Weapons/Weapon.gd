extends Node2D
class_name Weapon

export(int) var damage:int = 10

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var hitbox: Area2D = $Sprite/Hitbox

func _ready():
	hitbox.damage = damage

func aim(mouse_direction) -> void:
	self.rotation = mouse_direction.angle()
	if self.scale.y == 1 and mouse_direction.x < 0:
		self.scale.y = -1
	elif self.scale.y == -1 and mouse_direction.x > 0:
		self.scale.y = 1
	hitbox.knockback_direction = mouse_direction
	
func attack() -> void:
	pass
