extends MovementState
class_name DashState

# Variables
@export var dashTimer : Timer
@export var dashCooldown : float
@export var dashSpeed : float
@export var maxDashes : int = 2

var dashes : int


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	
	dashes = maxDashes
	dashTimer.wait_time = dashCooldown


func enter_state() -> void:
	if dashes == 0:
		stateMachine.change_state(stateMachine.idleState)
		return
	
	set_process(true)


func exit_state() -> void:
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _dash() -> void:
	pass
