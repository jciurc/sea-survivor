extends Node

signal arena_difficulty_increased(arena_difficulty: int)

const DIFFICULTY_INTERVAL = 5

@export var end_screen_scene: PackedScene

@onready var arena_timer = $ArenaTimer

var arena_difficulty = 0


func _ready():
	arena_timer.timeout.connect(on_arena_timer_timeout)


func _process(delta):
	var next_time_target = arena_timer.wait_time - ((arena_difficulty + 1) * DIFFICULTY_INTERVAL)
	if arena_timer.time_left <= next_time_target:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)


func get_time_elapsed():
	return arena_timer.wait_time - arena_timer.time_left


func on_arena_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.play_jingle()
