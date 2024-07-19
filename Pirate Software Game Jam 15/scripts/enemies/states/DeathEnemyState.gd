extends EnemyState
class_name DeathEnemyState


func enter_state() -> void:
	call_animation.emit(animName)


func exit_state() -> void:
	pass


func animation_finished() -> void:
	queue_free()
