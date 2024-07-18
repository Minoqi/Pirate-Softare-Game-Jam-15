extends Node2D
class_name MovementSystem

# Variables
@export var startingState : MovementState
@export var nodesToFlip : Array[Node2D]

@export_group("States")
@export var idleState : IdleState
@export var walkState : WalkState
@export var runState : RunState
@export var hurtState : HurtState
@export var deathState : DeathState
@export var meleeState : MeleeState
@export var rangeState : RangeState
var ultimateState

var currentState : MovementState
var actor : CharacterBody2D
var isFacingLeft : bool = false
var meleeMode : bool = true


# Signals
signal call_animation(_animName : String)
signal attack_mode_changed


func initialize_movement_controls(_actor : CharacterBody2D, _animator : AnimationSystem, _healthComponent : HealthComponent):
	## Store references to states
	actor = _actor
	idleState.stateMachine = self
	walkState.stateMachine = self
	runState.stateMachine = self
	hurtState.stateMachine = self
	deathState.stateMachine = self
	meleeState.stateMachine = self
	rangeState.stateMachine = self
	
	## Connect signals
	_healthComponent.took_damage.connect(_took_damage)
	_healthComponent.died.connect(_died)
	call_animation.connect(_animator.play_animation)
	idleState.call_animation.connect(_call_animation)
	walkState.call_animation.connect(_call_animation)
	walkState.flip_sprite.connect(_flip_nodes)
	runState.call_animation.connect(_call_animation)
	runState.flip_sprite.connect(_flip_nodes)
	hurtState.call_animation.connect(_call_animation)
	_animator.animation_done.connect(hurtState.animation_finished)
	deathState.call_animation.connect(_call_animation)
	_animator.animation_done.connect(deathState.animation_finished)
	meleeState.call_animation.connect(_call_animation)
	_animator.animation_done.connect(meleeState.animation_finished)
	attack_mode_changed.connect(meleeState.changed_attack_modes)
	rangeState.call_animation.connect(_call_animation)
	_animator.animation_done.connect(rangeState.animation_finished)
	attack_mode_changed.connect(rangeState.changed_attack_modes)
	
	## Activate initial state
	currentState = startingState
	currentState.enter_state()


func _process(delta):
	_change_attack_modes()


func change_state(_newState: MovementState) -> void:
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


func _change_attack_modes() -> void:
	if Input.is_action_just_pressed("attack swap"):
		meleeMode = !meleeMode
		attack_mode_changed.emit()


func _took_damage() -> void:
	change_state(hurtState)


func _died() -> void:
	change_state(deathState)
