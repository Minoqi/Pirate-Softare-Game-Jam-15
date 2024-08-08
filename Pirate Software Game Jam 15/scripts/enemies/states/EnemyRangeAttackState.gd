extends EnemyState
class_name EnemyRangeAttackState

# Variables
@export var bulletPrefab : PackedScene
@export var attackDistance : float
@export var attackTimer : Timer
@export var attackCooldown : float
@export var attack : int = 1


func _ready():
	attackTimer.wait_time = attackCooldown


func enter_state() -> void:
	_shoot_bullet()
	stateMachine.change_state(stateMachine.idleState)


func exit_state() -> void:
	pass


func _shoot_bullet() -> void:
	if !attackTimer.is_stopped():
		return
	
	var newBullet : Bullet = bulletPrefab.instantiate()
	stateMachine.enemy.bulletsHolder.add_child(newBullet)
	newBullet.global_position = stateMachine.enemy.global_position
	newBullet.initialize_bullet(stateMachine.enemy.global_position.direction_to(stateMachine.enemy.player.global_position).normalized(), Bullet.BulletType.SHADOW, attack)
	attackTimer.start()
