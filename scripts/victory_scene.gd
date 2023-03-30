extends CanvasLayer


func _ready():
	get_tree().paused = true
	$RestartButton.pressed.connect(on_restart_pressed)
	$QuitButton.pressed.connect(on_quit_pressed)


func on_restart_pressed():
	pass


func on_quit_pressed():
	pass
