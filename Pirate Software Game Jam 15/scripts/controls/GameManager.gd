extends Node2D
class_name GameManager

# Variables
@export var player : Player
@export var bulletsHolder : Node2D
@export var currentRoom : Room
@export var alchemistUI : AlmchemistBookUI
@export var potionUI : PotionMaking


# Called when the node enters the scene tree for the first time.
func _ready():
	player.bulletsHolder = bulletsHolder
	
	potionUI.recipe_unlocked.connect(_unlocked_recipe)


func _unlocked_recipe(_recipeData : RecipeData) -> void:
	for recipe in alchemistUI.recipeOptions:
		recipe.recipeUnlocked = true