extends CanvasLayer

@onready var panel_container = %PanelContainer


func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)

	get_tree().paused = true
	%RestartButton.pressed.connect(on_restart_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func set_defeat():
	%Title.text = "Defeat"
	%Description.text = "Try again!"

func on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/_main.tscn")


func on_quit_pressed():
	get_tree().quit()
