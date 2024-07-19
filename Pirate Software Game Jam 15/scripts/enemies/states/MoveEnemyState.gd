extends EnemyState
class_name MoveEnemyState

# Variables
@export var speed : float = 300
@export var distanceToAttackMelee : float = 20
@export var distanceToAttackRange : float = 90

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var direction : Vector2 = Vector2.ZERO


# Signals
signal flip_sprite(_facingLeft : bool)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


func enter_state() -> void:
	set_process(true)
	
	## Select attack type
	var attackValue : int = rng.randi_range(0, 100)
	if attackValue < 50: ## Melee attack
		stateMachine.meleeMode = true
	else: ## Range attack
		stateMachine.meleeMode = false


func exit_state() -> void:
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_chase_player()


func _chase_player() -> void:
	if stateMachine.meleeMode:
		if stateMachine.actor.global_position.distance_to(stateMachine.actor.player.global_position) <= distanceToAttackMelee:
			stateMachine.change_state(stateMachine.attackState)
		else:
			direction = stateMachine.actor.global_position.direction_to(stateMachine.actor.player.global_position).normalized()
			stateMachine.actor.global_position += direction * speed * get_process_delta_time()
			
			if direction.x < 0: ## left
				flip_sprite.emit(true)
			elif direction.x < 0:
				flip_sprite.emit(false)
	else:
		if stateMachine.actor.global_position.distance_to(stateMachine.actor.player.global_position) <= distanceToAttackRange:
			stateMachine.change_state(stateMachine.attackState)
		else:
			direction = stateMachine.actor.global_position.direction_to(stateMachine.actor.player.global_position).normalized()
			stateMachine.actor.global_position += direction * speed * get_process_delta_time()
			
			if direction.x < 0: ## left
				flip_sprite.emit(true)
			elif direction.x < 0:
				flip_sprite.emit(false)
