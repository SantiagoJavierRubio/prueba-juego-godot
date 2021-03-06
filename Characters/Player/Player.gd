extends Character

onready var weapons: Node = $Weapons
var weapon: Node2D
enum WEAPON_LIST {Sword, GreatSword, Bow}

func _ready():
	weapon = weapons.get_child(0)
	weapon.show()
	$CollisionShape2D.disabled = false

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	if mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
		weapon.z_index = 2
	elif mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
		weapon.z_index = 0
	weapon.aim(mouse_direction)
	
func _change_weapon(weapon_num: int) -> void:
	weapon.hide()
	weapon = weapons.get_child(weapon_num)
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
	if Input.is_action_just_pressed("ui_inv_1"):
		_change_weapon(WEAPON_LIST.Sword)
	if Input.is_action_just_pressed("ui_inv_2"):
		_change_weapon(WEAPON_LIST.GreatSword)
	if Input.is_action_just_pressed("ui_inv_3"):
		_change_weapon(WEAPON_LIST.Bow)

func switch_to_global_camera() -> void:
		var global_camera: Camera2D = get_parent().get_node("Camera2D")
		global_camera.position = position
		global_camera.current = true
		$Camera2D.current = false
