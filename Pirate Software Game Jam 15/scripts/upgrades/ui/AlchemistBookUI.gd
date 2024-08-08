extends CanvasLayer
class_name AlmchemistBookUI

# Variables
@export var recipeIcon : TextureRect
@export var recipeIngredients : RichTextLabel
@export var recipeOptions : Array[RecipeButton]
@export var tweenDuration : float = .5
@export var hideYOffset : int = 255

var hideBookTween : Tween = null
var showBook : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	recipeIcon.texture = null
	recipeIngredients.text = ""

	for recipe in recipeOptions:
		recipe.show_ingredients.connect(_update_ingredients_ui)


func _process(delta):
	if Input.is_action_just_pressed("book"):
		showBook = !showBook
		_update_book_placement()


func _update_ingredients_ui(_recipeData : RecipeData, _unlocked : bool) -> void:	
	if !_unlocked:
		recipeIcon.texture = _recipeData.recipeIcon
		recipeIcon.self_modulate = Color.BLACK
		recipeIngredients.text = "Ingredients: \n???"
	else:
		recipeIcon.texture = _recipeData.recipeIcon
		recipeIcon.self_modulate = Color.WHITE
		recipeIngredients.text = "Ingredients: \n"
		for ingredient in _recipeData.recipeRequirements:
			recipeIngredients.text += "[img=15]" + ingredient.itemIcon.resource_path + "[/img] " + ingredient.itemName + "\n"


func _update_book_placement() -> void:
	if hideBookTween != null:
		hideBookTween.kill()

	hideBookTween = get_tree().create_tween()

	if showBook:
		hideBookTween.tween_property(self, "offset", Vector2(0,0), tweenDuration).set_trans(Tween.TRANS_SINE)
	else:
		hideBookTween.tween_property(self, "offset", Vector2(0, hideYOffset), tweenDuration).set_trans(Tween.TRANS_SINE)