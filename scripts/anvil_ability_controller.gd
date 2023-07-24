extends Node

const BASE_RANGE := 60
const COLLISION_OFFSET := -20 # allow ability to spawn slightly out of bounds
const BASE_ANVIL_COUNT := 1

var anvil_count = BASE_ANVIL_COUNT

@export var anvil_ability_scene: PackedScene


func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func spawn_anvil(starting_position: Vector2):
	var random_position = GameEvents.get_random_spawn_position(starting_position, BASE_RANGE, COLLISION_OFFSET)
	var anvil_instance = anvil_ability_scene.instantiate()
	get_tree().get_first_node_in_group("foreground_layer").add_child(anvil_instance)
	anvil_instance.position = random_position


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return

	for i in anvil_count:
		var random_delay = randf_range(0.02, 0.2)
		await get_tree().create_timer(random_delay).timeout
		spawn_anvil(player.global_position)


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "anvil_count":
		anvil_count = BASE_ANVIL_COUNT + current_upgrades["anvil_count"]["quantity"]
