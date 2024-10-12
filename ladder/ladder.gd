@tool
extends Area2D

# THIS SHIT IS Quite SCUFFED!!!
@export_range(1, 20, 1) var ladder_length: int = 3:
	set(val):
		ladder_length = val
		if (collision_shape == null):
			return
		collision_shape.shape.size = Vector2(23, 12 * val)

var collision_shape: CollisionShape2D

func _ready() -> void:
	collision_shape = CollisionShape2D.new()
	var rect_shape:= RectangleShape2D.new()
	rect_shape.size = Vector2(23, 12 * ladder_length)
	collision_shape.shape = rect_shape
	add_child(collision_shape)

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
