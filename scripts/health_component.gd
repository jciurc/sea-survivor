extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10
var current_health

func _ready():
	current_health = max_health


func damage(damge: float):
	current_health = max(current_health - damage, 0)
	if current_health == 0: 
		died.emit()	
		owner.queue_free()
	
