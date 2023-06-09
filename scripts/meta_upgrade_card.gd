class_name UIMetaUpgradeCard
extends PanelContainer

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var purchase_button = %PurchaseButton


func _ready():
	purchase_button.pressed.connect(on_gui_input)


func select_card():
	$AnimationPlayer.play("selected")


func set_meta_upgrade(upgrade: MetaUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		select_card()
