class_name WarningSign extends Sprite2D

@export var UrgentTimer: Timer
@export var FlashTimer: Timer
@export var UrgentAlarm: AudioStreamPlayer2D

var task_name: String = ""
var isFlashing: bool = false
var flashOn: bool
var taskComplete: bool = false

var whichFlash: int = 0 #var to indicate how many times the warning has flashed for sound playing purposes, because I am too lazy to add another timer

func _enter_tree() -> void:
	EventBus.task_completed.connect(_task_completed)
	EventBus.task_opened.connect(_turn_off_flash)
	EventBus.task_closed.connect(_turn_on_flash)
	
func _ready() -> void:
	UrgentTimer.timeout.connect(_flashing_sign)
	FlashTimer.timeout.connect(_flash)
	UrgentTimer.start(0)

func _task_completed(name: String) -> void:
	if (name == task_name):
		queue_free()

func _flashing_sign():
	if(isFlashing == false):
		isFlashing = true
		FlashTimer.start(0)
		flashOn = false
		
func _turn_off_flash():
	print("Task opened??")
	FlashTimer.stop()
	isFlashing = false
	
func _turn_on_flash():
	FlashTimer.start()
	isFlashing = true

func _flash():
	if(flashOn):
		set_self_modulate("ff0000")
	elif(not flashOn):
		set_self_modulate("ffffff")
	flashOn = not flashOn
	whichFlash = whichFlash + 1
	if(whichFlash == 3):
		UrgentAlarm.play(0)
		whichFlash = 0
