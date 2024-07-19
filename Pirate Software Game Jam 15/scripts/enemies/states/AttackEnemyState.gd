extends EnemyState
class_name AttackEnemyState

# Variables
@export var damage : int = 1
@export var meleeAnim : String
@export var rangeAnim : String
@export var rangeAttackPrefab : PackedScene
@export var rangeAttackAnim : String


func enter_state() -> void:
	if stateMachine.meleeMode:
		call_animation.emit(meleeAnim)
	else:
		call_animation.emit(rangeAnim)


func exit_state() -> void:
	pass


func animation_finished() -> void:
	if stateMachine.currentState == self:
		stateMachine.change_state(stateMachine.idleState)


func _spawn_range_attack() -> void:
	var newAttack : StillRangeAttack = rangeAttackPrefab.instantiate()
	add_child(newAttack)
	newAttack.initialize_attack(damage, false, rangeAttackAnim)


func _enable_attack_hitbox(_attackHitbox : CollisionShape2D) -> void:
	_attackHitbox.disabled = false


func _disable_attack_hitbox(_attackHitbox : CollisionShape2D) -> void:
	_attackHitbox.disabled = true
