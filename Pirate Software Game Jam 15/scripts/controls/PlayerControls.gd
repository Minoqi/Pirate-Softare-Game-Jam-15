extends Node2D
class_name PlayerControls

# Variables
@export var speed : int
@export_group("Shooting")
@export var attack : int = 1
@export var attackSpeed : float = .25
@export var attackTimer : Timer
@export var bulletPrefab : PackedScene
@export var bulletSpawnPoint : Marker2D
@export var bulletSpawnPointMaxDistance : float = 15
@export var directionIcon : Sprite2D
@export_group("Animations")
@export var idleAnim : String
@export var runAnim : String

var player : Player
var direction : Vector2 = Vector2.ZERO


# Signals
signal play_animation(_animName : String)
signal flip(_flipLeft : bool)


func _ready():
	attackTimer.wait_time = attackSpeed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_movement_controls()
	_rotate_bullet_spawn_point()
	_shoot_controls()


func _movement_controls() -> void:
	direction.x = Input.get_action_strength("move right") - Input.get_action_strength("move left")
	direction.y = Input.get_action_strength("move down") - Input.get_action_strength("move up")
	direction = direction.normalized()
	
	## Check for idle state
	if direction == Vector2.ZERO:
		play_animation.emit(idleAnim)
		return

	## Flip sprites
	if direction.x < 0:
		flip.emit(true)
	elif direction.x > 0:
		flip.emit(false)

	player.velocity = speed * direction
	player.move_and_slide()
	
	play_animation.emit(runAnim)


func _shoot_controls() -> void:
	if !attackTimer.is_stopped():
		return

	if Input.is_action_pressed("range attack"):
		var newBullet : Bullet = bulletPrefab.instantiate()
		player.bulletsHolder.add_child(newBullet)
		newBullet.global_position = bulletSpawnPoint.global_position
		var bulletDirection : Vector2 = get_global_mouse_position()
		bulletDirection = bulletSpawnPoint.global_position.direction_to(bulletDirection)
		newBullet.initialize_bullet(bulletDirection, Bullet.BulletType.LIGHT, attack)
		attackTimer.start()


## Have bullet spawn point point towards the mouse while staying a certain distance
func _rotate_bullet_spawn_point() -> void:
	var mousePos : Vector2 = get_global_mouse_position()
	var targetDirection : Vector2 = mousePos - player.global_position
	targetDirection = targetDirection.normalized() * bulletSpawnPointMaxDistance
	bulletSpawnPoint.global_position = targetDirection + global_position
	directionIcon.look_at(mousePos)
