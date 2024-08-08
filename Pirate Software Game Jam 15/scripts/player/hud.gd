extends CanvasLayer
class_name hud

# Variables
@export var heartIconPrefab : PackedScene
@export var heartsHolder : HBoxContainer

var hearts : Array[TextureRect]


func update_hearts(_health : int) -> void:
	for activeHeart in hearts:
		activeHeart.queue_free()
	
	hearts.clear()

	for i in range(0, _health):
		var newHeart : TextureRect = heartIconPrefab.instantiate()
		heartsHolder.add_child(newHeart)
		hearts.append(newHeart)
