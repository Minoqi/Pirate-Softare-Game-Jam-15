extends TextureRect
class_name CookButton

# Variables
@export var buttonSelected : TextureRect
@export var cookButton : Button


# Called when the node enters the scene tree for the first time.
func _ready():
	buttonSelected.visible = false

	cookButton.focus_entered.connect(_button_focused)
	cookButton.focus_exited.connect(_button_lost_focus)
	cookButton.mouse_entered.connect(_button_moused_over)
	cookButton.mouse_exited.connect(_button_mouse_exited)


func _button_focused() -> void:
	buttonSelected.visible = true


func _button_lost_focus() -> void:
	buttonSelected.visible = false


func _button_moused_over() -> void:
	buttonSelected.visible = true


func _button_mouse_exited() -> void:
	buttonSelected.visible = false