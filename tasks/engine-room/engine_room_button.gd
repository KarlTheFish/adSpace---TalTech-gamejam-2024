class_name EngineRoomButton extends TextureButton

signal symbol_sent(symbol: String)

const COLORS: Dictionary = {
	"⬜": Color.YELLOW,
	"◯": Color.GREEN,
	"△": Color.RED,
	"╳": Color.BLUE,
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

func _button_up() -> void:
	position.y -= 3
	symbol_sent.emit(symbol)
