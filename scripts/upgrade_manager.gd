extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager


func _ready():
	experience_manager.level_up.connect(on_level_up)


func on_level_up(current_level: int):
	pass
