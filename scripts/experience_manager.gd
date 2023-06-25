class_name ExperienceManager
extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_GROWTH_FACTOR := 1.6
const TARGET_GROWTH_FLAT := 12.0

var current_experience := 0.0
var current_level := 1
var target_experience := 12.0


func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(amount: float):
	current_experience = min(current_experience + amount, target_experience)
	experience_updated.emit(current_experience, target_experience)

	if current_experience >= target_experience:
		current_level += 1
		target_experience = apply_scaling(target_experience)
		current_experience = 0
		experience_updated.emit(current_experience, target_experience)
		level_up.emit(current_level)


func apply_scaling(target: float):
	var result = target
	result *= TARGET_GROWTH_FACTOR
	result += TARGET_GROWTH_FLAT
	return result


func on_experience_vial_collected(value: float):
	var adjusted_value = value * (0.1 * MetaProgression.get_upgrade_count("experience_gain"))
	increment_experience(adjusted_value)
