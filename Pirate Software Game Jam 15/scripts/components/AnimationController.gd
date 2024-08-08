extends AnimationPlayer
class_name AnimationSystem

# Variables
@export var flipSprites : Array[Node2D]

var facingLeft : bool = false

# Signals
signal animation_done()


func _ready():
	animation_finished.connect(_animation_finished)


func play_animation(_animName : String) -> void:
	if _animName == "NULL":
		return
	
	play(_animName)


func _animation_finished(_animName : String) -> void:
	animation_done.emit()


func flip_sprites(_flipLeft : bool) -> void:
	if _flipLeft and !facingLeft:
		facingLeft = true
		for sprite in flipSprites:
			sprite.scale.x *= -1
	elif !_flipLeft and facingLeft:
		facingLeft = false
		for sprite in flipSprites:
			sprite.scale.x *= -1
