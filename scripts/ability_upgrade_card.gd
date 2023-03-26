extends PanelContainer
class_name UIAbilityUpgradeCard

@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
