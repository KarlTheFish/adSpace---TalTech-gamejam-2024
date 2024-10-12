class_name BaseAdvertisement extends Node2D

@export var close_button: BaseButton
@export var ok_button: BaseButton
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
	
	# Randomly chooses if the close button is situated left or right
	var r = randi_range(0, 1)
	close_button.set_position(close_button_markers[r].position)
	if(ok_button != null):
		if(r == 1):
			ok_button.set_position(close_button_markers[0].position)
		elif(r == 0):
			ok_button.set_position(close_button_markers[1].position)
	

func _advertisement_closed() -> void:
	tween.kill()
	queue_free()
