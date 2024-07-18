extends CharacterBody2D
class_name PlayerManager

# Variables
@export var movementControls : MovementSystem
@export var animator : AnimationSystem
@export var healthComponent : HealthComponent


func _ready():
	movementControls.initialize_movement_controls(self, animator, healthComponent)
