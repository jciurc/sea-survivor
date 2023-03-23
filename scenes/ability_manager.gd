extends Node

@export var bullet_scene: PackedScene
@export var bullet_count = 40

const SPAWN_RADIUS = 2
var damage = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	if !bullet_scene: return
	$Firerate.connect('timeout', on_fire_timeout)
	

func on_fire_timeout():
	var player = get_tree().get_first_node_in_group('player') as Node2D
	if !player: return
	
	for i in range(0, bullet_count):
		var bullet_instance = bullet_scene.instantiate() as Bullet
		var spawn_direction = Vector2.UP.rotated((TAU / bullet_count) * i)
		bullet_instance.global_position = player.global_position + (spawn_direction * SPAWN_RADIUS)
		bullet_instance.rotation = spawn_direction.angle()
		bullet_instance.hitbox_component.damage = damage
		player.get_parent().add_child(bullet_instance)
		

	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
