extends PanelContainer
class_name UIAbilityUpgradeCard

signal selected

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel

var disabled = false


func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)


func play_in(delay: = 0.0):
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func on_gui_input(event: InputEvent):
	if disabled: return
	if event.is_action_pressed("left_click"):
		disabled = true
		await $AnimationPlayer.play("selected")
		selected.emit()


func on_mouse_entered():
	if disabled: return
	$HoverAnimationPlayer.play("hover")
