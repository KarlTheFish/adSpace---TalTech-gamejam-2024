class_name BaseAdvertisement extends Node2D

@export var close_button: BaseButton
@export var close_button_markers: Array[Marker2D] = []

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
	
	# Randomly chooses if the close button is situated upper left or upper right
	var r = randi_range(0, 1)
	close_button.set_position(close_button_markers[r].position)
	

func _advertisement_closed() -> void:
	tween.kill()
	queue_free()
