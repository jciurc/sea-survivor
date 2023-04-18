extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent

var floating_text_scene = preload("res://scenes/floating_text.tscn")


func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(hitbox_component: HitboxComponent):
	if not hitbox_component is HitboxComponent: return
	if !health_component: return

	health_component.damage(hitbox_component.damage)

	var floating_text = floating_text_scene.instantiate() as FloatingText
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)

	floating_text.global_position = global_position
	floating_text.start(str(hitbox_component.damage))
