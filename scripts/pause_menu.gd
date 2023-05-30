extends CanvasLayer

@onready var panel_container = %PanelContainer

var is_closing = false

func _ready():
	get_tree().paused = true
	panel_container.pivot_offset = panel_container.size / 2
	%ResumeButton.pressed.connect(on_resume_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)

	$AnimationPlayer.play("default")
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		close()
		get_tree().root.set_input_as_handled()


func close():
	if is_closing:
		return

	is_closing = true
	$AnimationPlayer.play_backwards("default")

	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, .3)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)

	await tween.finished
	get_tree().paused = false
	queue_free()



func on_resume_pressed():
	close()


func on_options_pressed():
	pass


func on_quit_pressed():
	pass
