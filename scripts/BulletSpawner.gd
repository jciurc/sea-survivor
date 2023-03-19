extends Node

@export var bullet_scene: PackedScene
@export var initial_bullet_count: int

const SPAWN_RADIUS = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	if !bullet_scene: return
	$"../FirerateTimer".connect('timeout', spawn_bullet)


func spawn_bullet():
	var player = get_tree().get_first_node_in_group('player') as Node2D
	if !player: return
	
	var bullet_instance = bullet_scene.instantiate() as Node2D
	bullet_instance.global_position = player.global_position
	player.get_parent().add_child(bullet_instance)

	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
