extends Node2D

@export var main_animation: AnimationPlayer

func _enter_tree() -> void:
	main_animation.animation_finished.connect(_move_to_main)

func _move_to_main(_anim: String) -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
