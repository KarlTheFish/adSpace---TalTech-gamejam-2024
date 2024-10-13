extends Camera2D

const MAX_SHAKE: float = 1.25

func _enter_tree() -> void:
	EventBus.health_changed.connect(_health_changed)

func _health_changed(value: float) -> void:
	if (value > 50):
		return
	var shake_strength: float = 1 - (value / 100)
	var x: float = shake_strength * MAX_SHAKE * randi_range(-1, 1)
	var y: float = shake_strength * MAX_SHAKE * randi_range(-1, 1)
	offset = Vector2(x, y)
