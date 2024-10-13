extends Node2D

@export var GeneralTaskAudio: AudioStreamPlayer2D
@export var ToiletTask: TaskArea
@export var ControlRoomTask: TaskArea

@export var TaskMarker1: Marker2D #Engine room marker
@export var TaskMarker2: Marker2D #Cockpit room marker
@export var TaskMarker3: Marker2D #Toilet marker
@export var TaskMarker4: Marker2D #Bed marker

@export var AlertSprite: Sprite2D
@export var TaskCheckTimer: Timer

@export_range(0.0, 1.0, 0.1) var TaskChance: float #Chance of a task appearing

const GENERAL_TASK_SOUNDS: Array [AudioStreamOggVorbis] = [
	preload("res://assets/audio/task_start.ogg"),
	preload("res://assets/audio/task_end.ogg")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.task_opened.connect(_task_opened)
	EventBus.task_closed.connect(_task_closed)
	AlertSprite.set_visible(false)
	TaskCheckTimer.timeout.connect(_timer_done)
	TaskCheckTimer.start()
	
func _timer_done():
	#print("roll task")
	var f = randf()
	if(f <= TaskChance):
	#	print("spawn task")
		_newTask()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _task_opened():
	GeneralTaskAudio.set_stream(GENERAL_TASK_SOUNDS[0])
	GeneralTaskAudio.play(0)
	
func _task_closed():
	GeneralTaskAudio.set_stream(GENERAL_TASK_SOUNDS[1])
	GeneralTaskAudio.play(0)
	
func _newTask():
	var randI = randi_range(1, 4)
	AlertSprite.set_visible(true)
	match randI:
		1:
			print("Engine task")
			AlertSprite.set_position(TaskMarker1.get_position())
		2:
			print("Cockpit task")
			AlertSprite.set_position(TaskMarker2.get_position())
		3:
			print("Toilet task")
			AlertSprite.set_position(TaskMarker3.get_position())
		4:
			print("Bed task")
			AlertSprite.set_position(TaskMarker4.get_position())
