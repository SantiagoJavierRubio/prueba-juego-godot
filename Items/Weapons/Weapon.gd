extends Node2D
class_name Weapon

export(float) var agility: float = 1.0
export(int) var damage: int = 100

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var hitbox: Area2D = $Sprite/Hitbox
onready var agility_timer: Timer = $AgilityTimer

var can_attack: bool = true
var aim_direction: Vector2 = Vector2.ZERO

func _ready():
	agility_timer.wait_time = (1.0/agility) + 0.075
	animation_player.playback_speed = 1.0 * agility
	hitbox.damage = damage

func aim(mouse_direction) -> void:
	z_index = 1
	self.rotation = mouse_direction.angle()
	if self.scale.y == 1 and mouse_direction.x < 0:
		self.scale.y = -1
	elif self.scale.y == -1 and mouse_direction.x > 0:
		self.scale.y = 1
	aim_direction = mouse_direction
	hitbox.knockback_direction = mouse_direction

func attack() -> void:
	if can_attack:
		can_attack = false
		agility_timer.start()
		animation_player.play("attack")

func _on_AgilityTimer_timeout():
	can_attack = true

func _shoot_projectile(PROJECTILE_SCENE: PackedScene, projectile_speed) -> void:
	var projectile: Area2D = PROJECTILE_SCENE.instance()
	projectile.damage = damage
	projectile.launch(global_position, aim_direction, projectile_speed)
	get_tree().current_scene.add_child(projectile)
