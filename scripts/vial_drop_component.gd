extends Node

@export_range(0, 1) var drop_percent: float = .5
@export var health_component: HealthComponent
@export var vial_scene: PackedScene


func _ready():
	health_component.died.connect(on_died)
	
	
func on_died():
	if randf() > drop_percent: return
	if vial_scene == null: return
	if not owner is Node2D: return
	
	var spawn_position = owner.global_position
	var vial_instance: Node2D = vial_scene.instantiate()
	owner.get_parent().add_child(vial_instance)
	vial_instance.global_position = spawn_position
