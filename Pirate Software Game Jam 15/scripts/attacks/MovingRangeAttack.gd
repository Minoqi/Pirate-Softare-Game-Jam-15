extends AnimatedSprite2D
class_name MovingRangeAttack

# Variables
@export var speed : int = 400
@export var hitbox : Area2D
@export var exitScreenNotifer : VisibleOnScreenNotifier2D

var damage : int
var direction : Vector2 = Vector2.ZERO


func _ready():
	exitScreenNotifer.screen_exited.connect(_left_view)


func initialize_attack(_damage : int, _targetPos : Vector2, _playerAttack : bool) -> void:
	damage = _damage
	direction = global_position.direction_to(_targetPos).normalized()
	
	if _playerAttack:
		hitbox.set_collision_mask(3) ## Only effect enemies
	else:
		hitbox.set_collision_mask(2) ## Only effect the player
	
	play("range 1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move()


func _move() -> void:
	global_position += direction * speed


func _left_view() -> void:
	queue_free()
