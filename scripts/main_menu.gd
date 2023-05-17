extends CanvasLayer


func _ready():
	%PlayButton.pressed.connect(on_play_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func on_play_pressed():
	pass


func on_options_pressed():
	pass


func on_quit_pressed():
	pass
