extends CanvasLayer
class_name PotionMaking

# Variables
@export var ingredientSlot1 : IngredientSlot
@export var ingredientSlot2 : IngredientSlot
@export var cookButton : CookButton
@export var potionLabel : Label
@export var potionButtons : Array[PotionItemButton]
@export var recipes : Array[RecipeData]
@export var tweenDuration : float = .5
@export var hideYOffset : int = 255

var hideCookTween : Tween = null
var showCook : bool = true
var ingredients : Array[ItemData]
var selectedSlot : IngredientSlot = null


# Signal
signal recipe_unlocked(_recipeData : RecipeData)


# Called when the node enters the scene tree for the first time.
func _ready():
	ingredientSlot1.slot_selected.connect(_select_slot)
	ingredientSlot2.slot_selected.connect(_select_slot)
	cookButton.cookButton.pressed.connect(_cook_ingredients)

	for slot in potionButtons:
		slot.select_item.connect(_store_item)


func _select_slot(_slot : IngredientSlot) -> void:
	if selectedSlot != null:
		selectedSlot.texture = selectedSlot.slotNotSet
	
	if selectedSlot == _slot:
		selectedSlot = null
	else:
		selectedSlot = _slot


func _store_item(_ingredientData : ItemData) -> void:
	if selectedSlot != null:
		selectedSlot.ingredientData = _ingredientData
		selectedSlot.ingredientIcon.texture = _ingredientData.itemIcon
		print("STORE ITEM")


func _cook_ingredients() -> void:
	if ingredientSlot1.ingredientData == null and ingredientSlot2.ingredientData == null:
		print("MISSING INGREDIENTS")
		return

	for recipe in recipes:
		if recipe.recipeRequirements.has(ingredientSlot1.ingredientData) and recipe.recipeRequirements.has(ingredientSlot2.ingredientData):
			potionLabel.text = recipe.recipeName
			recipe_unlocked.emit(recipe)
			GameData.inventory[ingredientSlot1.ingredientData] -= 1
			GameData.inventory[ingredientSlot2.ingredientData] -= 1
			
			for ingredient in potionButtons:
				ingredient.update_quantity()

			return
	
	print("NO MATCHING RECIPES")


func _update_cook_placement() -> void:
	showCook = !showCook

	if hideCookTween != null:
		hideCookTween.kill()

	hideCookTween = get_tree().create_tween()

	if showCook:
		hideCookTween.tween_property(self, "offset", Vector2(0,0), tweenDuration).set_trans(Tween.TRANS_SINE)
	else:
		hideCookTween.tween_property(self, "offset", Vector2(0, hideYOffset), tweenDuration).set_trans(Tween.TRANS_SINE)
