extends CanvasLayer


var max_hp: int = 100

onready var player: KinematicBody2D = get_parent().get_node("Player")
onready var health_bar: TextureProgress = $HealthBar
onready var health_bar_tween: Tween = $HealthBar/Tween

func _ready() -> void:
	max_hp = player.hp
	_update_health_bar(max_hp)

func _update_health_bar(new_hp: int) -> void:
		var __ = health_bar_tween.interpolate_property(health_bar, "value", health_bar.value,
		new_hp, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
		__ = health_bar_tween.start()


func _on_Player_hp_changed(new_hp: int) -> void:
	var new_health: int = int((100 - 0) * float(new_hp) / max_hp)
	_update_health_bar(new_health)
