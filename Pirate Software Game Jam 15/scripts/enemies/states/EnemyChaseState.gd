extends EnemyState
class_name EnemyChaseState

# Variables
@export var chaseDistance : float
@export var chaseSpeed : float


func _ready() -> void:
	set_process(false)


func _process(delta):
	_chase_player()


func enter_state() -> void:
	set_process(true)
	super.call_animation(animName)


func exit_state() -> void:
	set_process(false)


func _chase_player() -> void:
	if stateMachine.enemy.global_position.distance_to(stateMachine.enemy.player.global_position) > chaseDistance:
		stateMachine.change_state(stateMachine.wanderState)
	elif stateMachine.enemy.global_position.distance_to(stateMachine.enemy.player.global_position) <= stateMachine.attackState.attackDistance:
		stateMachine.change_state(stateMachine.attackState)
	else:
		stateMachine.agent.target_position = stateMachine.enemy.player.global_position
		var direction : Vector2 = stateMachine.agent.get_next_path_position() - stateMachine.enemy.global_position
		direction = direction.normalized()
		stateMachine.enemy.velocity = direction * chaseSpeed
		stateMachine.enemy.move_and_slide()
		
		if direction.x < 0:
			super.call_flip(true)
		elif direction.x > 0:
			super.call_flip(false)
