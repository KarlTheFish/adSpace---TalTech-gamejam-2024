class_name BaseAdvertisement extends Node2D

@export var close_button: BaseButton

var tween: Tween

func _enter_tree() -> void:
	close_button.pressed.connect(_advertisement_closed)
	scale = Vector2.ZERO

func _ready() -> void:
	tween = create_tween()
	tween.tween_property(
		self,
		"scale",
		Vector2.ONE,
		randf_range(0.5, 1.25)
	).set_trans(Tween.TRANS_CUBIC)

func _advertisement_closed() -> void:
	tween.kill()
	queue_free()
