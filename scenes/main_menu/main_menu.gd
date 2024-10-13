extends Control

@export var play_button: TextureButton
@export var start_sound: AudioStreamPlayer

func _enter_tree() -> void:
	play_button.button_down.connect(start_sound.play)
	play_button.pressed.connect(_play_button_pressed)

func _play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/gameplay_scene.tscn")
