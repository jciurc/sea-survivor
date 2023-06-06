class_name UIMetaUpgradeCard
extends PanelContainer

signal selected

var disabled = false

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel


func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)


func play_in(delay: = 0.0):
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")


func select_card():
	disabled = true
	$AnimationPlayer.play("selected")
	await $AnimationPlayer.animation_finished
	selected.emit()


func set_meta_upgrade(upgrade: MetaUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func on_gui_input(event: InputEvent):
	if disabled:
		return

	if event.is_action_pressed("left_click"):
		select_card()


func on_mouse_entered():
	if disabled:
		return

	$HoverAnimationPlayer.play("hover")
