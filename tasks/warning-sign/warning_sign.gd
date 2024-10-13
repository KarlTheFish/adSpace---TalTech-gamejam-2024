class_name WarningSign extends Sprite2D

@export var alarm: AudioStreamPlayer
@export var wait_timer: Timer
@export var interval_timer: Timer

var task_name: String = ""

func _enter_tree() -> void:
	EventBus.task_completed.connect(_task_completed)
	wait_timer.timeout.connect(_wait_timer_done)
	interval_timer.timeout.connect(_interval_timer_done)

func _task_completed(name: String) -> void:
	if (name == task_name):
		queue_free()

func _wait_timer_done() -> void:
	alarm.play()
	interval_timer.start()

func _interval_timer_done() -> void:
	alarm.play()
