extends TextureButton

var isFlashing:bool = true
@export var ad_flash_timer:Timer

var flashOn:bool
signal okButtonPressed()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ad_flash_timer.timeout.connect(_timer_done)
	flashOn = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _timer_done():
	flashOn = not flashOn
	if(flashOn == true):
		set_self_modulate("73ff00")
	else:
		set_self_modulate("ffffff")

func _pressed() -> void:
	emit_signal("okButtonPressed")
