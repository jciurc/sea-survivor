extends Node

@export var bullet_scene: PackedScene
@export var bullet_count = 40

const SPAWN_RADIUS = 2
var damage = 5
var base_wait_time = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	base_wait_time = $Timer.wait_time
	if !bullet_scene: return
	$Firerate.connect('timeout', on_fire_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_fire_timeout():
	var player = get_tree().get_first_node_in_group('player') as Node2D
	if !player: return

	for i in range(0, bullet_count):
		var bullet_instance = bullet_scene.instantiate() as Bullet
		var spawn_direction = Vector2.UP.rotated((TAU / bullet_count) * i)
		player.get_parent().add_child(bullet_instance)
		bullet_instance.global_position = player.global_position + (spawn_direction * SPAWN_RADIUS)
		bullet_instance.rotation = spawn_direction.angle()
		bullet_instance.hitbox_component.damage = damage


	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "firerate": return

	var percent_reduction = current_upgrades["firerate"].quantity * .1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	$Timer.start()
