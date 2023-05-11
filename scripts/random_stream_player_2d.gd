extends AudioStreamPlayer2D

@export var streams: Array[AudioStream]
@export var randomize_pitch  = true
@export var min_pitch = .95
@export var max_pitch = 1.05

func play_random():
	if streams == null || streams.size() == 0:
		return

	pitch_scale = 1
	if randomize_pitch:
		pitch_scale = randf_range(min_pitch, max_pitch)

	stream = streams.pick_random()
	play()