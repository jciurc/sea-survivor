class_name UIMetaUpgradeCard
extends PanelContainer

var disabled = false
var upgrade: MetaUpgrade

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var purchase_button = %PurchaseButton
@onready var progress_bar = %ProgressBar
@onready var progress_label = %ProgressLabel
@onready var count_label = %CountLabel


func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)


func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()


func update_progress():
	var player_currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent = min(player_currency / upgrade.experience_cost, 1)
	var current_quantity = MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"] \
		if MetaProgression.save_data["meta_upgrades"][upgrade.id] else 0
	var is_maxed = current_quantity >= upgrade.max_quantity
	purchase_button.disabled = percent < 1 || is_maxed
	progress_bar.value = percent
	progress_label.text = "%d/%d" % [player_currency, upgrade.experience_cost]
	count_label.text = "%d owned" % current_quantity
	if is_maxed:
		count_label.text = count_label.text + " (Max)"

func on_purchase_pressed():
	if !upgrade:
		return

	if disabled:
		return

	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save_game()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	$AnimationPlayer.play("selected")
