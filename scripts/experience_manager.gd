class_name ExperienceManager
extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH := 3

var current_experience := 0.0
var current_level := 1
var target_experience := 4.0


func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(number: float):
	current_experience = min(current_experience + number, target_experience)
	experience_updated.emit(current_experience, target_experience)
	if current_experience == target_experience:
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		current_experience = 0
		experience_updated.emit(current_experience, target_experience)
		level_up.emit(current_level)


func on_experience_vial_collected(value: float):
	var adjusted_value = value * (0.1 * MetaProgression.get_upgrade_count("experience_gain"))
	increment_experience(adjusted_value)
