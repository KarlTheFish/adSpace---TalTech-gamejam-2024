extends Node2D

@export var general_audio: AudioStreamPlayer2D
@export var win_audio: AudioStreamPlayer
@export var tasks: Array[TaskArea] = []
@export var task_timer: Timer

@export_range(0.0, 1.0, 0.1) var task_start_chance: float = 0.5
@export_range(2.0, 20.0, 1.0) var time_between_rolls: float = 8.0

const GENERAL_TASK_SOUNDS: Array [AudioStreamOggVorbis] = [
	preload("res://assets/audio/task_start.ogg"),
	preload("res://assets/audio/task_end.ogg"),
	preload("res://assets/audio/task_end2.ogg"),
]
const WARNING_SIGN_SCENE: PackedScene = preload("res://tasks/warning-sign/warning_sign.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.task_opened.connect(_task_opened)
	EventBus.task_closed.connect(_task_closed)
	EventBus.task_completed.connect(_task_completed)
	task_timer.timeout.connect(_timer_done)
	task_timer.start(time_between_rolls)
	
func _timer_done():
	var r = randf()
	if(r <= task_start_chance):
		print("yes")
		start_new_task()

func _task_opened():
	general_audio.set_stream(GENERAL_TASK_SOUNDS[0])
	general_audio.play()
	
func _task_closed():
	general_audio.set_stream(GENERAL_TASK_SOUNDS[1])
	general_audio.play()

func _task_completed(_name: String) -> void:
	win_audio.play()

func start_new_task() -> void:
	# find available tasks
	var available_tasks: Array[TaskArea] = []
	for task in tasks:
		if (task.task_complete):
			available_tasks.append(task)
			print(task.name)
	if (available_tasks.size() == 0):
		return
	var rand_task: TaskArea = available_tasks.pick_random()
	rand_task.restart_task()
	var sign: WarningSign = WARNING_SIGN_SCENE.instantiate()
	sign.position = rand_task.position + Vector2(0, -20)
	sign.task_name = rand_task.task_name
	add_child(sign)
