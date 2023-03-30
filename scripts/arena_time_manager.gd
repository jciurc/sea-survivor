extends Node

@export var end_screen_scene: PackedScene

@onready var arena_timer = $ArenaTimer

func _ready():
	arena_timer.timeout.connect(on_arena_timer_timeout)


func get_time_elapsed():
	return arena_timer.wait_time - arena_timer.time_left


func on_arena_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
