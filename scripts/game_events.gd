extends Node

signal experience_vial_collected(number: float)


func emit_collect(number: float):
	experience_vial_collected.emit(number)

