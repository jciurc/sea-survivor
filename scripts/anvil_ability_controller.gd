extends Node

const BASE_RANGE := 100

@export var anvil_ability_scene: PackedScene


func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return

	var random_position = GameEvents.get_random_spawn_position(player.global_position, BASE_RANGE)
	if random_position == -1:
		return

	var anvil_instance = anvil_ability_scene.instantiate()
	anvil_instance.position = random_position
