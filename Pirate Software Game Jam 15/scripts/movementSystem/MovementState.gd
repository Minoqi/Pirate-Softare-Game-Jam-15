extends Node2D
class_name MovementState

# Variables
@export var exitState : MovementState
@export var animName : String

var actor : CharacterBody2D
var stateMachine : MovementSystem


# Signals
signal call_animation(_animName : String)


func enter_state() -> void:
	pass


func exit_state() -> void:
	pass


func check_for_input() -> void:
	pass
