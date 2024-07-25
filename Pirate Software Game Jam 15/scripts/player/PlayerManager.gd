extends CharacterBody2D
class_name PlayerManager

# Variables
@export var movementControls : MovementSystem
@export var animator : AnimationSystem
@export var healthComponent : HealthComponent
@export var collectDropsComponent : CollectDrops

var damage = 1
var souls : int = 0


func _ready():
	movementControls.initialize_movement_controls(self, animator, healthComponent)
	collectDropsComponent.grab_drop.connect(_collect_drop)


func _collect_drop(_drop : DropItem) -> void:
	match _drop.dropType:
		DropItem.DropType.DEMON_SOUL:
			souls += _drop.soulAmount
		_:
			printerr("DROP TYPE NOT SET")
	
	_drop.queue_free()
