extends Node

@export var experience_manager: ExperienceManager
@export var upgrade_screen_scene: PackedScene

var number_of_upgrade_choices = 3
var current_upgrades = {}
var upgrade_pool: WeightedTable = WeightedTable.new()

var upgrade_axe = preload("res://resources/axe.tres")
var upgrade_axe_damage = preload("res://resources/axe_damage.tres")
var upgrade_sword = preload("res://resources/sword.tres")
var upgrade_sword_damage = preload("res://resources/sword_damage.tres")
var upgrade_bubble = preload("res://resources/bubble.tres")
var upgrade_firerate = preload("res://resources/firerate.tres")
var upgrade_player_speed = preload("res://resources/player_speed.tres")


func _ready():
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_sword, 10)
	upgrade_pool.add_item(upgrade_bubble, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	upgrade_pool.add_item(upgrade_player_speed, 5)

	experience_manager.level_up.connect(on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			'resource': upgrade,
			'quantity': 1
		}
	else :
		current_upgrades[upgrade.id].quantity += 1

	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id].quantity
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)

	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	if chosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damage, 10)

	if chosen_upgrade.id == upgrade_bubble.id:
		upgrade_pool.add_item(upgrade_firerate, 10)


func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade] = []
	for i in number_of_upgrade_choices:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break

		var chosen_upgrade = upgrade_pool.pick_item(chosen_upgrades) as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)

	return chosen_upgrades


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


func on_level_up(current_level: int):
	var chosen_upgrades = pick_upgrades()
	if chosen_upgrades.is_empty():
		return

	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
