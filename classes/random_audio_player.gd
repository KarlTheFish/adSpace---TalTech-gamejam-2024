class_name RandomAudioPlayer extends AudioStreamPlayer2D

@export var chance_to_play: float = 0.5

func _ready() -> void:
	finished.connect(_audio_finished)
	roll_for_play()

func _audio_finished() -> void:
	roll_for_play()

func roll_for_play() -> void:
	var r = randf()
	if (r <= chance_to_play):
		play()
