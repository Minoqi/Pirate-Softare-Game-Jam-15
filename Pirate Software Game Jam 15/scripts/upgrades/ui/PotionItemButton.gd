extends TextureRect
class_name PotionItemButton

# Variables
@export var itemIcon : TextureRect
@export var itemAmountLabel : Label
@export var itemButton : Button
@export var itemSelected : TextureRect
@export var itemData : ItemData


# Signals
signal select_item(_itemData : ItemData)


# Called when the node enters the scene tree for the first time.
func _ready():
	itemIcon.texture = itemData.itemIcon
	itemAmountLabel.text = "x" + str(GameData.inventory[itemData])
	itemSelected.visible = false
	
	itemButton.focus_entered.connect(_item_focused)
	itemButton.focus_exited.connect(_item_lost_focus)
	itemButton.mouse_entered.connect(_item_moused_over)
	itemButton.mouse_exited.connect(_item_mouse_exited)
	itemButton.pressed.connect(_item_pressed)


func update_quantity() -> void:
	itemAmountLabel.text = "x" + str(GameData.inventory[itemData])


func _item_focused() -> void:
	itemSelected.visible = true


func _item_lost_focus() -> void:
	itemSelected.visible = false


func _item_moused_over() -> void:
	itemSelected.visible = true


func _item_mouse_exited() -> void:
	itemSelected.visible = false


func _item_pressed() -> void:
	if GameData.inventory[itemData] == 0:
		return

	select_item.emit(itemData)