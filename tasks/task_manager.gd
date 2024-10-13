extends Node2D

@export var GeneralTaskAudio: AudioStreamPlayer2D
@export var ToiletTask: TaskArea
@export var ControlRoomTask: TaskArea

const GENERAL_TASK_SOUNDS: Array [AudioStreamOggVorbis] = [
	preload("res://assets/audio/task_start.ogg"),
	preload("res://assets/audio/task_end.ogg")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.task_opened.connect(_task_opened)
	EventBus.task_closed.connect(_task_closed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _task_opened():
	GeneralTaskAudio.set_stream(GENERAL_TASK_SOUNDS[0])
	GeneralTaskAudio.play(0)
	
func _task_closed():
	GeneralTaskAudio.set_stream(GENERAL_TASK_SOUNDS[1])
	GeneralTaskAudio.play(0)
