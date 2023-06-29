extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

var meta_upgrade_card_scene = preload("res://scenes/ui/meta_upgrade_card.tscn")

@onready var grid_container = %GridContainer
@onready var back_button = %BackButton


func _ready():
	back_button.pressed.connect(on_back_pressed)

	for child in grid_container.get_children():
		child.queue_free()

	for upgrade in upgrades:
		var card_instance = meta_upgrade_card_scene.instantiate()
		grid_container.add_child(card_instance)
		card_instance.set_meta_upgrade(upgrade)


func on_back_pressed():
	ScreenTransition.transition_to_scene("res://scenes/screens/main_menu.tscn")
