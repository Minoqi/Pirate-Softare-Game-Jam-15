extends Node2D
class_name Room

# Variables
@export var navRegion : NavigationRegion2D
@export var wanderPoints : Array[Marker2D]
@export var enemiesToSpawn : Vector2i = Vector2i(1,3)
@export var enemySpawnTime : Vector2 = Vector2(2,5)
@export var enemySpawnTimer : Timer
@export var enemyPrefabs : Array[PackedScene]
@export var spawnPosLeft : Marker2D
@export var spawnPosRight : Marker2D
@export var spawnPosUp : Marker2D
@export var spawnPosDown : Marker2D

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
@export var gameManager : GameManager


func _ready():
	enemySpawnTimer.timeout.connect(_spawn_enemies)
	enemySpawnTimer.wait_time = rng.randf_range(enemySpawnTime.x, enemySpawnTime.y)
	enemySpawnTimer.start()


func _spawn_enemies() -> void:
	var numOfEnemies : int = rng.randi_range(enemiesToSpawn.x, enemiesToSpawn.y)
	for enemy in range(0, numOfEnemies):
		var newEnemy : Enemy = enemyPrefabs.pick_random().instantiate()
		add_child(newEnemy)
		newEnemy.global_position = Vector2(rng.randf_range(spawnPosLeft.global_position.x, spawnPosRight.global_position.x), rng.randf_range(spawnPosUp.global_position.y, spawnPosDown.global_position.y))
		newEnemy.room = self
		newEnemy.player = gameManager.player
		newEnemy.bulletsHolder = gameManager.bulletsHolder

	enemySpawnTimer.wait_time = rng.randf_range(enemySpawnTime.x, enemySpawnTime.y)
	enemySpawnTimer.start()