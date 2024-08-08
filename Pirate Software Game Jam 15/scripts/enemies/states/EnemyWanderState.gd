extends EnemyState
class_name EnemyWanderState

# Variables
@export var wanderSpeed : int = 90
@export var targetDistance : int = 2

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var targetPosition : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move_to_target()


func enter_state() -> void:
	_generate_new_point()
	super.call_animation(animName)
	set_process(true)


func exit_state() -> void:
	set_process(false)


func _generate_new_point() -> void:
	targetPosition = stateMachine.enemy.room.wanderPoints.pick_random().global_position


func _move_to_target() -> void:
	if stateMachine.enemy.global_position.distance_to(targetPosition) <= targetDistance:
		stateMachine.change_state(stateMachine.idleState)
	if stateMachine.enemy.global_position.distance_to(stateMachine.enemy.player.global_position) <= stateMachine.chaseState.chaseDistance:
		stateMachine.change_state(stateMachine.chaseState)
	elif stateMachine.enemy.global_position.distance_to(stateMachine.enemy.player.global_position) <= stateMachine.attackState.attackDistance:
		stateMachine.change_state(stateMachine.attackState)
	else:
		stateMachine.agent.target_position = targetPosition
		var direction : Vector2 = stateMachine.agent.get_next_path_position() - stateMachine.enemy.global_position
		direction = direction.normalized()
		stateMachine.enemy.velocity = direction * wanderSpeed
		stateMachine.enemy.move_and_slide()
		
		if direction.x < 0:
			super.call_flip(true)
		elif direction.x > 0:
			super.call_flip(false)
