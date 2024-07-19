extends EnemyState
class_name HurtEnemyState


func enter_state() -> void:
	call_animation.emit(animName)


func exit_state() -> void:
	pass


func animation_finished() -> void:
	stateMachine.change_state(stateMachine.idleState)
