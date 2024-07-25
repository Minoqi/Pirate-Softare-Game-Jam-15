extends Area2D
class_name CollectDrops

# Signals
signal grab_drop(_drop : DropItem)


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_grabbed_drop)


func _grabbed_drop(_drop : Area2D) -> void:
	grab_drop.emit(_drop.get_owner())
