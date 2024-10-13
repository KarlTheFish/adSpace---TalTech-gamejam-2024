class_name WarningSign extends Sprite2D

var task_name: String = ""

func _enter_tree() -> void:
	EventBus.task_completed.connect(_task_completed)

func _task_completed(name: String) -> void:
	if (name == task_name):
		queue_free()
