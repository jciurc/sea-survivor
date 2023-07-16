class_name HealthComponent
extends Node

signal died
signal health_decreased
signal health_changed

@export var max_health := 10.0

var current_health: float


func _ready():
	current_health = max_health


func damage(amount: float):
	current_health = max(current_health - amount, 0)
	health_decreased.emit()
	health_changed.emit()
	Callable(check_death).call_deferred()


func heal(amount: float):
	current_health = min(current_health + amount, max_health)
	health_changed.emit()


func get_health_percent():
	if max_health <= 0:
		return 0
	return min(current_health / max_health, 1)


func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()
