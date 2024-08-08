extends EnemyState
class_name EnemyIdleState

# Variables
@export var idleTimer : Timer
@export var idleDuration : Vector2

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	set_process(false)
	idleTimer.wait_time = rng.randf_range(idleDuration.x, idleDuration.y)
	idleTimer.timeout.connect(_change_to_wandering_state)


func _process(delta):
	_check_for_player()


func enter_state() -> void:
	idleTimer.start()
	super.call_animation(animName)
	set_process(true)


func exit_state() -> void:
	idleTimer.stop()
	set_process(false)


func _check_for_player() -> void:
	if stateMachine.enemy.global_position.distance_to(stateMachine.enemy.player.global_position) <= stateMachine.chaseState.chaseDistance:
		stateMachine.change_state(stateMachine.chaseState)


func _change_to_wandering_state() -> void:
	stateMachine.change_state(stateMachine.wanderState)
