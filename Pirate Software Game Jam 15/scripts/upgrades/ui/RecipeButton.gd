extends TextureRect
class_name RecipeButton

# Variables
@export var recipeName : Label
@export var recipeIcon : TextureRect
@export var recipeSelected : TextureRect
@export var recipeButton : Button
@export var recipeData : RecipeData

var recipeUnlocked : bool = false : set = set_recipe_unlocked

# Signals
signal show_ingredients(_recipeData : RecipeData, _unlocked : bool)


# SETTERS
func set_recipe_unlocked(_recipeUnlocked : bool) -> void:
	recipeUnlocked = _recipeUnlocked

	if recipeUnlocked:
		recipeIcon.self_modulate = Color.WHITE


# Called when the node enters the scene tree for the first time.
func _ready():
	recipeName.text = recipeData.recipeName
	recipeIcon.texture = recipeData.recipeIcon
	recipeSelected.visible = false
	recipeButton.focus_entered.connect(_recipe_focused)
	recipeButton.focus_exited.connect(_recipe_lost_focus)
	recipeButton.mouse_entered.connect(_recipe_moused_over)
	recipeButton.mouse_exited.connect(_recipe_mouse_exited)
	recipeButton.pressed.connect(_recipe_selected)

	if !recipeUnlocked:
		recipeIcon.self_modulate = Color.BLACK


func _recipe_focused() -> void:
	recipeSelected.visible = true


func _recipe_lost_focus() -> void:
	recipeSelected.visible = false


func _recipe_moused_over() -> void:
	recipeSelected.visible = true


func _recipe_mouse_exited() -> void:
	recipeSelected.visible = false


func _recipe_selected() -> void:
	show_ingredients.emit(recipeData, recipeUnlocked)