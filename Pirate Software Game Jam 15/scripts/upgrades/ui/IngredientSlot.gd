extends TextureRect
class_name IngredientSlot

# Variables
@export var ingredientIcon : TextureRect
@export var slotNotSet : CompressedTexture2D
@export var slotSet : CompressedTexture2D
@export var slotSelected : TextureRect
@export var slotButton : Button

var ingredientData : ItemData


# Signals
signal slot_selected(_slot : IngredientSlot)


# Called when the node enters the scene tree for the first time.
func _ready():
	texture = slotNotSet
	slotSelected.visible = false

	slotButton.focus_entered.connect(_button_focused)
	slotButton.focus_exited.connect(_button_lost_focus)
	slotButton.mouse_entered.connect(_button_moused_over)
	slotButton.mouse_exited.connect(_button_mouse_exited)
	slotButton.pressed.connect(_button_pressed)


func _button_focused() -> void:
	slotSelected.visible = true


func _button_lost_focus() -> void:
	slotSelected.visible = false


func _button_moused_over() -> void:
	slotSelected.visible = true


func _button_mouse_exited() -> void:
	slotSelected.visible = false


func _button_pressed() -> void:
	if texture == slotSet:
		texture = slotNotSet
	else:
		texture = slotSet
	
	slot_selected.emit(self)