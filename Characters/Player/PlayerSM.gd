extends StateMachine

func _init() -> void:
	add_state("idle")
	add_state("move")
	add_state("hit")
	add_state('die')
	
func _ready() -> void:
	set_state(states.idle)

func _state_logic(delta):
	if state in [states.idle, states.move]:
		parent.get_input()
		parent.move()

func _get_transition(delta):
	match state:
		states.idle:
			if parent.velocity.length() > 1:
				return states.move
		states.move:
			if parent.velocity.length() < 1:
				return states.idle
		states.hit:
			if not animation_player.is_playing():
				return states.idle
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.move:
			animation_player.play("move")
		states.hit:
			animation_player.play("hit")
		states.die:
			animation_player.play("die")

func _exit_state(old_state, new_state):
	pass
