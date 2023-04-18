extends Node2D
class_name FloatingText

func _ready():
	pass


func start(text: String):
	$Label.text = text

	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), .3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

	tween.chain()
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 48), .5)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2.ZERO, .5)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

	tween.chain()
	tween.tween_callback(queue_free)

	var bounce_tween = create_tween()
	bounce_tween.tween_property(self, "scale", Vector2.ONE * 1.5, .15)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	bounce_tween.tween_property(self, "scale", Vector2.ONE, .15)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
