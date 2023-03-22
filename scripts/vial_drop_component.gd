extends Node

@export var vial_scene: PackedScene
@export var health_component: HealthComponent


func _ready():
	health_component.died.connect(on_died)
	
	
func on_died():
	if vial_scene == null: return
	if not owner is Node2D: return
	
	var spawn_position = (owner as Node2D).global_position
	var vial_instance: Node2D = vial_scene.instantiate()
	owner.get_parent().add_child(vial_instance)
	vial_instance.global_position = spawn_position
