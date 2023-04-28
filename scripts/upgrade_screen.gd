extends CanvasLayer

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container : HBoxContainer = %CardContainer


func _ready():
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	var delay = 0
	var delay_increment = 0.1
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate() as UIAbilityUpgradeCard
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.play_in(delay)
		delay += delay_increment
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))


func on_upgrade_selected(upgrade: AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
