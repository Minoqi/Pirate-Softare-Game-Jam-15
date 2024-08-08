extends EnemyState
class_name EnemyMeleeAttackState

# Variables
@export var attackTimer : Timer
@export var attackCooldown : float
@export var attackDistance : float
@export var weapon : Sprite2D
@export var weaponHolder : Marker2D
@export var weaponHolderMaxDistance : int = 20
@export var weaponAnimator : AnimationPlayer


func _ready():
	attackTimer.wait_time = attackCooldown


func _process(delta):
	pass
	#_rotate_weapon()


func enter_state() -> void:
	if !attackTimer.is_stopped():
		stateMachine.change_state(stateMachine.idleState)
		return
	
	weaponAnimator.play("swing")


func exit_state() -> void:
	pass


func end_attack() -> void:
	attackTimer.start()
	stateMachine.change_state(stateMachine.idleState)


func _rotate_weapon() -> void:
	var mousePos : Vector2 = get_global_mouse_position()
	var targetDirection : Vector2 = stateMachine.enemy.player.global_position - stateMachine.enemy.global_position
	targetDirection = targetDirection.normalized() * weaponHolderMaxDistance
	weaponHolder.global_position = targetDirection + global_position
	weaponHolder.global_position.y += -18
	weapon.look_at(stateMachine.enemy.player.global_position)
