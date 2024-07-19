extends Node2D
class_name EnemyState

# Variables
@export var exitState : MovementState
@export var animName : String

var actor : CharacterBody2D
var stateMachine : EnemyControls


# Signals
signal call_animation(_animName : String)


func enter_state() -> void:
	pass


func exit_state() -> void:
	pass
