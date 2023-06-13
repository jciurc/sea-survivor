class_name UIMetaUpgradeCard
extends PanelContainer

var disabled = false
var upgrade: MetaUpgrade

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var purchase_button = %PurchaseButton
@onready var progress_bar = %ProgressBar


func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)


func select_card():
	$AnimationPlayer.play("selected")
	disabled = true

	await $AnimationPlayer.animation_finished
	disabled = false


func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()


func update_progress():
	var percent = MetaProgression.save_data["meta_upgrade_currency"] / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	print(progress_bar.value)


func on_purchase_pressed():
	if !upgrade:
		return

	if disabled:
		return

	MetaProgression.add_meta_upgrade(upgrade)
	select_card()
