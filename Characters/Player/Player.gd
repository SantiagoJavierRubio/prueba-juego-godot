extends Character

onready var weapons: Node = $Weapons
var weapon: Node2D

func _ready():
	weapon = weapons.get_child(0)
	weapon.show()

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
		weapon.z_index = 2
	elif mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
		weapon.z_index = 0
	weapon.aim(mouse_direction)
	
func _change_weapon() -> void:
	weapon.hide()
	weapon = weapons.get_child(1)
	weapon.show()

func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		mov_direction += Vector2.UP
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_just_pressed("ui_attack"):
		weapon.attack()
	if Input.is_action_just_pressed("ui_accept"):
		_change_weapon()
