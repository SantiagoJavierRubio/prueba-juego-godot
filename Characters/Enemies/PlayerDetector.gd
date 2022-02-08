extends Area2D

func _on_PlayerDetector_body_entered(body: KinematicBody2D) -> void:
	if is_instance_valid(body) and body.is_in_group("player"):
		get_parent().player_detected()


func _on_PlayerDetector_body_exited(body: KinematicBody2D) -> void:
	if is_instance_valid(body) and body.is_in_group("player"):
		get_parent().player_exited_detection_area()
