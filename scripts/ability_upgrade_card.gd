extends PanelContainer
class_name UIAbilityUpgradeCard

signal selected

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel


func _ready():
	gui_input.connect(on_gui_input)


func play_in():
	$AnimationPlayer.play("in")


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
