class_name DraggableButton extends TextureButton

@export var ToiletBrushArea:Area2D

var dragging: bool = false
var mouse_offset: Vector2 = Vector2.ZERO

func _enter_tree() -> void:
	button_down.connect(_button_down)
	button_up.connect(_button_up)

func _process(delta: float) -> void:
	if (dragging):
		global_position = get_global_mouse_position() - mouse_offset

func _button_down() -> void:
	mouse_offset = get_global_mouse_position() - global_position
	dragging = true

func _button_up() -> void:
	dragging = false
	
