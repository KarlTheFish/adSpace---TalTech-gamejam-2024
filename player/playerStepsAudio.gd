extends AudioStreamPlayer2D

@export var PLAYER: Player

const STEP_SOUNDS: Array[AudioStreamWAV] = [
	preload("res://assets/audio/steps/step1.wav"),
	preload("res://assets/audio/steps/step2.wav"),
	preload("res://assets/audio/steps/step3.wav"),
	preload("res://assets/audio/steps/step4.wav"),
	preload("res://assets/audio/steps/step5.wav"),
	preload("res://assets/audio/steps/step6.wav"),
	preload("res://assets/audio/steps/step7.wav"),
	preload("res://assets/audio/steps/step8.wav"),
	preload("res://assets/audio/steps/step9.wav"),
	preload("res://assets/audio/steps/step10.wav"),
	preload("res://assets/audio/steps/step11.wav"),
	preload("res://assets/audio/steps/step12.wav"),
	preload("res://assets/audio/steps/step13.wav"),
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PLAYER.walking.connect(stepsAudio)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func stepsAudio():
	var stepSound = STEP_SOUNDS.pick_random()
	set_stream(stepSound)
	
	
