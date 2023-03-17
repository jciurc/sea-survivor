extends Node

@export var sword_ability: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	pass
