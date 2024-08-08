extends Node2D
class_name EnemyStateMachine

# Variables
@export var agent : NavigationAgent2D
@export var startingState : EnemyState
@export var idleState : EnemyIdleState
@export var wanderState : EnemyWanderState
@export var chaseState : EnemyChaseState
@export var attackState : EnemyState

var enemy : Enemy
var currentState : EnemyState


# Called when the node enters the scene tree for the first time.
func _ready():
	idleState.stateMachine = self
	wanderState.stateMachine = self
	chaseState.stateMachine = self
	attackState.stateMachine = self
	
	currentState = startingState
	currentState.enter_state()


func change_state(_newState : EnemyState) -> void:
	currentState.exit_state()
	currentState = _newState
	currentState.enter_state()
