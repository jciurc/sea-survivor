extends CharacterBody2D

@onready var velocity_component = $VelocityComponent


func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

