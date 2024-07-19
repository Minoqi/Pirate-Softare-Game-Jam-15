extends AnimationPlayer
class_name AnimationSystem


# Signals
signal animation_done()


func _ready():
	animation_finished.connect(_animation_finished)


func play_animation(_animName : String) -> void:
	if _animName == "NULL":
		return
	
	play(_animName)


func _animation_finished(_animName : String) -> void:
	animation_done.emit()
