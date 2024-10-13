class_name EngineRoomButton extends TextureButton

@export var audio: AudioStreamPlayer

signal symbol_sent(symbol: String)

const COLORS: Dictionary = {
	"A": Color.GREEN,
	"B": Color.YELLOW,
	"C": Color.BLUE,
	"D": Color.RED,
}

var symbol: String = "":
	set(val):
		symbol = val
		if (symbol in COLORS.keys()):
			modulate = COLORS[symbol]

func _ready() -> void:
	button_down.connect(_button_down)
	button_up.connect(_button_up)

func _button_down() -> void:
	position.y += 3
	audio.play()

func _button_up() -> void:
	position.y -= 3
	symbol_sent.emit(symbol)
