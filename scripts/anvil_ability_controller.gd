extends Node

const BASE_RANGE := 100
const COLLISION_OFFSET := -10

@export var anvil_ability_scene: PackedScene


func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return

	var random_position = GameEvents.get_random_spawn_position(player.global_position, BASE_RANGE, COLLISION_OFFSET)
	var anvil_instance = anvil_ability_scene.instantiate()
	anvil_instance.position = random_position
