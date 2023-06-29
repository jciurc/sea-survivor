extends CharacterBody2D

var is_moving = false

@onready var velocity_component = $VelocityComponent
@onready var visuals = $Visuals


func _ready():
	$HurtboxComponent.hit.connect(on_hit)


func _process(delta):
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()

	velocity_component.move(self)

	var move_sign = sign(velocity_component.velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func set_is_moving(moving: bool):
	is_moving = moving


func on_hit():
	$RandomHitAudio.play_random()
