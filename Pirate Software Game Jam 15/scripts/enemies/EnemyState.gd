extends Node2D
class_name EnemyState

# Variables
@export var animName : String
var stateMachine : EnemyStateMachine


# Signals
signal play_animation(_animName : String)
signal flip(_flipLeft : bool)


func enter_state() -> void:
	pass


func exit_state() -> void:
	pass


func call_animation(_animName : String):
	play_animation.emit(_animName)


func call_flip(_flipLeft : bool) -> void:
	flip.emit(_flipLeft)
