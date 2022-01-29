extends StateMachine

func _init() -> void:
	add_state("idle")
	add_state("chase")
	add_state("hit")
	add_state("die")

func _ready() -> void:
	set_state(states.chase)
	
func _state_logic(delta):
	match state:
		states.chase:
			parent.chase()
			parent.move()

func _get_transition(delta):
	match state:
		states.hit:
			if not animation_player.is_playing():
				return states.chase
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.chase:
			animation_player.play('move')
		states.idle:
			animation_player.play('idle')
		states.hit:
			animation_player.play('hit')
		states.die:
			animation_player.play('die')

func _exit_state(old_state, new_state):
	pass
