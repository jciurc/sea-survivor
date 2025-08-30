extends CanvasLayer

var options_scene = preload("res://scenes/screens/options_menu.tscn")


func _ready():
	%PlayButton.pressed.connect(on_play_pressed)
	%UpgradesButton.pressed.connect(on_upgrades_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	
	if is_inside_tree():
		get_tree().paused = false


func on_play_pressed():
	ScreenTransition.transition_to_scene("res://scenes/screens/main_game.tscn")


func on_upgrades_pressed():
	ScreenTransition.transition_to_scene("res://scenes/screens/meta_menu.tscn")


func on_options_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))


func on_options_closed(instance: Node):
	instance.queue_free()


func on_quit_pressed():
	get_tree().quit()
