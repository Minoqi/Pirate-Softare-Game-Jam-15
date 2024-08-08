extends CharacterBody2D
class_name Player

# Variables
@export var controls : PlayerControls
@export var animator : AnimationSystem
@export var healthComponent : HealthComponent
@export var hud : hud

var bulletsHolder : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	controls.player = self
	
	controls.play_animation.connect(animator.play_animation)
	controls.flip.connect(animator.flip_sprites)

	healthComponent.took_damage.connect(_take_damage)
	healthComponent.died.connect(_die)

	hud.update_hearts(healthComponent.health)


func _take_damage() -> void:
	hud.update_hearts(healthComponent.health)


func _die() -> void:
	print("DIED")