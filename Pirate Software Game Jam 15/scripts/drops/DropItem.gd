extends Sprite2D
class_name DropItem

# Variables
enum DropType{
	DEMON_SOUL
}

@export var dropType : DropType

@export_group("Demon Soul")
@export var soulAmount : int = 10
