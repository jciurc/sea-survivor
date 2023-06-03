extends Node

const MAX_RANGE = 150

@export var sword_ability: PackedScene

var base_damage = 5
var damage_percent = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	var enemies = get_tree().get_nodes_in_group('enemy')
	var player = get_tree().get_first_node_in_group('player') as Node2D
	if !player:
		return

	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)

	if !enemies.size():
		return

	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)

	# instantiate sword
	var sword_instance = sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = base_damage * damage_percent

	# position sword
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4

	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "sword_damage":
		damage_percent = 1 + (current_upgrades.sword_damage.quantity * .50)
