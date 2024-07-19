extends Node2D
class_name EnemyManager

# Variables
@export var animator : AnimationSystem
@export var stateMachine : EnemyControls
@export var healthComponent : HealthComponent
@export var player : PlayerManager


# Called when the node enters the scene tree for the first time.
func _ready():
	stateMachine.initialize_enemy_controls(self, animator, healthComponent)