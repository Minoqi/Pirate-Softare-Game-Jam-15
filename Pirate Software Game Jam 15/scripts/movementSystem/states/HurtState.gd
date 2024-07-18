extends MovementState
class_name HurtState


func enter_state() -> void:
	call_animation.emit(animName)


func end_state() -> void:
	pass


func animation_finished() -> void:
	if stateMachine.currentState == self:
		stateMachine.change_state(stateMachine.idleState)
