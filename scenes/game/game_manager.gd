extends CanvasLayer

@export var time_bar: ProgressBar
@export var health_bar: ProgressBar

const MAX_TIME: float = 60 * 3

var time_elapsed: float = 0.0:
	set(val):
		time_elapsed = val
		if (is_instance_valid(time_bar)):
			time_bar.value = time_elapsed
var health: float = 100.0:
	set(val):
		health = val
		if (is_instance_valid(health_bar)):
			health_bar.value = health
			EventBus.health_changed.emit(health)

func _ready() -> void:
	EventBus.task_completed.connect(_task_completed)
	health = 100.0
	time_bar.max_value = MAX_TIME

func _task_completed(_name: String) -> void:
	health = clamp(health + 20, 0, 100)

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	health -= delta
	if (time_elapsed > MAX_TIME):
		get_tree().change_scene_to_file("res://scenes/good_ending_scene.tscn")
		pass
	if (health < 0):
		get_tree().change_scene_to_file("res://scenes/bad_ending_scene.tscn")
