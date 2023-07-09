extends Node

const BASE_RANGE := 100

@export var anvil_ability_scene: PackedScene


func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return

	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_position = random_direction * randf_range(0, BASE_RANGE)
	var additional_offset = random_direction * 20
	var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, random_position + additional_offset, 1)
	var collisions = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
