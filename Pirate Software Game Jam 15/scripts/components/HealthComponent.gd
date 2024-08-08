extends Area2D
class_name HealthComponent

# Variables
@export var health : int
@export var hitFlashShader : AnimatedSprite2D
@export var hitFlashTimer : Timer
@export var hitFlashDuration : float = 0.2

var hitFlashMaxPlays : int = 3
var hitFlashPlays : int = 3


# Signals
signal took_damage
signal died


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_took_damage)
	#hitFlashShader.material.set_shader_parameter("enabled", false)
	#hitFlashTimer.timeout.connect(_play_hitflash)
	#hitFlashPlays = hitFlashMaxPlays


func _took_damage(_attack : Area2D) -> void:
	health -= _attack.get_owner().damage
	#hitFlashPlays = hitFlashMaxPlays
	#_play_hitflash()
	
	print("TOOK DAMAGE")

	if _attack.is_class("Bullet"):
		_attack.queue_free()
	
	if health <= 0:
		died.emit()
	else:
		took_damage.emit()


func _play_hitflash() -> void:
	if hitFlashPlays <= 0:
		return
	
	print("MATERIAL: ", hitFlashShader.material)
	print("ENABLED: ", hitFlashShader.material.get_shader_parameter("enabled"))
	hitFlashShader.material.set_shader_parameter("enabled", !hitFlashShader.material.get_shader_parameter("enabled"))
	hitFlashPlays -= 1
	hitFlashTimer.start()
