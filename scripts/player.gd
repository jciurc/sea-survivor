extends CharacterBody2D

const MAX_SPEED = 150
const ACCELERATION_SMOOTHING = 40

var bodies_currently_colliding = 0;

func _ready():
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)


func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocty = direction * MAX_SPEED

	velocity = velocity.lerp(target_velocty, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)


func on_body_entered(other_body: Node2D):
	bodies_currently_colliding += 1


func on_body_exited(other_body: Node2D):
	bodies_currently_colliding -= 1
