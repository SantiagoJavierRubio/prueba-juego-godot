extends Enemy

onready var hitbox: Area2D = $Hitbox
export(int) var damage: int = 10

func _ready() -> void:
	hitbox.damage = damage

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
