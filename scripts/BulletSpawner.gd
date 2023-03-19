extends Node

@export var bullet_scene: PackedScene
var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if !bullet_scene: return
	$"../Timer".connect('timeout', spawn_bullet)
	player = get_tree().get_first_node_in_group('player') as Node2D

func spawn_bullet():
	var bullet_instance = bullet_scene.instantiate() as Node2D
	bullet_instance.global_position = player.global_position
	player.get_parent().add_child(bullet_instance)
