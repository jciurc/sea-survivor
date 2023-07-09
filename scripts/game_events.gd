extends Node

signal experience_vial_collected(number: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal player_damaged


func emit_experience_vial_collected(number: float):
	experience_vial_collected.emit(number)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)


func emit_player_damaged():
	player_damaged.emit()


# global methods
func get_random_spawn_position(start_position: Vector2, radius: int, retries = 100):
	if retries <= 0:
		return -1

	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = start_position + (random_direction * radius)

	var additional_offset = random_direction * 20
	var query_parameters = PhysicsRayQueryParameters2D.create(start_position, spawn_position + additional_offset, 1)
	var collisions = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)

	# return result if in bounds
	if collisions.is_empty():
		return spawn_position

	# generate new random position recursively if out of bounds
	return get_random_spawn_position(start_position, radius, retries - 1)
