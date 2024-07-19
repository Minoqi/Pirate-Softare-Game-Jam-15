extends AnimatedSprite2D
class_name StillRangeAttack

# Variables
@export var hitbox : Area2D

var damage : int


func _ready():
	animation_finished.connect(_animation_finished)


func initialize_attack(_damage : int, _playerAttack : bool, _animName : String) -> void:
	damage = _damage
	
	if _playerAttack:
		hitbox.set_collision_mask(3) ## Only effect enemies
	else:
		hitbox.set_collision_mask(2) ## Only effect the player
	
	play(_animName)


func _animation_finished() -> void:
	queue_free()
