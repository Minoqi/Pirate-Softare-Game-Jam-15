extends Node
class_name UpgradeGenerator

# Variables
@export var numOfUpgrades : int = 3

@export_group("Common")
@export var commonChance : int = 50
@export var commonUpgrades : Array[UpgradeData]

@export_group("Uncommon")
@export var uncommonChance : int = 40
@export var uncommonUpgrades : Array[UpgradeData]

@export_group("Rare")
@export var rareChance : int = 10
@export var rareUpgrades : Array[UpgradeData]

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var generatedUpgrades : Array[UpgradeData]


func generate_upgrades() -> Array[UpgradeData]:
	generatedUpgrades.clear()
	
	for i in range(0, numOfUpgrades):
		var upgrade : UpgradeData = _generate_upgrade()
		
		while generatedUpgrades.has(upgrade):
			upgrade = _generate_upgrade()
		
		generatedUpgrades.append(upgrade)
	
	return generatedUpgrades


func _generate_upgrade() -> UpgradeData:
	var rarityChance : int = rng.randi_range(0,100)
	var upgrade : UpgradeData = null
	
	if rarityChance >= (100 - rareChance): ## Rare Upgrade
		upgrade = rareUpgrades.pick_random()
	elif rarityChance >= (100 - uncommonChance): ## Uncommon Upgrade
		upgrade = uncommonUpgrades.pick_random()
	else: ## Common Upgrade
		upgrade = commonUpgrades.pick_random()
	
	return upgrade
