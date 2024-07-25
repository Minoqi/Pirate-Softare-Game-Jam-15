extends EnemyState
class_name DeathEnemyState

var enteredDeath : bool = false


func enter_state() -> void:
	call_animation.emit(animName)


func exit_state() -> void:
	pass


func animation_finished() -> void:
	if !enteredDeath and stateMachine.currentState == self:
		enteredDeath = true
		var demonSoul = stateMachine.actor.demonSoulPrefab.instantiate()
		stateMachine.actor.room.add_child(demonSoul)
		demonSoul.global_position = stateMachine.actor.global_position
		
		stateMachine.actor.queue_free()
