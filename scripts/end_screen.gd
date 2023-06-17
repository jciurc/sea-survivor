extends CanvasLayer

@onready var panel_container = %PanelContainer


func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

	get_tree().paused = true
	%ContinueButton.pressed.connect(on_continue_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)



func set_defeat():
	%Title.text = "Defeat"
	%Description.text = "Try again!"
	play_jingle(true)


func play_jingle(defeat: bool = false):
	if defeat:
		$DefeatStreamPlayer.play()
	else:
		$VictoryStreamPlayer.play()


func on_continue_pressed():
	ScreenTransition.transition_to_scene("res://scenes/meta_menu.tscn")
	get_tree().paused = false


func on_quit_pressed():
	ScreenTransition.transition_to_scene("res://scenes/_main_menu.tscn")
