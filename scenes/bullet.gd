extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Lifetime.connect('timeout', on_lifetime_timeout)


func on_lifetime_timeout():
	queue_free()
