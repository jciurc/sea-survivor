class_name UIMetaUpgradeCard
extends PanelContainer

var disabled = false

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var purchase_button = %PurchaseButton


func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)


func select_card():
	$AnimationPlayer.play("selected")
	disabled = true


func set_meta_upgrade(upgrade: MetaUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func on_purchase_pressed():
	if disabled:
		return

	select_card()
