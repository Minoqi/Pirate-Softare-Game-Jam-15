extends Area2D
class_name HealthComponent

# Variables
@export var health : int


# Signals
signal took_damage
signal died


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_took_damage)


func _took_damage(_attack : Area2D) -> void:
	health -= _attack.get_owner().damage
	#_attack.queue_free()
	
	if health <= 0:
		died.emit()
	else:
		took_damage.emit()
