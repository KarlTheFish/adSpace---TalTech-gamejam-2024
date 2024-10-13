extends TaskArea

# A YELLOW
# B GREEN
# C BLUE
# D RED

const SYMBOLS: Array[String] = [
	"A",
	"B",
	"C",
	"D",
]

@export var label: Label
@export var buttons_parent: Node2D

var code = "":
	set(val):
		code = val
		if (is_instance_valid(label)):
			label.text = code

func _ready() -> void:
	for child in buttons_parent.get_children():
		if (child is not EngineRoomButton):
			continue
		var button:= child as EngineRoomButton
		button.symbol_sent.connect(_symbol_received)

func _symbol_received(symbol: String) -> void:
	if (code[0] == symbol):
		code = code.trim_prefix(symbol)
		if (code.length() == 0):
			EventBus.task_completed.emit(task_name)
			task_complete = true
			toggle_task_visibility()
	else:
		restart_task()

func restart_task() -> void:
	task_complete = false
	generate_code()
	assign_button_symbols()

func generate_code() -> void:
	code = ""
	for i in 4:
		code += SYMBOLS.pick_random()
	print(code)

func assign_button_symbols() -> void:
	# TODO: see if this throws error due to duping
	var temp_symbols = SYMBOLS.duplicate(true)
	for child in buttons_parent.get_children():
		if (child is not EngineRoomButton):
			continue
		var button:= child as EngineRoomButton
		var s: String = temp_symbols.pick_random()
		button.symbol = s
		temp_symbols.erase(s)
