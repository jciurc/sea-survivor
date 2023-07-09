extends Node

const SPAWN_RADIUS = 350
var spawn_count = 2

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var bat_enemy_scene: PackedScene
@export var arena_time_manager: Node

var base_spawn_time: int
var enemy_table = WeightedTable.new()

@onready var timer = $Timer


func _ready():
	enemy_table.add_item(basic_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func get_random_spawn_position(start_position: Vector2, radius: int):
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = start_position + (random_direction * radius)

	var additional_offset = random_direction * 20
	var query_parameters = PhysicsRayQueryParameters2D.create(start_position, spawn_position + additional_offset, 1)
	var collisions = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)

	# return result if in bounds
	if collisions.is_empty():
		return spawn_position

	# generate new random position recursively if out of bounds
	return get_random_spawn_position(start_position, radius)


func on_timer_timeout():
	for i in range(0, spawn_count):
		spawn_enemy()


func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = (.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off

	if arena_difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 14)

	if arena_difficulty == 10:
		enemy_table.add_item(bat_enemy_scene, 6)


func spawn_enemy():
	timer.start()

	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player:
		return

	var enemy_scene = enemy_table.pick_item()
	var enemy = enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer") as Node2D
	entities_layer.add_child(enemy)
	enemy.global_position = get_random_spawn_position(player.global_position, SPAWN_RADIUS)
