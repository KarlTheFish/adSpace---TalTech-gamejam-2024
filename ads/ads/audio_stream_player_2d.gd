extends AudioStreamPlayer2D

@export var audioChance:float #Chance of obnoxious ad music playing

var r

func _ready() -> void:
	r = randf()
	print(r)
	if(r <= audioChance):
		play(0)

func _process(delta: float) -> void:
	if(playing != true && r <= audioChance):
		play(0)
