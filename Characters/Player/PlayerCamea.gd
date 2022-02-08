extends Camera2D

func _set_camera_limits() -> void:
	var level_map = get_tree().current_scene.get_node("Level").get_children()
	var limits = {left=0, right=0, top=0, bottom=0}
	for tilemap in level_map:
		if tilemap is TileMap:
			var used = tilemap.get_used_rect()
			limits.left = min(used.position.x * tilemap.cell_size.x, limits.left)
			limits.right = max(used.end.x * tilemap.cell_size.x, limits.right)
			limits.top = min(used.position.y * tilemap.cell_size.y, limits.top)
			limits.bottom = max(used.end.y * tilemap.cell_size.y, limits.bottom)
	limit_bottom = limits.bottom
	limit_left = limits.left
	limit_right = limits.right
	limit_top = limits.top
	var global_camera: Camera2D = get_tree().current_scene.get_node("Camera2D")
	global_camera.limit_bottom = limits.bottom
	global_camera.limit_left = limits.left
	global_camera.limit_right = limits.right
	global_camera.limit_top = limits.top

func _ready() -> void:
	_set_camera_limits()
