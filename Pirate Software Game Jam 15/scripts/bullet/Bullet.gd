extends Sprite2D
class_name Bullet

# Variables
enum BulletType{
	LIGHT,
	SHADOW
}

@export var speed : int = 125
@export var light : PointLight2D
@export var hitbox : Area2D
@export_group("Light Bullet")
@export var lightSprite : CompressedTexture2D
@export var lightLightColor : Color
@export_group("Shadow Bullet")
@export var shadowSprite : CompressedTexture2D
@export var shadowLightColor : Color

var direction : Vector2 = Vector2.ZERO
var bulletType : BulletType
var damage : int = 1


func initialize_bullet(_direction : Vector2, _bulletType : BulletType, _damage : int) -> void:
	direction = _direction
	bulletType = _bulletType
	damage = _damage
	
	match bulletType:
		BulletType.LIGHT:
			texture = lightSprite
			light.color = lightLightColor
			hitbox.set_collision_layer_value(2, true)
		BulletType.SHADOW:
			texture = shadowSprite
			light.color = shadowLightColor
			hitbox.set_collision_layer_value(3, true)
		_:
			printerr("BULLET TYPE NOT SET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += direction * speed * delta
