extends MovementState
class_name IdleState


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


func enter_state() -> void:
	set_process(true)
	call_animation.emit(animName)


func exit_state() -> void:
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_for_input()


func check_for_input() -> void:
	if Input.is_action_pressed("move down") || Input.is_action_pressed("move left") || Input.is_action_pressed("move right") || Input.is_action_pressed("move up"):
		stateMachine.change_state(stateMachine.runState)
	elif Input.is_action_just_pressed("melee attack") and stateMachine.meleeMode:
		stateMachine.change_state(stateMachine.meleeState)
	elif Input.is_action_just_pressed("range attack") and !stateMachine.meleeMode:
		stateMachine.rangeState.attackTargetPos = get_global_mouse_position()
		stateMachine.change_state(stateMachine.rangeState)
