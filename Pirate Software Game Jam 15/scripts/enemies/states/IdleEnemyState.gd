extends EnemyState
class_name IdleEnemyState

# Variables
@export var idleTimer : Timer
@export var idleDuration : float = 5


func _ready():
	set_process(false)
	idleTimer.timeout.connect(_idle_timeout)
	idleTimer.wait_time = idleDuration


func enter_state() -> void:
	set_process(true)
	call_animation.emit(animName)
	#idleTimer.start()


func exit_state() -> void:
	set_process(false)


func _process(delta):
	_wait_for_player()


func _wait_for_player() -> void:
	if global_position.distance_to(stateMachine.actor.player.global_position) < stateMachine.distanceToChase:
		idleTimer.stop()
		stateMachine.chasePlayer = true
		stateMachine.change_state(stateMachine.moveState)


## Switch to wandering while waiting for the player
func _idle_timeout() -> void:
	stateMachine.chasePlayer = false
	stateMachine.change_state(stateMachine.moveState)
