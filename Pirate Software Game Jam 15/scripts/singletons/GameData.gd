extends Node
class_name GameData

# Variables
static var inventory : Dictionary = {
	preload("res://resources/items/BigDemonItemData.tres"): 3,
	preload("res://resources/items/DocItemData.tres"): 3,
	preload("res://resources/items/NecromancerItemData.tres"): 3,
	preload("res://resources/items/OgreItemData.tres"): 3
}