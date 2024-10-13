extends TaskArea

@export var toilet_brush: DraggableButton
@export var toilet_cleaned_sound: AudioStreamPlayer2D
#@export var poop: Area2D
@export var poop_sound: AudioStreamPlayer2D

const POOP_SCENE: PackedScene = preload("res://tasks/toilet/toilet_poop.tscn")
var poop_amount: int = 0

const CLEAN_SOUND: AudioStreamWAV = preload("res://assets/audio/toilet_cleaned.wav")

func _ready() -> void:
	restart_task()
	

func _physics_process(delta: float) -> void:
	toilet_brush.disabled = not task_open
	if (not task_open):
		toilet_brush.button_up.emit()

func restart_task() -> void:
	task_complete = false
	poop_amount = randi_range(5, 12)
	for i in poop_amount:
		var instance: Area2D = POOP_SCENE.instantiate()
		var x: int = randi_range(40, 280)
		var y: int = randi_range(40, 200)
		instance.tree_exiting.connect(_poop_wiped)
		instance.position = Vector2(x, y)
		task_root.add_child(instance)

func _poop_wiped() -> void:
	poop_amount -= 1
	if (poop_amount == 0):
		toilet_cleaned_sound.play(0)
		EventBus.task_completed.emit()
		task_complete = true
		toggle_task_visibility()
