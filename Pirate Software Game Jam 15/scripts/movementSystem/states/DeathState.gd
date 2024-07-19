extends MovementState
class_name DeathState


func enter_state() -> void:
	call_animation.emit(animName)


func end_state() -> void:
	pass


func animation_finished() -> void:
	if stateMachine.currentState == self:
		queue_free()
		#stateMachine.change_state(stateMachine.idleState)
