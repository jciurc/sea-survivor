extends CharacterBody2D

@onready var velocity_component = $VelocityComponent


func _ready():
	$HurtboxComponent.hit.connect(on_hit)


func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)


func on_hit():
	$AudioStreamPlayer2D.play()
