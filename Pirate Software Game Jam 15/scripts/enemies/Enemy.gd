extends CharacterBody2D
class_name Enemy

# Variables
@export var stateMachine : EnemyStateMachine
@export var animator : AnimationSystem
@export var healthComponent : HealthComponent

var room : Room
var player : Player
var bulletsHolder : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	stateMachine.enemy = self
	stateMachine.idleState.play_animation.connect(animator.play_animation)
	stateMachine.idleState.flip.connect(animator.flip_sprites)
	stateMachine.wanderState.play_animation.connect(animator.play_animation)
	stateMachine.wanderState.flip.connect(animator.flip_sprites)
	stateMachine.chaseState.play_animation.connect(animator.play_animation)
	stateMachine.chaseState.flip.connect(animator.flip_sprites)
	
	healthComponent.took_damage.connect(_took_damage)
	healthComponent.died.connect(_died)


func _took_damage() -> void:
	pass


func _died() -> void:
	queue_free()
