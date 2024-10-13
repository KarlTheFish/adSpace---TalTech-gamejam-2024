class_name BaseAdvertisement extends Node2D

@export var ad_window: DraggableButton
@export var close_button: TextureButton
@export var ok_button: TextureButton

var tween: Tween

func _enter_tree() -> void:
	close_button.pressed.connect(_advertisement_closed)
	scale = Vector2.ZERO

func _ready() -> void:
	z_index = 10
	tween = create_tween()
	tween.tween_property(
		self,
		"scale",
		Vector2.ONE,
		randf_range(0.5, 1.25)
	).set_trans(Tween.TRANS_CUBIC)
	
	var corners = [
		CORNER_TOP_LEFT,		# 0 x0y0
		CORNER_TOP_RIGHT,		# 1 x?y0
		CORNER_BOTTOM_RIGHT,	# 2 x?y?
		CORNER_BOTTOM_LEFT,		# 3 x0y?
	]
	var corner = corners.pick_random()
	var ad_size: Vector2 = ad_window.texture_normal.get_size()
	var close_size: Vector2 = close_button.texture_normal.get_size()
	# witchcraft
	close_button.position = Vector2(
		signi(corner % 3) * ad_size.x - (close_size.x / 2),
		int(corner >= 2) * ad_size.y - (close_size.y / 2)
	)
	corners.erase(corner)
	if (ok_button != null):
		corner = corners.pick_random()
		var ok_size: Vector2 = ok_button.texture_normal.get_size()
		ok_button.position = Vector2(
			signi(corner % 3) * ad_size.x - (ok_size.x / 2),
			int(corner >= 2) * ad_size.y - (ok_size.y / 2)
		)

func _advertisement_closed() -> void:
	tween.kill()
	queue_free()
