extends MovementState
class_name RangeState

# Variables
@export var comboTimer : Timer
@export var comboDuration : float = 1
@export var cooldownTimer : Timer
@export var cooldownDuration : float = .25
@export var comboAnims : Array[String]
@export var bulletPrefab : PackedScene
@export var bulletSpawnPos : Marker2D
@export var damage : int = 1

var currentCombo : int = 0
var attackTargetPos : Vector2 = Vector2.ZERO


func _ready():
	cooldownTimer.wait_time = cooldownDuration
	comboTimer.wait_time = comboDuration
	
	comboTimer.timeout.connect(_combo_timeout)


func enter_state() -> void:
	_play_attack_animation()


func exit_state() -> void:
	pass


func _play_attack_animation() -> void:
	## Check if cooldowning after combo
	if !cooldownTimer.is_stopped() and currentCombo == 0:
		stateMachine.change_state(stateMachine.idleState)
	
	call_animation.emit(comboAnims[currentCombo])
	
	if currentCombo + 1 >= comboAnims.size():
		currentCombo = 0
		cooldownTimer.start()
	else:
		currentCombo += 1
		comboTimer.start()


func _combo_timeout() -> void:
	currentCombo = 0


func animation_finished() -> void:
	if stateMachine.currentState == self:
		stateMachine.change_state(stateMachine.idleState)


func changed_attack_modes() -> void:
	stateMachine.change_state(stateMachine.idleState)


func _spawn_attack() -> void:
	var newBullet : MovingRangeAttack = bulletPrefab.instantiate()
	add_child(newBullet)
	newBullet.global_position = bulletSpawnPos.global_position
	newBullet.initialize_attack(damage, attackTargetPos, true)
