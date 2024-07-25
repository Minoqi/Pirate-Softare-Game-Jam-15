extends Resource
class_name UpgradeData

# Variables
enum UpgradeType{
	MELEE,
	RANGE,
	JEWLERY,
	BOTH
}

enum RarityLevel{
	COMMON,
	UNCOMMON,
	RARE
}

@export var upgradeName : String
@export var upgradeIcon : CompressedTexture2D
@export_multiline var upgradeDescription : String
@export var upgradeType : UpgradeType
@export var rarityType : RarityLevel

@export_group("Melee Only")
@export var meleeAttackSpeed : int
@export_group("Range Only")
@export var extraBullets : int
@export var extraPierce : int
@export var bulletExplosionChance : int
@export var increaseBulletArc : int
@export_group("Both")
@export var reduceManaCost : int
@export var extraCritChance : int
@export var lifeStealChance : int
@export var extraFreezeChance : int
@export var extraPoisonChance : int
@export var extraBurnChance : int
