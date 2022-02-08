extends Weapon

const ARROW_SCENE: PackedScene = preload("res://Items/Weapons/Bow/Arrow.tscn")
export(int) var arrow_speed: int = 1000

func attack() -> void:
	if can_attack:
		can_attack = false
		_shoot_projectile(ARROW_SCENE, arrow_speed)
		agility_timer.start()
		animation_player.play("attack")
