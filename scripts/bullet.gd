extends Node2D

var speed = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lifetime.connect('timeout', on_lifetime_timeout)


func _phsyics_process(delta): 
	position += transform.x * speed


func on_lifetime_timeout():
	
