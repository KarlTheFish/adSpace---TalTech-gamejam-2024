@tool
extends Area2D

# THIS SHIT IS SO SCUFFED!!!
@export_file var texture_file: String = ""
@export_range(1, 20, 1) var ladder_length: int = 3:
	set(val):
		ladder_length = val
		if (collision_shape == null):
			return
		collision_shape.shape.size = Vector2(32, 32 * val)
		sprite.region_rect = Rect2(0, 0, 32, 32 * val)

var collision_shape: CollisionShape2D
var sprite: Sprite2D

func _ready() -> void:
	collision_shape = CollisionShape2D.new()
	var rect_shape:= RectangleShape2D.new()
	rect_shape.size = Vector2(32, 32 * ladder_length)
	collision_shape.shape = rect_shape
	add_child(collision_shape)

	sprite = Sprite2D.new()
	sprite.texture = load(texture_file) as CompressedTexture2D
	sprite.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	sprite.region_enabled = true
	sprite.region_rect = Rect2(0, 0, 32, 32 * ladder_length)
	add_child(sprite)

	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)

func _body_entered(body: Node2D) -> void:
	if (body is not Player):
		return
	var player:= body as Player
	player.can_climb = true

func _body_exited(body: Node2D) -> void:
	if (body is not Player):
		return
	var player:= body as Player
	player.can_climb = false
