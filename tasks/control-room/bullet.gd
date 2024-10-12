extends Area2D

@export var notifier: VisibleOnScreenNotifier2D

var speed: float = 400

func _ready() -> void:
	notifier.screen_exited.connect(queue_free)

func _physics_process(delta: float) -> void:
	position += Vector2(speed, 0).rotated(rotation) * delta
	
