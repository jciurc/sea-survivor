extends CanvasLayer


func _ready():
	get_tree().paused = true
	$RestartButton.pressed.connect(on_restart_pressed)
	$QuitButton.pressed.connect(on_quit_pressed)


func on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/_main.tscn")


func on_quit_pressed():
	get_tree().quit()
