extends MovementState
class_name RunState


# Variables
@export var movementSpeed : int

var direction : Vector2 = Vector2.ZERO ## Direction actor is moving in


# Signals
signal flip_sprite(_facingLeft : bool)


func _ready():
	set_process(false)


func enter_state() -> void:
	set_process(true)


func exit_state() -> void:
	set_process(false)


func _process(delta):
	_movement_controls()
	check_for_input()


func _movement_controls():
	## Get input
	direction.x = Input.get_action_strength("move right") - Input.get_action_strength("move left")
	direction.y = Input.get_action_strength("move down") - Input.get_action_strength("move up")
	direction = direction.normalized()

	## Check for idle state
	if direction == Vector2.ZERO:
		stateMachine.change_state(stateMachine.idleState)
		return

	## Calculate movement
	stateMachine.actor.velocity = direction * movementSpeed
	stateMachine.actor.move_and_slide()
	
	## Set facing direction
	if direction.x < 0:
		flip_sprite.emit(true)
	elif direction.x > 0:
		flip_sprite.emit(false)
	
	call_animation.emit(animName)


func check_for_input() -> void:
	if Input.is_action_just_pressed("melee attack") and stateMachine.meleeMode:
		stateMachine.change_state(stateMachine.meleeState)
	elif Input.is_action_just_pressed("range attack") and !stateMachine.meleeMode:
		stateMachine.change_state(stateMachine.rangeState)
