extends Node2D
class_name EnemyControls


# Variables
@export var startingState : EnemyState
@export var nodesToFlip : Array[Node2D]
@export var distanceToChase : float = 300

@export_group("States")
@export var idleState : IdleEnemyState
@export var moveState : MoveEnemyState
@export var hurtState : HurtEnemyState
@export var deathState : DeathEnemyState
@export var attackState : AttackEnemyState

var currentState : EnemyState
var actor : Node2D
var isFacingLeft : bool = false
var chasePlayer : bool = true
var meleeMode : bool = true


# Signals
signal call_animation(_animName : String)
signal attack_mode_changed


func initialize_enemy_controls(_actor : EnemyManager, _animator : AnimationSystem, _healthComponent : HealthComponent):
	## Store references to states
	actor = _actor
	idleState.stateMachine = self
	moveState.stateMachine = self
	hurtState.stateMachine = self
	deathState.stateMachine = self
	attackState.stateMachine = self
	
	## Connect signals
	_healthComponent.took_damage.connect(_took_damage)
	_healthComponent.died.connect(_died)
	call_animation.connect(_animator.play_animation)
	idleState.call_animation.connect(_call_animation)
	moveState.call_animation.connect(_call_animation)
	moveState.flip_sprite.connect(_flip_nodes)
	hurtState.call_animation.connect(_call_animation)
	_animator.animation_done.connect(hurtState.animation_finished)
	deathState.call_animation.connect(_call_animation)
	_animator.animation_done.connect(deathState.animation_finished)
	attackState.call_animation.connect(_call_animation)
	_animator.animation_done.connect(attackState.animation_finished)
	
	## Activate initial state
	currentState = startingState
	currentState.enter_state()


func change_state(_newState: EnemyState) -> void:
	if currentState == deathState:
		return
	
	currentState.exit_state()
	_newState.enter_state()
	currentState = _newState


func _call_animation(_animName : String) -> void:
	call_animation.emit(_animName)


func _flip_nodes(_facingLeft : bool) -> void:
	if _facingLeft != isFacingLeft:
		isFacingLeft = _facingLeft
		
		for node in nodesToFlip:
			node.scale.x *= -1


func _took_damage() -> void:
	change_state(hurtState)


func _died() -> void:
	change_state(deathState)
